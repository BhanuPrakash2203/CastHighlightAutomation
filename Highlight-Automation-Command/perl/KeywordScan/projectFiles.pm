package KeywordScan::projectFiles;

use strict;
use warnings;

use KeywordScan::detection;
use KeywordScan::Count;
use Encode;

my $APPLI_DATA = ();
my $DEBUG = 0;

my @file_idx;

sub detect($) {
	my $file = shift;
    print $file."\n" if ($DEBUG);
	my $H_DETECTORS = KeywordScan::detection::getKeywordDetectors();
	
	my $file_idx;

	if ($file =~ /(.*[\\\/])?([^\\\/]+)$/) 
    {
		# my $path = $1||"";
		my $basename = $2;
        
        if ($basename =~ /(.+)\.([^\.]*)$/) 
        {
            my $nameFile = $1;
			my $ext = $2;

            for my $detectorName (keys %{$H_DETECTORS}) 
            {
                my $detector = $H_DETECTORS->{$detectorName};

                for my $keyword (@{$detector->{T_KEYWORDS_DESCRIPTION}}) 
                {
                    my $keywordGroup = $keyword->[0];
                    my $data = $keyword->[1];

                    ############################################
                    ############## SEARCH ITEMS ##############                    
					for my $id (keys %{$data->{'searchItem'}}) 
                    {
					
						# CREATE NEW ENTRY FOR CSV
						$APPLI_DATA = KeywordScan::detection::addAppliDetection($detectorName, $id);
						
                        my $searchItem;
                        # my $dirnamePattern = '.*';
						# print "ID=".$id."\n";
						# sleep(1);
						# use Data::Dumper;
						# use Data::Dump::Streamer;
						# print Dumper $data->{'searchItem'}->{$id};
					   
                        for my $searchItem (@{$data->{'searchItem'}->{$id}})
                        {     

							my ($pattFileNameRegex, $pattFileContentRegex) = RegexGeneratorNew($searchItem);
							
							# print "pattFileNameRegex=$pattFileNameRegex\n";
							# print "pattFileContentRegex=$pattFileContentRegex\n";
							# sleep(1);
							
							if (defined $pattFileNameRegex and $basename =~ /$pattFileNameRegex/)
							{
								# use Data::Dumper;
								# use Data::Dump::Streamer;
								# print Dumper $searchItem;
								
								# print "filename:$id=".$searchItem->{'filename'}."\n";
								# print "content:$id=".$searchItem->{'content'}."\n" if (defined $searchItem->{'content'});
								# print "weight:$id=".$searchItem->{'weight'}."\n";
								# print "full_word:$id=".$searchItem->{'full_word'}."\n";
								# print "sensitive:$id=".$searchItem->{'sensitive'}."\n";

								if (! defined $pattFileContentRegex)
								{
									$file_idx = KeywordScan::detection::setCurrentFileNew($detectorName, $file);
									print "FILE DETECTION: $file_idx<$nameFile.$ext>$keywordGroup:$id found\n" if ($DEBUG); 
									
									$detector->addFileDetectionNew($file_idx, $keywordGroup, $id, "1");
									push (@file_idx, $file_idx);
									$APPLI_DATA = KeywordScan::detection::addAppliDetection($detectorName, $id);
								}
								else
								{
                                    # For managing file encodings and accent characters in pattern regex
                                    my $encodings = ['latin1', 'UTF-8'];
                                    open (FILE, "<", $file);
                                    my $buffer;
                                    while (my $line = <FILE>)
                                    { $buffer .= $line; }
                                    close FILE;
									for my $encoding (@$encodings) {
                                        $pattFileContentRegex = encode($encoding, $pattFileContentRegex);
                                        if ($buffer and $pattFileContentRegex and $buffer =~ /$pattFileContentRegex/)
                                        {
											$file_idx = KeywordScan::detection::setCurrentFileNew($detectorName, $file);
											print "FILE CONTENT DETECTION: $file_idx<$nameFile.$ext>$keywordGroup:$id pattern=$pattFileContentRegex found\n" if ($DEBUG);

											$detector->addFileDetectionNew($file_idx, $keywordGroup, $id, "1");
											push (@file_idx, $file_idx);
											$APPLI_DATA = KeywordScan::detection::addAppliDetection($detectorName, $id);
                                            last;
                                        }
                                    }
								}
							}
						}
                    }
                }
            }
        }
	}
}

sub postAnalysisDetection()
{
    # KeywordScan::Count::applyFormula($APPLI_DATA);
    KeywordScan::Count::applyFormula(\@file_idx);
}

sub RegexGeneratorNew($)
{
    my $hash_properties = shift;

    my $pattFileNameRegex;
    my $pattFileContentRegex;
    
	my $filename = $hash_properties->{'filename'}; # mandatory
	my $content = $hash_properties->{'content'} if (defined $hash_properties->{'content'});
	my $regexContent = $hash_properties->{'regexContent'} if (defined $hash_properties->{'regexContent'});

    # Filename using wildcards <*> replaced by <.*>
    $filename =~ s/(?<!\.)\*\./\.\*\\\./g;
    $filename =~ s/(?<!\.)\*/\.\*/g;
	# Step for escaping characters automatically
    $content = quotemeta($content) if (defined $content);

	if (defined $hash_properties->{'sensitive'}	and $hash_properties->{'sensitive'} == 0)
	{
		$pattFileNameRegex = '(?i)';
		$pattFileContentRegex = '(?i)' if (defined $content || defined $regexContent);
	}
	
	if (defined $hash_properties->{'full_word'}	
	    and $hash_properties->{'full_word'} == 1)
	{
		# set full match
		$pattFileContentRegex .= "\\b$content\\b" if (defined $content);
	}
	else
	{
		# set partial match
		$pattFileContentRegex .= $content if (defined $content);
	}

    $pattFileContentRegex .= $regexContent if (defined $regexContent);
    # set full match for file name
    $pattFileNameRegex .= "\\b(?:$filename)\\b";

	if (defined $pattFileContentRegex)
	{
		return ($pattFileNameRegex, $pattFileContentRegex);
	}
	else
	{
		return ($pattFileNameRegex);
	}
}


sub RegexGenerator($$;$)
{
    my $hash_properties = shift;
    my $filenameItem = shift;
    my $filecontentItem = shift;
    my $mod = "";
    my $pattRegex;
    my $pattFileContentRegex;
    
    for my $property (keys %{$hash_properties}) 
    {
        if ($property eq 'sensitive' and $hash_properties->{$property} == 0)
        {
            print "     INSENSITIVE\n" if ($DEBUG);
            # set insensitive
            $mod .= 'i';
        }
        elsif ($property eq 'full_word')
        {
            if ($hash_properties->{$property} == 1)
            {
                print "     FULL MATCH\n" if ($DEBUG);
                # set full match
                $pattRegex = "\\b$filenameItem\\b"; 
                $pattFileContentRegex = "\\b$filecontentItem\\b" if ($filecontentItem); 
            }
            else
            {
                # set partial match
                $pattRegex = $filenameItem;                       
                $pattFileContentRegex = $filecontentItem  if ($filecontentItem);                       
            }
        }                            
    }
    
    return ($mod, $pattRegex, $pattFileContentRegex);
}

1;

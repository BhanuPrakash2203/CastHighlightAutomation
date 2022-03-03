package KeywordScan::Count;

use strict;
use warnings;

use Erreurs;
use KeywordScan::detection;
# use KeywordScan::config;
use KeywordScan::projectFiles;
# use KeywordScan::parseKeywordDescription;

# use constant BEGINNING_MATCH => 0;
# use constant FULL_MATCH => 1;

my $DEBUG = 0;
my %countPatterns;
my $XML_version;

sub setXmlVersion($)
{
	$XML_version = shift;
}

sub Count($$$) {
	my ($fichier, $vue, $compteurs, $techno) = @_ ;
	my $ret = 0;

	my $H_DETECTORS = KeywordScan::detection::getKeywordDetectors();
	
	for my $detectorName (keys %$H_DETECTORS) {
		
		if ($XML_version->{$detectorName} eq "keywordGroup")
		{
			my $file_idx = KeywordScan::detection::setCurrentFileNew($detectorName, $fichier);

			my $detector = $H_DETECTORS->{$detectorName};
			print "------------ $fichier / $detectorName ----------------\n" if ($DEBUG);
			for my $keyword (@{$detector->{T_KEYWORDS_DESCRIPTION}}) {
				print "KEYWORD : $keyword->[0]\n" if ($DEBUG);
				my $keywordGroup = $keyword->[0];
				my $data = $keyword->[1];

				my $sumKeyword;
				
				# add more views
				# by default search into text view (code + strings + comment)
				my $buffer = \$vue->{'text'};

				if (exists $data->{'scope'}) {
					if ($data->{'scope'} eq "code") {
						$buffer = \$vue->{'code'};
					}
					elsif ($data->{'scope'} eq "comment") {
						$buffer = \$vue->{'comment'};
					}
					elsif ($data->{'scope'} eq "string" && exists $vue->{'HString'}) {
						my $buffer_values;
						foreach my $value (values %{$vue->{'HString'}}) {
							$buffer_values .= $value."\n";
						}
						$buffer = \$buffer_values;
					}
				}

				if ((! defined $buffer ) || (!defined $$buffer)) {
					print STDERR "[KeywordScan::Count] ERROR Missing view <$data->{'scope'}>, keyword scan impossible \n";
					#$ret |= Couples::counter_add($compteurs, $MissingJSPComment__mnemo, Erreurs::COMPTEUR_ERREUR_VALUE );
					return $ret |= Erreurs::COMPTEUR_STATUS_VUE_ABSENTE;
				}

				my $mod = "";
				
				# calculate pattern occurrence 
				# using sensitive case / fullword / scope parameters
				for my $keywordID (keys %{$data->{'keywordItem'}}) 
				{

					for my $elt (@{$data->{'keywordItem'}->{$keywordID}})
					{
						my $pattern= $elt->[0];
						my $hash_properties = $elt->[1];
						my $pattRegex = "";

						$pattern =~ s/^\"//m;
						$pattern =~ s/\"$//m;

						($mod, $pattRegex) = KeywordScan::projectFiles::RegexGenerator($hash_properties, $pattern);

						$countPatterns{$file_idx}{$keywordGroup}{$keywordID} = () = $$buffer =~ /(?$mod)$pattRegex/g;
						# print "$file_idx:$keywordGroup:$keywordID: countPatterns $countPatterns{$file_idx}{$keywordGroup}{$keywordID}\n";
						
						# compute sum of items
						$sumKeyword += $countPatterns{$file_idx}{$keywordGroup}{$keywordID};
					}
				}

				# export value KeywordGroup
				print "AddFileDetection $file_idx, $keywordGroup, $sumKeyword\n\n" if ($DEBUG);
				$detector->addFileDetection($file_idx, $keywordGroup, $sumKeyword);
	 
			}
		}
	}

	return $ret;
}

sub applyFormula($)
{
    my $file_idx = shift;
	my $H_DETECTORS = KeywordScan::detection::getKeywordDetectors();
 
	for my $detectorName (keys %$H_DETECTORS) 
	{
	
		my $detector = $H_DETECTORS->{$detectorName};
		
		#--------------#
		# KEYWORDGROUP	#
		#--------------#
		for my $keyword (@{$detector->{T_KEYWORDS_DESCRIPTION}}) {
			print "KEYWORDGROUP : $keyword->[0]\n" if ($DEBUG);
			my $keywordGroup = $keyword->[0];
			my $data = $keyword->[1];
			my $formula;
			my $bool_eval = 0;
			
			if ($formula = $data->{'formula'})
			{
				my %result_formula;

				if ($formula eq "INVALID")
				{					
					for my $file_idx (@{$file_idx})
					{
						$result_formula{$file_idx}{$keywordGroup} = "-";
					}
				}
				else
				{
					my $formula_appli_level = $formula;
					my $bool_formula_appli_level = 0;
					#patternGroup version
					for my $file_idx (@{$file_idx})
					{
						my $formula_file_level = $formula;
						for my $searchID (keys %{$data->{'searchItem'}}) 
						{
							my $values = $detector->getFileValues($file_idx);

							if (defined $values->{$keywordGroup}->{$searchID} 
								and $values->{$keywordGroup}->{$searchID} > 0) 
							{
								$formula_file_level =~ s/\b$searchID\b/1/g;
								$formula_appli_level =~ s/\b$searchID\b/1/g;
							}
							else {
								$formula_file_level =~ s/\b$searchID\b/0/g;
								$formula_appli_level =~ s/\b$searchID\b/0/g;
							}
						}

						# Eval formula (FILE LEVEL)
						if (eval $formula_file_level)
						{						
							$result_formula{$file_idx}{$keywordGroup} = "TRUE";
							$bool_formula_appli_level = 1;
						}
						else
						{
							$result_formula{$file_idx}{$keywordGroup} = "FALSE";
						}
					}

					# Eval of formula (APPLICATION LEVEL)
					# if at least one file is displayed as TRUE
					if ($bool_formula_appli_level == 1)
					{
						$data->{'formula'} = "ok";
					}
					else {
						print "INVALID formula at application level: $formula_appli_level\n" if ($DEBUG);
						$data->{'formula'} = "ko";
					}
				}
				
				foreach my $file_idx (keys %result_formula)
				{
					foreach my $keywordGroup (keys %{$result_formula{$file_idx}})
					{
						$detector->addFileDetection($file_idx, $keywordGroup, $result_formula{$file_idx}{$keywordGroup});
					}
				}
			}
			else
			{
				# No formula => keep the origin counter value
			}
		}
	}    
}

1;

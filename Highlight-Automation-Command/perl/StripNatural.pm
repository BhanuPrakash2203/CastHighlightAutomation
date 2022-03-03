package StripNatural;
use strict;
use warnings ;
use Carp::Assert; # traces_filter_line
use Timing ; # timing_filter_line
use StripUtils;

# prototypes publics
sub StripNatural($$$$);

use StripUtils qw(
                  garde_newlines
                  warningTrace
                  configureLocalTraces
                  StringStore
                  dumpVueStrings
                 );

StripUtils::init('StripNatural', 0);

#-----------------------------------------------------------------------

my $blank = \&garde_newlines;

my $TEXT;
my $CODE="";
my $COMMENT = "";
my $MIX = "";

my $STRING_CONTEXT = { 
	'nb_distinct_strings' => 0,
	'strings_values' => {},
	'strings_counts' => {}
} ;
my $RT_STRINGS = $STRING_CONTEXT->{'strings_values'};


# COMMENTS FEATURE :
#-------------------
# kinds :
#   - Simple line	   : * ..... \n
#	or : /* ..... \n
sub parseLineComment($) {
	my $el = shift;
	my $spaces = $blank->($el);
	$CODE .= $spaces;
	$COMMENT .= $el;
	$MIX .= '/*';
	
	while ( $$TEXT =~ /\G(\n|[^\n]*)/gc) {
		$spaces = $blank->($1);
		if ($1 eq "\n") {
			$CODE .= $blank->($1);
			$COMMENT .= $1;
			$MIX .= "*/\n";
			return 0;
		}
		else {
			$CODE .= $blank->($1);
			$COMMENT .= $1;
			$MIX .= $1;
		}
	}
	print STDERR "Unterminated comment !!!\n";
	
	return 1;
}

# STRINGS FEATURES
#-----------------
# kinds: 
#  -  Single quote string  ''
#  -  Double quote string  ""
#
# Escape :
#     respectively \' \"
#
# Line Continuation :
#     allowed for all

# SINGLE QUOTE
sub parseSingleString($) {
	# my $id = shift;
	my $el = shift;
	my $spaces = $blank->($el);
	$COMMENT .= $spaces;
	$MIX .= $spaces;
	my $string_buffer = $1;
	my $CODE_padding = "";
	
	while ( $$TEXT =~ /\G(\\'|\'\'|'|\\"|\"\"|\"|\\\\|\\|\\\n|[^\\\'\"]*)/gc) {
		$spaces = $blank->($1);
		$CODE_padding .= $spaces;
		$COMMENT .= $spaces;
		# $MIX .= $spaces;
		
		if ($1 eq "'" or $1 eq '"') {
			$string_buffer .= $1;
			my $string_id = StringStore( $STRING_CONTEXT, $string_buffer );
			$CODE .= "$string_id".$CODE_padding;
			$MIX .= "$string_id".$CODE_padding;
			
# print "STRING = $string_buffer\n";
			return 0;
		}
 		elsif ($1 ne "\\\n") {
			# not a continuing line => update $string_buffer
			$string_buffer .= $1;
		}
	}
	print STDERR "Unterminated string !!!\n";
	print "==> ".substr($string_buffer, 0, 20)."...\n";
	return 1;
}

sub parseCode($$;$) {
	$TEXT = shift;
	my $options = shift;
	my $stopOnClosingAcco = shift || 0;
	
	my $err = 0;
	
	my $level = 1;
	while ( $$TEXT =~ /\G(\/\*|\*|\/|\'|\"|[^\'\"\/\*]*)/gc) {
    
		my $spaces = $blank->($1);
		
		if ($1 eq "'" or $1 eq '"') {
			$err = parseSingleString($1);
		}
		elsif ($1 eq '/*' or $1 eq '*') {
			$err = parseLineComment($1);
		}
		else {
			$CODE .= $1;
			$COMMENT .= $spaces;
            $MIX .= $1;
		}
		
		if ($err gt 0) {
			return 1;
		}
	}
	
	return  0;
}

# analyse du fichier
sub StripNatural($$$$)
{
    my ($filename, $vue, $options, $couples) = @_;
    my $b_timing_strip = ((defined Timing->isSelectedTiming ('Strip'))? 1 : 0);

    configureLocalTraces('StripNatural', $options); # traces_filter_line
    my $StripApexTiming = new Timing ('StripNatural', Timing->isSelectedTiming ('Strip'));
    $StripApexTiming->markTimeAndPrint('--init--') if ($b_timing_strip); # timing_filter_line
    
    
	# Init data
	$CODE = "";
    $COMMENT = "";
    $MIX = "";
    $STRING_CONTEXT = { 
		'nb_distinct_strings' => 0,
		'strings_values' => {},
		'strings_counts' => {}
	};
	$RT_STRINGS = $STRING_CONTEXT->{'strings_values'};
    
    # Start stripping ... 
    my $err = parseCode(\$vue->{'text'}, $options);
    
    $StripApexTiming->markTimeAndPrint('separer_code_commentaire_chaine') if ($b_timing_strip); # timing_filter_line

    $vue->{'comment'} = $COMMENT;
    $vue->{'HString'} = $RT_STRINGS;
    $vue->{'code_with_prepro'} = "";
    $vue->{'MixBloc'} = $MIX;
    $vue->{'agglo'} = "";                       
    StripUtils::agglomerate_C_Comments(\$MIX, \$vue->{'agglo'});
    $vue->{'MixBloc_LinesIndex'} = StripUtils::createLinesIndex(\$MIX);
    $vue->{'agglo_LinesIndex'} = StripUtils::createLinesIndex(\$vue->{'agglo'});

    if ( $err gt 0) {
      my $message = 'Fatal error when separating code/comments/strings';
      Erreurs::LogInternalTraces ('erreur', undef, undef, 'STRIP // ABORT_CAUSE_SYNTAX_ERROR', $message);
      return Erreurs::FatalError( Erreurs::ABORT_CAUSE_SYNTAX_ERROR, $couples, $message);
    }
    
    $vue->{'code'} = $CODE;
    if ( defined $options->{'--dumpstrings'})
    {
      dumpVueStrings(  $RT_STRINGS , $STDERR );
    }
    $StripApexTiming->dump('StripNatural') if ($b_timing_strip); # timing_filter_line
    return 0;
}

1; # Le chargement du module est okay.


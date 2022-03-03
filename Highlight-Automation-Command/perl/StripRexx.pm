package StripRexx;
use strict;
use warnings ;
use Carp::Assert; # traces_filter_line
use Timing ; # timing_filter_line
use StripUtils;

# prototypes publics
sub StripRexx($$$$);

use StripUtils qw(
                  garde_newlines
                  warningTrace
                  configureLocalTraces
                  StringStore
                  dumpVueStrings
                 );

StripUtils::init('StripRexx', 0);

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
#   - Simple line : -- ..... \n
#   - Multiline   : /* ..... */

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

sub parseMultilineLineComment($) {
	my $el = shift;
	my $spaces = $blank->($el);
	$CODE .= $spaces;
	$COMMENT .= $el;
	$MIX .= $el;
	
	while ( $$TEXT =~ /\G(\*\/|\*|[^*]*)/gc) {
		$spaces = $blank->($1);
		if ($1 eq '*/') {
			$CODE .= $blank->($1);
			$COMMENT .= $1;
			$MIX .= $1;
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
#  -  Simple quote string  ''
#  -  Double quote string  ""
#
# Escape :
#     respectively \' \" 
#
# Line Continuation :
#     allowed for all

# DOUBLE QUOTE
sub parseDblString($) {
	my $el = shift;
	my $spaces = $blank->($el);
	$COMMENT .= $spaces;
	$MIX .= $spaces;
	my $string_buffer = $1;
	my $CODE_padding = "";
	
	while ( $$TEXT =~ /\G(\"\"|"|\\\\|\\|\\\n|[^\\"]*)/gc) {
		$spaces = $blank->($1);
		$CODE_padding .= $spaces;
		$COMMENT .= $spaces;
		# $MIX .= $spaces;
		
		if ($1 eq '"') {
			$string_buffer .= $1;
			my $string_id = StringStore( $STRING_CONTEXT, $string_buffer );
			$CODE .= "$string_id".$CODE_padding;
			$MIX .= "$string_id".$CODE_padding;
			return 0;
		}
		elsif ($1 ne "\\\n") {
			# not a continuing line => update $string_buffer
			$string_buffer .= $1;
		}
	}
	print STDERR "Unterminated string !!!\n";
	return 1;
}

# SIMPLE QUOTE
sub parseSplString($) {
	my $el = shift;
	my $spaces = $blank->($el);
	$COMMENT .= $spaces;
	$MIX .= $spaces;
	my $string_buffer = $1;
	my $CODE_padding = "";
	
	while ( $$TEXT =~ /\G(\'\'|'|\\\\|\\|\\\n|[^\\']*)/gc) {
		$spaces = $blank->($1);
		$CODE_padding .= $spaces;
		$COMMENT .= $spaces;
		# $MIX .= $spaces;

		if ($1 eq "'") {
			$string_buffer .= $1;
			my $string_id = StringStore( $STRING_CONTEXT, $string_buffer );
			$CODE .= "$string_id".$CODE_padding;
			$MIX .= "$string_id".$CODE_padding;
			return 0;
		}
		elsif ($1 ne "\\\n") {
			# not a continuing line => update $string_buffer
			$string_buffer .= $1;
		}
	}
	print STDERR "Unterminated string !!!\n";
	return 1;
}

# TEMPLATE
# sub parseTplString($) {
	# my $el = shift;
	# my $spaces = $blank->($el);
	# $COMMENT .= $spaces;
	# my $string_buffer = $1;
	# my $CODE_padding = "";
	
	# while ( $$TEXT =~ /\G(\\`|`|\n|\\\n|[^\\`\n]*)/gc) {
		# $spaces = $blank->($1);
		# $COMMENT .= $spaces;
		# $CODE_padding .= $spaces;
		
		# if ($1 eq "`") {
			# $string_buffer .= $1;
			# my $string_id = StringStore( $STRING_CONTEXT, $string_buffer );
			# $CODE .= "$string_id".$CODE_padding;
			# $MIX .= "$string_id".$CODE_padding;
			# return 0;
		# }
		# elsif ($1 eq "\n") {
			# $string_buffer .= $1;
		# }
		# elsif ($1 ne "\\\n") {
			# # not a continuing line => update $string_buffer
			# $string_buffer .= $1;
		# }
		# else {
			# # $string_buffer note updated
		# }
	# }
	# print STDERR "Unterminated string !!!\n";
	# return 1;
# }

sub parseCode($$) {
	$TEXT = shift;
	my $options = shift;
	
	my $err = 0;
	
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
    
    my $prefixRegex =  qr /(~|\bqr\b|\bq\b|\bm\b)/;
	
	while ( $$TEXT =~ /\G((\s*$prefixRegex\s*\/)|\/\*|\/|\-\-|\-|\#|"|'|~|q|m|[^"'\/\-\#\~qm]+)/gc) {
    
        my $spaces = $blank->($1);

        my $code_fragment = $1;
        my $simpleRegexBegin = $2;
        my $prefixLineRegex = $3;
        
        # print "code_fragment: <" . $code_fragment.">\n";
        # print "simpleRegexBegin: " . $simpleRegexBegin."\n";
        # print "prefixLineRegex: " . $prefixLineRegex."\n";

        if ($1 eq '--' or $1 eq '#') {
			$err = parseLineComment($1);
		}
		elsif ($1 eq '/*') {
			$err = parseMultilineLineComment($1);
		}
		elsif ($1 eq '"') {
			$err = parseDblString($1);
		}
		elsif ($1 eq "'") {
			$err = parseSplString($1);
		}
        elsif (defined $prefixLineRegex)
        {
            if (defined $simpleRegexBegin) 
            {
                $CODE .= $simpleRegexBegin;
                $MIX .= $simpleRegexBegin;

                $err = parseRegExp('/',$TEXT);
            }
		}       
		# elsif ($1 eq "`") {
			# $err = parseTplString($1);
		# }
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

sub parseRegExp($$) 
{
    my $open = shift;
    my $textInput = shift;
    my $regexp = $open;
    $CODE .= $open;
    $MIX .= $open;
    
    #my $position = pos ($$textInput);

    while ($$textInput =~ /\G(\/|\n|[^\/\n]+)/gc)
    {
        if 
        (
            ($open eq '/' and $1 eq '/') 
        )
        {
            $CODE .= $1;
            $MIX .= $1;
            $regexp .= $1;
            # print 'Regexp detected <'.$regexp.">\n";
            return 0;
        }
        
        else
        {
            $CODE .= $1;
            $MIX .= $1;
            $regexp .= $1;
       }
    }
    
    print STDERR "[parseRegExp] Missing closing \/\n";
    return 1;
}

# analyse du fichier
sub StripRexx($$$$)
{
    my ($filename, $vue, $options, $couples) = @_;
    my $b_timing_strip = ((defined Timing->isSelectedTiming ('Strip'))? 1 : 0);

    configureLocalTraces('StripRexx', $options); # traces_filter_line
    my $stripRexxTiming = new Timing ('StripRexx', Timing->isSelectedTiming ('Strip'));
    $stripRexxTiming->markTimeAndPrint('--init--') if ($b_timing_strip); # timing_filter_line
    
    my $err = parseCode(\$vue->{'text'}, $options);
    
    $stripRexxTiming->markTimeAndPrint('separer_code_commentaire_chaine') if ($b_timing_strip); # timing_filter_line

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
    $stripRexxTiming->dump('StripRexx') if ($b_timing_strip); # timing_filter_line
    return 0;
}

1; # Le chargement du module est okay.


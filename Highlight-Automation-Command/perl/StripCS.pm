#----------------------------------------------------------------------#
#                 @ISOSCOPE 2008                                       #
#----------------------------------------------------------------------#
#       Auteur  : ISOSCOPE SA                                          #
#       Adresse : TERSUD - Bat A                                       #
#                 5, AVENUE MARCEL DASSAULT                            #
#                 31500  TOULOUSE                                      #
#       SIRET   : 410 630 164 00037                                    #
#----------------------------------------------------------------------#
# Ce fichier a ete l'objet d'un depot aupres de                        #
# l'Institut National de la Propriete Industrielle (lettre Soleau)     #
#----------------------------------------------------------------------#

# Composant: Plugin
# Ce paquetage fournit une separation du code et des commentaires d'un source
# C#

package StripCS;
# FIXME: voir localTrace...  use strict;

use warnings;

use Timing; # timing_filter_line
use Prepro;


sub StripCS($$$$);

#use StripUtils;
use StripUtils qw(
              ErrStripError
              garde_newlines
              warningTrace
              configureLocalTraces
              StringStore
              dumpVueStrings
             );

StripUtils::init('StripCS', 0);

# automate de tri du contenu du fichier en trois parties:
# 1/ code
# 2/ commentaires
# 3/ chaines
sub separer_code_commentaire_chaine($$)
{
    my ($source, $options) = @_;
    my $b_timing_strip = ((defined Timing->isSelectedTiming ('Strip'))? 1 : 0);
    my $stripJavaTiming = new Timing ('StripJava:separer_code_commentaire_chaine', Timing->isSelectedTiming ('Strip'));
    my $input_buffer = $$source;
    my $code = "";
    my $comment = "";
    my $Mix = "";
    my $state = 'INCODE' ;
    my $next_state = $state ;
    my $previous_state = $state ;
    my $expected_closing_pattern = '';  #........................... Caractere attendu en fin de pattern string/comment/code
    my $string_buffer = '';

    my %strings_values = () ;
    my %strings_counts = () ;
    my %hash_strings_context = (
      'nb_distinct_strings' => 0,
      'strings_values' => \%strings_values,
      'strings_counts' => \%strings_counts  ) ;
    my $string_context = \%hash_strings_context;

    $stripJavaTiming->markTimeAndPrint('--init--') if ($b_timing_strip); # timing_filter_line
    my @parts = split (  "([/*]+|@\"|\"+|\'|\n)" , $input_buffer );
    $stripJavaTiming->markTimeAndPrint('--split--') if ($b_timing_strip); # timing_filter_line
    my $stripJavaTimingLoop = new Timing ('StripJava internal Loop', Timing->isSelectedTiming ('Strip'));


    my %states_patterns = (
      'INCODE' =>  qr{\G(["]|/[*]|//|/|[*]|^\s*#|[^/*]+)}sm ,
      'INCOMMENT' => qr{\G([*]/|/|[*]|[^/*]*)}sm ,
      'INSTRING' => qr{\G(\"|[^\"]*)}sm ,
      'IN@STRING' => qr{\G(\"\"|\"|[^\"]*)}sm ,
      'IN#LINE' => qr{\G(.*)}sm ,
    );

	my $lastStringElement = "";

    my $nb_iter = $#parts ;
    #for (my $part = 0; $part<= $nb_iter; $part++)
    for my $partie ( @parts )
    {
      localTrace (undef, "Utilisation du buffer:                           " . $partie . "\n" ); # Erreurs::LogInternalTraces
      #$stripJavaTiming->markTimeAndPrint('--iter in split: ' . $part . '/' . $#parts  . '  --'); # timing_filter_line

      my $reg ;

      while (
        # Mettre a jour l'expression rationnelle en fonction du patterne,
        # a chaque iteration.
        $reg =  $states_patterns{$state} ,
        $partie  =~ m/$reg/g )
      {
        my $element = $1;  # un morceau de fichier petit
        next if ( $element eq '') ;
        my $blanked_element = $element ; # les retours a la ligne correspondant.
        #$stripJavaTimingLoop->markTimeAndPrint('--iter in split internal--'); # timing_filter_line
        $blanked_element = garde_newlines($blanked_element) ;
        #$blanked_element = '';
        #$blanked_element =~ s/\S/ /gsm ;
        #localTrace "debug_chaines",  "state: $state: working with  !!$element!! \n"; # Erreurs::LogInternalTraces
        if ( $state eq 'INCODE' )
        {
            if ( $element eq '/*' )
            {
                $next_state = 'INCOMMENT'; $previous_state = 'INCODE'; $expected_closing_pattern = '*/' ;
                $code .= ' ';    # Au moins un blanc a la place d'un commentaire ...
                $code .= $blanked_element ; $comment .= $element ;
                $Mix .= $element;
            }
            elsif ( $element eq '//' )
            {
                $next_state = 'INCOMMENT'; $previous_state = 'INCODE'; $expected_closing_pattern = "\n" ;
                $code .= $blanked_element ; $comment .= $element ;
                $Mix .= '/*';
            }
            elsif ( $element eq '"' )
            {
                $next_state = 'INSTRING'; $expected_closing_pattern = '"' ;
                $string_buffer = $element ; $previous_state = 'INCODE'; $comment .= $blanked_element ;
            }
            elsif ( $element eq '@"' )
            {
                $next_state = 'IN@STRING'; $expected_closing_pattern = '"' ;
                $string_buffer = $element ; $comment .= $blanked_element ;
            }
            elsif ( $element eq '\'' )
            {
                $next_state = 'INSTRING'; $expected_closing_pattern = '\'' ;
                $string_buffer = $element ; $comment .= $blanked_element ;
            }
            elsif ( $element =~ '\s*#' )
            {
                $next_state = 'IN#LINE'; $expected_closing_pattern = "\n" ;
                $code .= $element ; $comment .= $blanked_element ;
            }
            else {
                $code .= $element ; $comment .= $blanked_element ; $Mix .= $element;
            }
        }
        elsif ( $state eq 'INCOMMENT' )
        {
            # RQ: dans la vue Mix, tous les commentaires multilignes sont mis au format
            # monoligne, et les commentaires "//" sont transformes en "/* ... */".
            # Pour cette raison, les eventuelles sequences "/*" ou "*/" qui traineraient dans
            # un commentaire "//" sont supprimes ...

            #localTrace undef "receive: <$element>, waiting <$expected_closing_pattern> \n"; # Erreurs::LogInternalTraces
            if ( $element eq $expected_closing_pattern )
            {
                if ($expected_closing_pattern eq "\n") {
                   $Mix .= "*/\n";

                    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    # Apres un commentaire monoligne // on a forcement un retour a l'etat INCODE.
                    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                  $next_state = 'INCODE'; $expected_closing_pattern = '' ;
                } else { 
                  $Mix .= $element;
                  $next_state = $previous_state; $expected_closing_pattern = '' ;
                }
             
                $code .= $blanked_element ; $comment .= $element ;
            }
            else
            {
                # Suppression des "/*" et  "*/"  qui pourraient trainer ...

                $code .= $blanked_element ; $comment .= $element ;
                if ($element eq "\n")
                {
                  $Mix .= "*/\n/*";
                }
                else {
                  #if ( $element =~ m{\A[/*]+\z} )
                  my %aSupprimer =  (  '/' =>1,  '*'=>1,  '*/'=>1   );
                  #if ( ( $element eq '/'  ) || ( $element eq '*' ) || ( $element eq '*/' ) )
                  if ( exists $aSupprimer{$element} )
                  {
                    #$element = ' ';
                    $Mix .= ' ';
                  }
                  else
                  {
                    $Mix .= $element;
                  }

                  #$element =~ s/(\/\*|\*\/)/ /g ; # FIXME: consomme entre 2 et 3 secondes sur 20.
                  #$Mix .= $element;
                }
            }
        }
        elsif ( $state eq 'INSTRING' )
        {
            my $endStringEncountered = 0;
            if ($element eq $expected_closing_pattern ) {
				# if the last string element is not ending with a single backslash, then the string termination is not escaped.
				if ($lastStringElement !~ /(^|[^\\])(\\\\)*\\$/m) {
					$endStringEncountered = 1;
				}
			}

            if ($endStringEncountered)
            {
                $next_state = 'INCODE'; $expected_closing_pattern = '' ;
                $string_buffer .= $element ;
                #$code .= $blanked_element;
                $comment .= $blanked_element ;
#print STDERR "STRING : $string_buffer\n";
                my $string_id = StringStore( $string_context, $string_buffer );

                # Dans la vue "code", la chaine est remplace par CHAINE_<id>_<occurence> ...
                #$code .= $string_id . '_' . $nb ;
                # Finalement on ne concatene pas le numero d'occurence.
                $code .= $string_id ;
                $Mix .= $string_id ;
                $string_buffer = '';
                $lastStringElement = '';
            }
            else
            {
                #localTrace 'debug_chaines', "string_buffer:<- $string_buffer\n"; # Erreurs::LogInternalTraces
                $string_buffer .= $element ;
                # Dans ce cas, on ne repercute pas les blancs dans la vue code.
                #$code .= $blanked_element;
                $comment .= $blanked_element ;
                #localTrace 'debug_chaines', "string_buffer:-> $string_buffer\n"; # Erreurs::LogInternalTraces
                $lastStringElement = $element;
            }
        }
        elsif ( $state eq 'IN@STRING' ) #Experimental
        {
            #localTrace 'debug_chaines' ,  "sla:$sla:$sla2\n"; # Erreurs::LogInternalTraces
            #si la fin de chaine est precedee d'un nombre pair d'antislash:
            #il s'agit bien d'une fin de chaine.
            if ( ( $element eq $expected_closing_pattern ) )
            {
                $next_state = 'INCODE'; $expected_closing_pattern = '' ;
                $string_buffer .= $element ;
                #$code .= $blanked_element;
                $comment .= $blanked_element ;

                my $string_id = StringStore( $string_context, $string_buffer );
                # may be multilines string => so count new lines
                $blanked_element = garde_newlines($string_buffer) ;
                # Dans la vue "code", la chaine est remplace par CHAINE_<id>_<occurence> ...
                #$code .= $string_id . '_' . $nb ;
                # Finalement on ne concatene pas le numero d'occurence.
                $code .= $string_id.$blanked_element ;
                $Mix .= $string_id.$blanked_element;
                $string_buffer = '' ;
            }
            else
            {
                #localTrace 'debug_chaines', "string_buffer:<- $string_buffer\n"; # Erreurs::LogInternalTraces
                $string_buffer .= $element ;
                # Dans ce cas, on ne repercute pas les blancs dans la vue code.
                #$code .= $blanked_element;
                $comment .= $blanked_element ;
                #localTrace 'debug_chaines', "string_buffer:-> $string_buffer\n"; # Erreurs::LogInternalTraces
            }
        }
        elsif ( $state eq 'IN#LINE' )
        {
          if ($element eq "\n")
          {
            $next_state = 'INCODE'; $expected_closing_pattern = '' ;
            $code .= $element ; $comment .= $blanked_element ;
            $Mix .= $element;
          }
          elsif ( $element eq '/*' )
          {
              $next_state = 'INCOMMENT'; $previous_state='IN#LINE';$expected_closing_pattern = '*/' ;
              $code .= ' ';    # Au moins un blanc a la place d'un commentaire ...
              $code .= $blanked_element ; $comment .= $element ;
              $Mix .= $element;
          }
          elsif ( $element eq '//' )
          {
              $next_state = 'INCOMMENT'; $previous_state='IN#LINE';$expected_closing_pattern = "\n" ;
              $code .= $blanked_element ; $comment .= $element ;
              $Mix .= '/*';
          }
          else {
            $code .= $element ; $comment .= $blanked_element ;
            $Mix .= $element;
          }
        }
        # FIXME: gain de 5 secondes sur 18 en commentant la trace suivante.
        localTrace ('debug_stript_states', ' separer_code_commentaire_chaine, passage de ' . $state . ' vers ' . $next_state . ' sur !<<'  . $element . '>>!' . "\n") ; # Erreurs::LogInternalTraces
        #localTraceTab ('debug_stript_states', # Erreurs::LogInternalTraces
	#[ ' separer_code_commentaire_chaine, passage de ' , $state , ' vers ' , $next_state , ' sur !<<'  , $element , '>>!' , "\n" ]) ; # Erreurs::LogInternalTraces
        $state = $next_state;
      }
    }
    $stripJavaTiming->markTimeAndPrint('--done--') if ($b_timing_strip); # timing_filter_line
    my @return_array ;
    if (not $state eq 'INCODE')
    {
        if (not ($expected_closing_pattern eq "\n")) # tolerance pour les fin
        # de ligne manquante en fin de fichier dans un commentaire '//'
        {
            warningTrace undef,  "warning: fin de fichier en l'etat $state \n"; # Erreurs::LogInternalTraces
            if ( ($state eq 'INSTRING')
            || ($state eq 'INSTRING') )
            {
                warningTrace undef,  "chaine non termine:\n" . $string_buffer ."\n" ; # Erreurs::LogInternalTraces
            }
            @return_array =  ( \$code, \$comment, \%strings_values, \$Mix , 1);
            return \@return_array ;
        }
    }
    @return_array =  ( \$code, \$comment, \%strings_values, \$Mix , 0);
    return \@return_array ;
}


# Cette fonction est obsolete.
# Utiliser dumpVueStrings de StripUtils.pm
#sub dumpVueStrings($$)
#{
  #my ($rt_strings, $stream) = @_;
        #for( my $i =0; $i <= $#{@{$rt_strings}} ; $i++ )
        #{
            #print $stream "chaine:$i:$rt_strings->[$i]\n";
        #}
#}

# analyse du fichier
sub StripCS($$$$)
{
    my ($filename, $vue, $options, $couples) = @_;
    my $b_timing_strip = ((defined Timing->isSelectedTiming ('Strip'))? 1 : 0);
#print STDERR join ( "\n", keys ( %{$options} ) );
    configureLocalTraces('StripCS', $options); # Erreurs::LogInternalTraces
    my $stripJavaTiming = new Timing ('StripCS', Timing->isSelectedTiming ('Strip'));

    localTrace ('verbose',  "working with  $filename \n"); # Erreurs::LogInternalTraces
    my $text = $vue->{'text'};
    $stripJavaTiming->markTimeAndPrint('init') if ($b_timing_strip); # timing_filter_line

    my $ref_sep = separer_code_commentaire_chaine(\$text, $options);
    $stripJavaTiming->markTimeAndPrint('separer_code_commentaire_chaine') if ($b_timing_strip); # timing_filter_line

    my($buffer, $comments, $rt_strings, $MixBloc, $err) = @{$ref_sep} ;

    # Traitement des directives de compilation
    if ( check_paracco($buffer) == -1 ) {
print "APPEL du prepro !!!!!!\n";
      Prepro::Prepro($filename, $buffer, $vue);
    }

    $vue->{'comment'} = $$comments;
    $vue->{'HString'} = $rt_strings;
    $vue->{'code_with_prepro'} = $$buffer;
    $vue->{'MixBloc'} = $$MixBloc;
    $vue->{'agglo'} = "";
    StripUtils::agglomerate_C_Comments($MixBloc, \$vue->{'agglo'});

    # suppression des #define
    $$buffer =~ s/(\A|\n)[ \t]*#[ \t]*define[^\n]*/$1/g;
    $vue->{'code'} = $$buffer;

    # Suppression des directives de toutes les directives de compilation.
    # FIXME: !!!ATTENTION, si on laisse desactive la suppression des lignes prepro, on aura un effet de bord
    # FIXME: dans la fonction CountCS::CountFields(), dans laquelle il faudra donc reactiver le code
    # FIXME: de suppression des lignes prepro. !!!
    #$$buffer =~ s/#[ \t]*error[^\n]*//g;
    $$buffer =~ s/(\A|\n)[ \t]*#[^\n]*/$1/g;

    $vue->{'sansprepro'} = $$buffer;

    # Creation de la vue prepro_directive par extraction des directives de la vue code_with_prepro.
    $vue->{'prepro_directives'} = $vue->{'code_with_prepro'};
    $vue->{'prepro_directives'} =~ s/^[^#\n]*$//mg;

    if ( defined $options->{'--dumpstrings'})
    {
      dumpVueStrings(  $rt_strings , $STDERR );
    }
    $stripJavaTiming->dump('StripCS') if ($b_timing_strip); # timing_filter_line

    if ( $err gt 0) {
      my $message = 'Erreur fatale dans la separation des chaines et des commentaires';
      Erreurs::LogInternalTraces ('erreur', undef, undef, 'STRIP // ABORT_CAUSE_SYNTAX_ERROR', $message);
      return Erreurs::FatalError( Erreurs::ABORT_CAUSE_SYNTAX_ERROR, $couples, $message);
    }

    return 0;
}

sub check_paracco {

  my ( $buf ) = @_ ;

  my $para = 0;
  my $acco = 0;
  my $in_directive=0;
  while ( $$buf =~ /(.)/sg ) {

    my $carac = $1;

# On ne prend pas en compte les parentheses ou accolades qui sont dans des directives #region ou autre.
    if ($carac eq "#") {
      $in_directive=1;
    }
    if ($carac eq "\n") {
      $in_directive=0;
    }
    
    if ($in_directive == 0) {
      if ($carac eq "(") {
        $para++;
      }
      elsif ($carac eq "{") {
        $acco++;
      }
      elsif ($carac eq ")") {
        $para--;
      }
      elsif ($carac eq "}") {
        $acco--;
      }
    }

    if ( ($para < 0) || ($acco < 0) ) {
      print STDERR "CHECK_PARACCO KO\n";
      return -1;
    }
  }

  if ( ($para > 0) || ($acco > 0) ) {
    print STDERR "CHECK_PARACCO KO\n";
    return -1;
  }

  return 0;
}



1; # Le chargement du module est okay.


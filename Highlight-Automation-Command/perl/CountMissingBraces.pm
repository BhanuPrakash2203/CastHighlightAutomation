#------------------------------------------------------------------------------#
#                         @ISOSCOPE 2008                                       #
#------------------------------------------------------------------------------#
#               Auteur  : ISOSCOPE SA                                          #
#               Adresse : TERSUD - Bat A                                       #
#                         5, AVENUE MARCEL DASSAULT                            #
#                         31500  TOULOUSE                                      #
#               SIRET   : 410 630 164 00037                                    #
#------------------------------------------------------------------------------#
# Ce fichier a ete l'objet d'un depot aupres de                                #
# l'Institut National de la Propriete Industrielle (lettre Soleau)             #
#------------------------------------------------------------------------------#

# Composant: Plugin

package CountMissingBraces;
# les modules importes
use strict;
use warnings;
use Erreurs;

# prototypes publics
sub CountMissingBraces($$$);

#-------------------------------------------------------------------------------
# DESCRIPTION: Module de comptage des accolades manquantes pour les instructions de flot de controle.
#-------------------------------------------------------------------------------

sub CountMissingBraces($$$) {
  my ($fichier, $vue, $compteurs) = @_ ;
  my $status = 0;
  my $mnemo_MissingBraces = Ident::Alias_MissingBraces();
  my $nbr_MissingBraces = 0 ;

#  my $code = '';
#  if ( (exists $vue->{'prepro'}) && ( defined $vue->{'prepro'} ) ) {
#    $code = $vue->{'prepro'};
#    Erreurs::LogInternalTraces('DEBUG', $fichier, 1, $mnemo_MissingBraces, "utilisation de la vue prepro.\n");
#  }
#  else {
#    $code = $vue->{'code'};
#  }

  my $code = ${Vues::getView($vue, 'prepro', 'code')};

  if ( ! defined $code ) {
    $status |= Couples::counter_add($compteurs, $mnemo_MissingBraces, Erreurs::COMPTEUR_ERREUR_VALUE );
    return $status |= Erreurs::COMPTEUR_STATUS_VUE_ABSENTE;
  }

  # Suppression des imbrications de parentheses, afin de virer l'expression conditionnelle qui se trouve entre le mot cle structurel
  # et le debut de bloc qui est cense commencer par une accolade.
  while ( $code =~ s/(\([^\(\)]*\))/ /sg ) {}

  # Neutralisation des mots cles de directive de compilation, en les faisant preceder de '_'
  $code =~ s/(#\s*)(if|ifdef|ifndef|else|elif|elifdef|elifndef|endif)/$1_$2/sg;

  # baliser les identificateurs 'elsif' pour eviter de les reconnaitre a tord
  $code =~ s/\belsif\b/els_balise_if/sg ;

  # ne pas aggrafer les 'else if', mais aggrafer les 'else \n if'
  $code =~ s/\belse[ \t]+if\b/elsif/sg ;

  while ( $code =~ /\b((if|else|elsif|for|foreach|switch|do)\b\s*(\{?))/sg ) {
    my $line_number = TraceDetect::CalcLineMatch($code, pos($code)); # Erreurs::LogInternalTraces
    if ( $3 eq '' ) {
      $nbr_MissingBraces++ ;
      Erreurs::LogInternalTraces('TRACE', $fichier, $line_number, $mnemo_MissingBraces, $1); # Erreurs::LogInternalTraces
    }
    else {
      Erreurs::LogInternalTraces('DEBUG', $fichier, $line_number, $mnemo_MissingBraces, $1); # Erreurs::LogInternalTraces
    }
  }

  Erreurs::LogInternalTraces('DEBUG', $fichier, 1, $mnemo_MissingBraces, 'Nombre - while = $nbr_MissingBraces'); # Erreurs::LogInternalTraces

  my $nb_do = () = $code =~ /\bdo\b/sg;
  Erreurs::LogInternalTraces('DEBUG', $fichier, 1, $mnemo_MissingBraces, 'do total = $nb_do'); # Erreurs::LogInternalTraces

  my $nb_while_do = () = $code =~ /\bwhile\b\s*[^\s\{]/sg ;
  Erreurs::LogInternalTraces('DEBUG', $fichier, 1, $mnemo_MissingBraces, 'while(do) total = $nb_while_do'); # Erreurs::LogInternalTraces

  if ( $nb_while_do >= $nb_do ) {
    $nbr_MissingBraces = $nbr_MissingBraces + ($nb_while_do - $nb_do) ;
  }
  else {
    print STDERR "[CountMissingBraces] Erreur d'appariement do ... while\n";
    Erreurs::LogInternalTraces('ERROR', $fichier, 1, $mnemo_MissingBraces, 'Erreur d\'appariement do ... while'); # Erreurs::LogInternalTraces
  }

  Erreurs::LogInternalTraces('DEBUG', $fichier, 1, $mnemo_MissingBraces, $nbr_MissingBraces); # Erreurs::LogInternalTraces

  $status |= Couples::counter_add($compteurs, $mnemo_MissingBraces, $nbr_MissingBraces);

  return $status;
}


1;

#----------------------------------------------------------------------#
#                         @ISOSCOPE 2008                               #
#----------------------------------------------------------------------#
#               Auteur  : ISOSCOPE SA                                  #
#               Adresse : TERSUD - Bat A                               #
#                         5, AVENUE MARCEL DASSAULT                    #
#                         31500  TOULOUSE                              #
#               SIRET   : 410 630 164 00037                            #
#----------------------------------------------------------------------#
# Ce fichier a ete l'objet d'un depot aupres de                        #
# l'Institut National de la Propriete Industrielle (lettre Soleau)     #
#----------------------------------------------------------------------#

# Composant: Plugin
# Description: Ce paquetage permet d'effectuer des comptages pour le langage C#.

package AnaCS ;

use strict;
use warnings;



use StripCS;
use Vues;
use AnaUtils;
use Timeout;
use IsoscopeDataFile;

use CloudReady::CountDotnet;
use CloudReady::detection;

#sub Strip($$$;$)
#{
#  my ($fichier, $vue, $options) =@_ ;
#  #return  StripJava::StripJava ($fichier, $vue, $options) ;
#  return  StripCS::StripCS ($fichier, $vue, $options) ;
#}

#-------------------------------------------------------------------------------
# module de lancement du strip
#-------------------------------------------------------------------------------
sub Strip($$$$)
{
  my ($fichier, $vue, $options, $couples) =@_ ;
  my $status = 0;
  eval
  {
    $status = StripCS::StripCS($fichier, $vue, $options, $couples);
  };
  if ($@ )
  {
    Timeout::DontCatchTimeout();   # propagate timeout errors
    print STDERR "Erreur dans la phase Strip: $@ \n" ;
    $status = Erreurs::COMPTEUR_STATUS_PB_STRIP ;
  }

  #if (($fichier ne AnaUtils::DUMMYFILENAME) and defined $options->{'--strip'}) # dumpvues_filter_line
  if (defined $options->{'--strip'}) # dumpvues_filter_line
  {                                                                            # dumpvues_filter_line
    Vues::dump_vues( $fichier, $vue, $options);                                # dumpvues_filter_line
  }                                                                            # dumpvues_filter_line

  # FIXME: pour bientot :
  #if ($status & Erreurs::COMPTEUR_STATUS_FICHIER_NON_COMPILABLE)
  #{
  #  return $status;
  #}
  #
  #eval
  #{
  #  $status |= CountC_CPP_FunctionsMethodsAttributes::Parse($fichier, $vue, $couples, $options);
  #};
  #if ($@ )
  #{
  #  print STDERR "Erreur dans la phase Parsing: $@ \n" ;
  #  $status = Erreurs::COMPTEUR_STATUS_PB_STRIP ;
  #}
  #
  return $status;
}

#my @TableCounters =
#(
#  [ \&CountBinaryFile::CountBinaryFile , "\&CountBinaryFile::CountBinaryFile" ],
#  [ \&CountCommun::CountCommun , "\&CountCommun::CountCommun" ],
#  [ \&CountBreakLoop::CountBreakLoop , "\&CountBreakLoop::CountBreakLoop" ],
#  [ \&CountCS::CountKeywords , "\&CountCS::CountKeywords" ],
#  [ \&CountCS::CountBugPatterns , "\&CountCS::CountBugPatterns" ],
#  [ \&CountCS::CountAutodocTags , "\&CountCS::CountAutodocTags" ],
#  [ \&CountCS::CountRiskyFunctionCalls , "\&CountCS::CountRiskyFunctionCalls" ],
#  [ \&CountCS::CountMetrics , "\&CountCS::CountMetrics" ],
#  [ \&CountCS::CountIllegalThrows , "\&CountCS::CountIllegalThrows" ],
#  [ \&CountCommentedOutCode::CountCommentedOutCode , "\&CountCommentedOutCode::CountCommentedOutCode" ],
#  [ \&CountAssignmentsInConditionalExpr::CountAssignmentsInConditionalExpr , "\&CountAssignmentsInConditionalExpr::CountAssignmentsInConditionalExpr" ],
#  [ \&CountComplexConditions::CountComplexConditions , "\&CountComplexConditions::CountComplexConditions" ],
#  [ \&CountMissingBraces::CountMissingBraces , "\&CountMissingBraces::CountMissingBraces" ],
#  [ \&CountEmptyCatches::CountEmptyCatches , "\&CountEmptyCatches::CountEmptyCatches" ],
#  [ \&CountMagicNumbers::CountMagicNumbers , "\&CountMagicNumbers::CountMagicNumbers" ],
#  [ \&CountSuspiciousComments::CountSuspiciousComments , "\&CountSuspiciousComments::CountSuspiciousComments" ],
#  [ \&CountAndOr::CountAndOr , "\&CountAndOr::CountAndOr" ],
#  [ \&CountWords::CountWords , "\&CountWords::CountWords" ],
#  [ \&CountIfPrepro::CountIfPrepro , "\&CountIfPrepro::CountIfPrepro" ],
#  [ \&CountBadSpacing::CountBadSpacing , "\&CountBadSpacing::CountBadSpacing" ],
#  [ \&CountComplexOperands::CountComplexOperands , "\&CountComplexOperands::CountComplexOperands" ],
#  [ \&CountCommentsBlocs::CountCommentsBlocs , "\&CountCommentsBlocs::CountCommentsBlocs" ],
#  [ \&CountMultInst::CountMultInst , "\&CountMultInst::CountMultInst" ],
##    \&CountNode::CountNode,
#);



sub Count($$$$$)
{
    my (  $fichier, $vue, $options, $couples, $r_TableFonctions) = @_;
    my $status = 0;


    #$status = AnaUtils::Count( $fichier, $vue, $options, $couples, \@TableCounters);
    #$status = AnaUtils::Count( $fichier, $vue, $options, $couples, \@CS_Conf::table_Comptages);
    $status |= AnaUtils::Count( $fichier, $vue, $options, $couples, $r_TableFonctions);
    
	if (defined $options->{'--CloudReady'}) {
		CloudReady::detection::setCurrentFile($fichier);
		$status |= CloudReady::CountDotnet::CountDotnet( $fichier, $vue, $options, "CS");
	}
    
    return $status;
}


# Ces variables doivent etre globales dnas le cas nominal (dit nocrashprevent)
my $firstFile = 1;
my ($r_TableMnemos, $r_TableFonctions );
my $confStatus = 0;

sub FileTypeRegister ($)
{
  my ($options) = @_;

  if ($firstFile != 0)
  {
    #------------------ Chargement des comptages a effectuer -----------------------
    my $ConfigModul='CS_Conf';
    if (defined $options->{'--conf'}) {
      $ConfigModul=$options->{'--conf'};
    }

    $ConfigModul =~ s/\.p[ml]$//m;

    ($r_TableMnemos, $r_TableFonctions, $confStatus ) = AnaUtils::Read_ConfAnalyse($ConfigModul, $options);

    AnaUtils::load_ready();

    #------------------ Enregistrement des comptages a effectuer -----------------------
    $firstFile = 0;
    if (defined $options->{'--o'})
    {
        IsoscopeDataFile::csv_file_type_register("CS", $r_TableMnemos);
    }
    
	#------------------ init CloudReady detections -----------------------
	if (defined $options->{'--CloudReady'}) {
		CloudReady::detection::init($options, 'CS');
	}
  }

}


sub Analyse($$$$)
{
  my ( $fichier, $vue, $options, $couples) = @_;
  my $status =0;

  FileTypeRegister ($options);
  $status |= $confStatus;

#------------------ Lancement du strip -----------------------

  $status |= Strip( $fichier, $vue, $options, $couples);

  if ( Erreurs::isAborted($status) )
  {
    # si le strip genere une erreur fatale,
    # on ne fera pas de comptages
    return $status;
  }


  if (defined $options->{'--nocount'})
  {
    return $status;
  }


#------------------ Lancement des compteurs -----------------------

  if ($status == 0)
  {
    $status |= Count($fichier, $vue, $options, $couples, $r_TableFonctions);
  }
  else
  {
    print STDERR "$fichier : Echec de pre-traitement\n";
  }

  return $status ;
}

# Un alias
sub AnaCS($$$$)
{
    my ( $fichier, $vues, $options, $couples) = @_;
    return Analyse ( $fichier, $vues, $options, $couples);
}

1;



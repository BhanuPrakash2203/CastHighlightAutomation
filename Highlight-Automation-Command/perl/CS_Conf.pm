package CS_Conf;

use strict;
use warnings;
use Ident;

# Ne pas modifier ce fichier

# Composant: Plugin

our @table_Comptages = (

     [ Ident::Alias_AndOr(), 'CountAndOr', 'CountAndOr', \&CountAndOr::CountAndOr, 'APPEL', 1 ],
     [ Ident::Alias_AssignmentsInConditionalExpr(), 'CountAssignmentsInConditionalExpr', 'CountAssignmentsInConditionalExpr', \&CountAssignmentsInConditionalExpr::CountAssignmentsInConditionalExpr, 'APPEL', 1 ],
     [ Ident::Alias_BadSpacing(), 'CountBadSpacing', 'CountBadSpacing', \&CountBadSpacing::CountBadSpacing, 'APPEL', 1 ],
     [ Ident::Alias_HeterogeneousEncoding(), 'CountBinaryFile', 'CountBinaryFile', \&CountBinaryFile::CountBinaryFile, 'APPEL', 1 ],
     [ Ident::Alias_Break(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'APPEL', 1 ],
     [ Ident::Alias_MultipleBreakLoops(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'APPEL', 1 ],
     [ Ident::Alias_MissingBreakInSwitch(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'APPEL', 1 ],
     [ Ident::Alias_CommentedOutCode(), 'CountCommentedOutCode', 'CountCommentedOutCode', \&CountCommentedOutCode::CountCommentedOutCode, 'APPEL', 1 ],
     [ Ident::Alias_CommentBlocs(), 'CountCommentsBlocs', 'CountCommentsBlocs', \&CountCommentsBlocs::CountCommentsBlocs, 'APPEL', 1 ],
     [ Ident::Alias_BlankLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
     [ Ident::Alias_CommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
     [ Ident::Alias_AlphaNumCommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
     [ Ident::Alias_LinesOfCode(), 'CountLinesOfCode_SansPrepro', 'CountCommun', \&CountCommun::CountLinesOfCode_SansPrepro, 'APPEL', 1 ],
     [ Ident::Alias_ComplexConditions(), 'CountComplexConditions', 'CountComplexConditions', \&CountComplexConditions::CountComplexConditions, 'APPEL', 1 ],
     [ Ident::Alias_ComplexOperands(), 'CountComplexOperands', 'CountComplexOperands', \&CountComplexOperands::CountComplexOperands, 'APPEL', 1 ],
     [ Ident::Alias_Using(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_If(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Else(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_While(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_For(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Foreach(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Continue(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Switch(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Default(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Try(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Catch(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Exit(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Instanceof(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_New(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Case(), 'CountKeywords', 'CountCS', \&CountCS::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_IllegalThrows(), 'CountIllegalThrows', 'CountCS', \&CountCS::CountIllegalThrows, 'APPEL', 1 ],
     [ Ident::Alias_ParamTags(), 'CountAutodocTags', 'CountCS', \&CountCS::CountAutodocTags, 'APPEL', 1 ],
     [ Ident::Alias_SeeTags(), 'CountAutodocTags', 'CountCS', \&CountCS::CountAutodocTags, 'APPEL', 1 ],
     [ Ident::Alias_ReturnTags(), 'CountAutodocTags', 'CountCS', \&CountCS::CountAutodocTags, 'APPEL', 1 ],
     [ Ident::Alias_BugPatterns(), 'CountBugPatterns', 'CountCS', \&CountCS::CountBugPatterns, 'APPEL', 1 ],
     [ Ident::Alias_RiskyFunctionCalls(), 'CountRiskyFunctionCalls', 'CountCS', \&CountCS::CountRiskyFunctionCalls, 'APPEL', 1 ],
     [ Ident::Alias_FunctionMethodImplementations(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_Constructors(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_Properties(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_PublicAttributes(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_PrivateProtectedAttributes(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ClassImplementations(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_TotalParameters(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_WithTooMuchParametersMethods(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_BadClassNames(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_BadMethodNames(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_BadAttributeNames(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortClassNamesLT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortClassNamesHT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortMethodNamesLT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortMethodNamesHT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortAttributeNamesLT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ShortAttributeNamesHT(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ParentClasses(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_ParentInterfaces(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_BadDeclarationOrder(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_Finalize(), 'CountMetrics', 'CountCS', \&CountCS::CountMetrics, 'APPEL', 1 ],
     [ Ident::Alias_EmptyCatches(), 'CountEmptyCatches', 'CountEmptyCatches', \&CountEmptyCatches::CountEmptyCatches, 'APPEL', 1 ],
     [ Ident::Alias_IfPrepro(), 'CountIfPrepro', 'CountIfPrepro', \&CountIfPrepro::CountIfPrepro, 'APPEL', 1 ],
     [ Ident::Alias_LongLines80(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
     [ Ident::Alias_LongLines100(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
     [ Ident::Alias_LongLines132(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
     [ Ident::Alias_MagicNumbers(), 'CountMagicNumbers', 'CountMagicNumbers', \&CountMagicNumbers::CountMagicNumbers, 'APPEL', 1 ],
     [ Ident::Alias_MissingBraces(), 'CountMissingBraces', 'CountMissingBraces', \&CountMissingBraces::CountMissingBraces, 'APPEL', 1 ],
     [ Ident::Alias_MultipleStatementsOnSameLine(), 'CountMultInst', 'CountMultInst', \&CountMultInst::CountMultInst, 'APPEL', 1 ],
     [ Ident::Alias_SuspiciousComments(), 'CountSuspiciousComments', 'CountSuspiciousComments', \&CountSuspiciousComments::CountSuspiciousComments, 'APPEL', 1 ],
     [ Ident::Alias_Words(), 'CountWords', 'CountWords', \&CountWords::CountWords, 'APPEL', 1 ],
     [ Ident::Alias_DistinctWords(), 'CountWords', 'CountWords', \&CountWords::CountWords, 'APPEL', 1 ],

);

sub get_table_Comptages() {
  return \@table_Comptages;
}

our @table_Synth_Comptages = (
     [ Ident::Alias_VG(), 'CountVG', 'CountCS', \&CountCS::CountVG, 'APPEL', 1 ],

);

sub get_table_Synth_Comptages() {
  return \@table_Synth_Comptages;
}

1;

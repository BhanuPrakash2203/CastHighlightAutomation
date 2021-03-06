package ObjCpp_Conf;

use strict;
use warnings;
use Ident;

# Ne pas modifier ce fichier

# Composant: Plugin

our @table_Comptages = (
     [ Ident::Alias_AndOr(), 'CountAndOr', 'CountAndOr', \&CountAndOr::CountAndOr, 'ObjC', 1 ],
#     [ Ident::Alias_AsmLines(), 'CountAsm', 'CountAsm', \&CountAsm::CountAsm, 'APPEL', 1 ],
     [ Ident::Alias_AssignmentsInConditionalExpr(), 'CountAssignmentsInConditionalExpr', 'CountAssignmentsInConditionalExpr', \&CountAssignmentsInConditionalExpr::CountAssignmentsInConditionalExpr, 'ObjC', 1 ],
     [ Ident::Alias_BadSpacing(), 'CountBadSpacing', 'CountBadSpacing', \&CountBadSpacing::CountBadSpacing, 'ObjC', 1 ],
#     [ Ident::Alias_BasicTypeUses(), 'Count_C_BasicTypeUses', 'CountBasicTypeUses', \&CountBasicTypeUses::Count_C_BasicTypeUses, 'APPEL', 1 ],
     [ Ident::Alias_HeterogeneousEncoding(), 'CountBinaryFile', 'CountBinaryFile', \&CountBinaryFile::CountBinaryFile, 'APPEL', 1 ],
     [ Ident::Alias_Break(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'ObjC', 1 ],
#     [ Ident::Alias_MultipleBreakLoops(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'APPEL', 1 ],
#     [ Ident::Alias_MissingBreakInSwitch(), 'CountBreakLoop', 'CountBreakLoop', \&CountBreakLoop::CountBreakLoop, 'APPEL', 1 ],
#     [ Ident::Alias_WithTooMuchParametersMethods(), 'Count_Parameters', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_Parameters, 'APPEL', 1 ],
#     [ Ident::Alias_TotalParameters(), 'Count_Parameters', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_Parameters, 'APPEL', 1 ],
     [ Ident::Alias_ApplicationGlobalVariables(), 'Count_AppGlobalVar', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_AppGlobalVar, 'APPEL', 1 ],
#     [ Ident::Alias_FileGlobalVariables(), 'Count_FileGlobalVar', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_FileGlobalVar, 'APPEL', 1 ],
#     [ Ident::Alias_MultipleDeclarationsInSameStatement(), 'Count_MultipleDeclarationSameLine', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_MultipleDeclarationSameLine, 'APPEL', 1 ],
#     [ Ident::Alias_AssignmentsInFunctionCall(), 'Count_AssignmentsInFunctionCall', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_AssignmentsInFunctionCall, 'APPEL', 1 ],
#     [ Ident::Alias_ComplexMethodsLT(), 'Count_ComplexMethods', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_ComplexMethods, 'APPEL', 1 ],
#     [ Ident::Alias_ComplexMethodsHT(), 'Count_ComplexMethods', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_ComplexMethods, 'APPEL', 1 ],
#     [ Ident::Alias_Max_ComplexMethodsVg(), 'Count_ComplexMethods', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_ComplexMethods, 'APPEL', 1 ],
#     [ Ident::Alias_MultipleReturnFunctionsMethods(), 'Count_MultipleReturnFunctionsMethods', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_MultipleReturnFunctionsMethods, 'APPEL', 1 ],
#     [ Ident::Alias_VariableArgumentMethods(), 'Count_VarArg', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_VarArg, 'APPEL', 1 ],
     [ Ident::Alias_UninitializedLocalVariables(), 'Count_MultipleDeclarationSameLine', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_MultipleDeclarationSameLine, 'APPEL', 1 ],
     [ Ident::Alias_ObjCUninitializedLocalVariables(), 'CountVariable', 'ObjC::CountVariable', \&ObjC::CountVariable::CountVariable, 'ObjC', 1 ],
     [ Ident::Alias_FunctionMethodImplementations(), 'Count_C_Functions', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_C_Functions, 'APPEL', 1 ],
     [ Ident::Alias_ShortFunctionNamesLT(), 'Count_FunctionNaming', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_FunctionNaming, 'APPEL', 1 ],
#     [ Ident::Alias_ShortFunctionNamesHT(), 'Count_FunctionNaming', 'CountC_CPP_FunctionsMethodsAttributes', \&CountC_CPP_FunctionsMethodsAttributes::Count_FunctionNaming, 'APPEL', 1 ],
     [ Ident::Alias_CommentedOutCode(), 'CountCommentedOutCode', 'CountCommentedOutCode', \&CountCommentedOutCode::CountCommentedOutCode, 'ObjC', 1 ],
     [ Ident::Alias_CommentBlocs(), 'CountCommentsBlocs', 'CountCommentsBlocs', \&CountCommentsBlocs::CountCommentsBlocs, 'APPEL', 1 ],
#     [ Ident::Alias_BlankLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
#     [ Ident::Alias_CommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
#     [ Ident::Alias_AlphaNumCommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 1 ],
     [ Ident::Alias_LinesOfPrepro(), 'CountLinesOfCode', 'CountCommun', \&CountCommun::CountLinesOfCode, 'ObjC', 1 ],
     [ Ident::Alias_LinesOfCode(), 'CountLinesOfPrepro', 'CountCommun', \&CountCommun::CountLinesOfPrepro, 'APPEL', 1 ],
     [ Ident::Alias_ComplexConditions(), 'CountComplexConditions', 'CountComplexConditions', \&CountComplexConditions::CountComplexConditions, 'ObjC', 1 ],
     [ Ident::Alias_ComplexOperands(), 'CountComplexOperands', 'CountComplexOperands', \&CountComplexOperands::CountComplexOperands, 'ObjC', 1 ],
#     [ Ident::Alias_IncrDecrOperatorComplexUses(), 'CountComplexUsesOfIncrDecrOperator', 'CountComplexUsesOfIncrDecrOperator', \&CountComplexUsesOfIncrDecrOperator::CountComplexUsesOfIncrDecrOperator, 'APPEL', 1 ],
#     [ Ident::Alias_StructDefinitions(), 'CountUnionStruct', 'CountC', \&CountC::CountUnionStruct, 'APPEL', 1 ],
#     [ Ident::Alias_CPPKeywords(), 'CountCPPKeyWords', 'CountC', \&CountC::CountCPPKeyWords, 'APPEL', 1 ],
#     [ Ident::Alias_BadMacroNames(), 'CountMacroNaming', 'CountC', \&CountC::CountMacroNaming, 'APPEL', 1 ],
#     [ Ident::Alias_BadPtrAccess(), 'CountBadPtrAccess', 'CountC', \&CountC::CountBadPtrAccess, 'APPEL', 1 ],
     [ Ident::Alias_BugPatterns(), 'CountBugPatterns', 'CountCpp', \&CountCpp::CountBugPatterns, 'ObjC', 1 ],
#     [ Ident::Alias_Include(), 'CountKeywords', 'CountC', \&CountC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_While(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_For(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Continue(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Switch(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Default(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Case(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Goto(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Exit(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Malloc(), 'CountKeywords', 'CountCpp', \&CountC::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Calloc(), 'CountKeywords', 'CountCpp', \&CountC::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Strdup(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Free(), 'CountKeywords', 'CountCpp', \&CountC::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_New(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Delete(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
#     [ Ident::Alias_Open(), 'CountKeywords', 'CountC', \&CountC::CountKeywords, 'APPEL', 1 ],
#     [ Ident::Alias_Close(), 'CountKeywords', 'CountC', \&CountC::CountKeywords, 'APPEL', 1 ],
#     [ Ident::Alias_Fopen(), 'CountKeywords', 'CountC', \&CountC::CountKeywords, 'APPEL', 1 ],
#     [ Ident::Alias_Fclose(), 'CountKeywords', 'CountC', \&CountC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_If(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Else(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_StructDefinitions(), 'CountKeywords', 'CountCpp', \&CountCpp::CountKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Gets(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Scanf(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Strtrns(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Strlen(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Strecpy(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Streadd(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Snprintf(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Realpath(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Getpass(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_Getopt(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'ObjC', 1 ],
     [ Ident::Alias_find_first_of(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'APPEL', 1 ],
     [ Ident::Alias_NewArray(), 'CountRiskyKeywords', 'CountCpp', \&CountCpp::CountRiskyKeywords, 'APPEL', 1 ],
     [ Ident::Alias_MacroDefinitions(), 'CountConstantMacroDefinitions', 'CountCpp', \&CountCpp::CountConstantMacroDefinitions, 'ObjC', 1 ],
#     [ Ident::Alias_MultipleAssignments(), 'CountMultipleAssignments', 'CountC', \&CountC::CountMultipleAssignments, 'APPEL', 1 ],
     [ Ident::Alias_RiskyFunctionCalls(), 'CountRiskyFunctionCalls', 'CountCpp', \&CountCpp::CountRiskyFunctionCalls, 'ObjC', 1 ],
     [ Ident::Alias_HardCodedPaths(), 'CountHardCodedPaths', 'CountHardCodedPaths', \&CountHardCodedPaths::CountHardCodedPaths, 'ObjC', 1 ],
     [ Ident::Alias_IfPrepro(), 'CountIfPrepro', 'CountIfPrepro', \&CountIfPrepro::CountIfPrepro, 'APPEL', 1 ],
#     [ Ident::Alias_LongLines80(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
#     [ Ident::Alias_LongLines100(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
     [ Ident::Alias_LongLines120(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
#     [ Ident::Alias_LongLines132(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 1 ],
     [ Ident::Alias_MagicNumbers(), 'CountMagicNumbers', 'CountMagicNumbers', \&CountMagicNumbers::CountMagicNumbers, 'ObjC', 1 ],
     [ Ident::Alias_MissingBraces(), 'CountMissingBraces', 'CountMissingBraces', \&CountMissingBraces::CountMissingBraces, 'ObjC', 1 ],
     [ Ident::Alias_MissingBreakInCasePath(), 'CountMissingBreakInCasePath', 'CountMissingBreakInCasePath', \&CountMissingBreakInCasePath::CountMissingBreakInCasePath, 'ObjC', 1 ],
#     [ Ident::Alias_MissingDefaults(), 'CountMissingDefaults', 'CountMissingDefaults', \&CountMissingDefaults::CountMissingDefaults, 'APPEL', 0 ],
#     [ Ident::Alias_MissingFinalElses(), 'CountMissingFinalElses', 'CountMissingFinalElses', \&CountMissingFinalElses::CountMissingFinalElses, 'APPEL', 1 ],
     [ Ident::Alias_MultipleStatementsOnSameLine(), 'CountMultInst', 'CountMultInst', \&CountMultInst::CountMultInst, 'ObjC', 1 ],
#     [ Ident::Alias_Pragmas(), 'CountPragmas', 'CountPragmas', \&CountPragmas::CountPragmas, 'APPEL', 1 ],
#     [ Ident::Alias_SqlLines(), 'CountSql', 'CountSql', \&CountSql::CountSql, 'APPEL', 1 ],
     [ Ident::Alias_SuspiciousComments(), 'CountSuspiciousComments', 'CountSuspiciousComments', \&CountSuspiciousComments::CountSuspiciousComments, 'APPEL', 1 ],
     [ Ident::Alias_TernaryOperators(), 'CountTernaryOp', 'CountTernaryOp', \&CountTernaryOp::CountTernaryOp, 'ObjC', 1 ],
#     [ Ident::Alias_UncommentedEmptyStmts(), 'CountUncommentedEmptyStmts', 'CountUncommentedEmptyStmts', \&CountUncommentedEmptyStmts::CountUncommentedEmptyStmts, 'APPEL', 0 ],
     [ Ident::Alias_Words(), 'CountWords', 'CountWords', \&CountWords::CountWords, 'ObjC', 1 ],
     [ Ident::Alias_DistinctWords(), 'CountWords', 'CountWords', \&CountWords::CountWords, 'ObjC', 1 ],
     [ Ident::Alias_UnexpectedIvar(), 'CountUnexpectedIvar', 'ObjC::CountInterface', \&ObjC::CountInterface::CountUnexpectedIvar, 'APPEL', 1 ],
     [ Ident::Alias_ProtectedAttributes(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_PublicAttributes(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_PackageAttributes(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_BadLayout(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_PrivateAttributes(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_NewMethodDeclaration(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_BadObjCAttributeNames(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_Interface(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
   [ Ident::Alias_ShortObjcAttributName(), 'CountInterface', 'ObjC::CountInterface', \&ObjC::CountInterface::CountInterface, 'APPEL', 1 ],
     [ Ident::Alias_NegativeComparison(), 'CountCondition', 'ObjC::CountCondition', \&ObjC::CountCondition::CountCondition, 'APPEL', 1 ],
     [ Ident::Alias_BooleanPitfall(), 'CountCondition', 'ObjC::CountCondition', \&ObjC::CountCondition::CountCondition, 'APPEL', 1 ],
     [ Ident::Alias_UntaggedParameters(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_NewMethodImplementation(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_MissingBoxedOrLiteral(), 'CountMissingBoxedOrLiteral', 'ObjC::CountObjC', \&ObjC::CountObjC::CountMissingBoxedOrLiteral, 'APPEL', 1 ],
     [ Ident::Alias_NSLog(), 'CountKeywords', 'ObjC::CountObjC', \&ObjC::CountObjC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_PragmaMark(), 'CountKeywords', 'ObjC::CountObjC', \&ObjC::CountObjC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Import(), 'CountKeywords', 'ObjC::CountObjC', \&ObjC::CountObjC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_Scanf(), 'CountKeywords', 'ObjC::CountObjC', \&ObjC::CountObjC::CountKeywords, 'APPEL', 1 ],
#     [ Ident::Alias_ForwardClass(), 'CountKeywords', 'ObjC::CountObjC', \&ObjC::CountObjC::CountKeywords, 'APPEL', 1 ],
     [ Ident::Alias_WithoutInterfaceImplementation(), 'CountWithoutInterfaceImplementation', 'ObjC::CountObjC', \&ObjC::CountObjC::CountWithoutInterfaceImplementation, 'APPEL', 1 ],
     [ Ident::Alias_InstanciationWithNew(), 'CountFunctionCall', 'ObjC::CountFunctionCall', \&ObjC::CountFunctionCall::CountFunctionCall, 'APPEL', 1 ],
     [ Ident::Alias_UncheckedInit(), 'CountFunctionCall', 'ObjC::CountFunctionCall', \&ObjC::CountFunctionCall::CountFunctionCall, 'APPEL', 1 ],
     [ Ident::Alias_UnnecessaryBlockParameter(), 'CountBlock', 'ObjC::CountBlock', \&ObjC::CountBlock::CountBlock, 'APPEL', 1 ],
     [ Ident::Alias_UnnecessaryBlockreturnType(), 'CountBlock', 'ObjC::CountBlock', \&ObjC::CountBlock::CountBlock, 'APPEL', 1 ],
     [ Ident::Alias_WithMissingParameterNameBlock(), 'CountBlock', 'ObjC::CountBlock', \&ObjC::CountBlock::CountBlock, 'APPEL', 1 ],
     [ Ident::Alias_BadBlockNames(), 'CountBlock', 'ObjC::CountBlock', \&ObjC::CountBlock::CountBlock, 'APPEL', 1 ],
     [ Ident::Alias_BadObjCMethodNames(), 'CountNaming', 'ObjC::CountNaming', \&ObjC::CountNaming::CountNaming, 'APPEL', 1 ],
     [ Ident::Alias_BadObjCClassNames(), 'CountNaming', 'ObjC::CountNaming', \&ObjC::CountNaming::CountNaming, 'APPEL', 1 ],
     [ Ident::Alias_BadFileNames(), 'CountNaming', 'ObjC::CountNaming', \&ObjC::CountNaming::CountNaming, 'APPEL', 1 ],
     [ Ident::Alias_BadParameterNames(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_TotalObjCParameters(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_Implementation(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_ShortObjcClassName(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_ShortObjcMethodName(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
     [ Ident::Alias_ObjCMethodsImplementation(), 'CountFunction', 'ObjC::CountFunction', \&ObjC::CountFunction::CountFunction, 'APPEL', 1 ],
);

sub get_table_Comptages() {
  return \@table_Comptages;
}

our @table_Synth_Comptages = (
	#[ Ident::Alias_VG(), 'CountVG', 'CountC', \&CountC::CountVG, 'APPEL', 1 ],

);

sub get_table_Synth_Comptages() {
  return \@table_Synth_Comptages;
}

1;

package PlSql_Conf;

use strict;
use warnings;
use Ident;

# Ne pas modifier ce fichier

# Composant: Plugin

our @table_Comptages = (

     [ Ident::Alias_CommentBlocs(), 'CountCommentsBlocs', 'CountCommentsBlocs', \&CountCommentsBlocs::CountCommentsBlocs, 'APPEL', 2 ],
     [ Ident::Alias_LinesOfCode(), 'CountLinesOfCode', 'CountCommun', \&CountCommun::CountLinesOfCode, 'APPEL', 2 ],
     [ Ident::Alias_BlankLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 0 ],
     [ Ident::Alias_CommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 2 ],
     [ Ident::Alias_AlphaNumCommentLines(), 'CountCommun', 'CountCommun', \&CountCommun::CountCommun, 'APPEL', 2 ],
     [ Ident::Alias_LongLines80(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 2 ],
     [ Ident::Alias_LongLines100(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 2 ],
     [ Ident::Alias_LongLines132(), 'CountLongLines', 'CountLongLines', \&CountLongLines::CountLongLines, 'APPEL', 2 ],
     [ Ident::Alias_SuspiciousComments(), 'CountSuspiciousComments', 'CountSuspiciousComments', \&CountSuspiciousComments::CountSuspiciousComments, 'APPEL', 2 ],
     #[ Ident::Alias_FunctionImplementations_old(), 'Count_Methods', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Methods, 'APPEL', 0 ],
     #[ Ident::Alias_PublicFonctionsProcedures(), 'Count_Methods', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Methods, 'APPEL', 0 ],
     #[ Ident::Alias_ProcedureImplementations_old(), 'Count_Methods', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Methods, 'APPEL', 0 ],
     #[ Ident::Alias_FunctionDeclarations_old(), 'Count_Methods', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Methods, 'APPEL', 0 ],
     #[ Ident::Alias_ProcedureDeclarations_old(), 'Count_Methods', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Methods, 'APPEL', 0 ],
     #[ Ident::Alias_WithTooMuchParametersMethods_old(), 'Count_Parameters', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Parameters, 'APPEL', 0 ],
     #[ Ident::Alias_TotalParameters(), 'Count_Parameters', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Parameters, 'APPEL', 0 ],
     #[ Ident::Alias_FunctionOutParameters(), 'Count_Parameters', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Parameters, 'APPEL', 0 ],
     #[ Ident::Alias_ImplicitInParameters(), 'Count_Parameters', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Parameters, 'APPEL', 0 ],
     #[ Ident::Alias_ZeroParameterProcedures(), 'Count_Parameters', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::Count_Parameters, 'APPEL', 0 ],
     #[ Ident::Alias_ExternalReferences(), 'CountExternalReferences', 'PlSql::ParseByOffset', \&PlSql::ParseByOffset::CountExternalReferences, 'APPEL', 0 ],
     [ Ident::Alias_Sql_Alter(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_And(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Binary_Integer(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Boolean(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Char(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Char_Base(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Close(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Commit(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Connect(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Create(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Cursor(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Declare(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Delete(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Do(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Drop(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Else(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Elsif(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Exception(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Execute(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Exit(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Fetch(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Float(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_For(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Forall(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Function(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Goto(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_If(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Insert(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Integer(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Long(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Loop(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Natural(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Naturaln(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Number(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Open(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Or(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Others(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Package(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Pls_Integer(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Positive(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Positiven(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Private(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Procedure(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Public(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Raise(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Real(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Return(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Rollback(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Row(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Rowid(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Select(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Smallint(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Subtype(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Basex_Then(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Trigger(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Sql_Update(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Varchar(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Varchar2(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_While(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Clob(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Type_Lob(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Exception_Init(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Decode(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_Begin(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_Base_End(), 'CountKeywords', 'PlSql::CountKeywords', \&PlSql::CountKeywords::CountKeywords, 'APPEL', 2 ],
     [ Ident::Alias_LinesInSpec(), 'CountBody', 'PlSql::CountBody', \&PlSql::CountBody::CountBody, 'APPEL', 0 ],
     [ Ident::Alias_LinesOfCodeInSpec(), 'CountBody', 'PlSql::CountBody', \&PlSql::CountBody::CountBody, 'APPEL', 0 ],
     [ Ident::Alias_LinesInBody(), 'CountBody', 'PlSql::CountBody', \&PlSql::CountBody::CountBody, 'APPEL', 0 ],
     [ Ident::Alias_LinesOfCodeInBody(), 'CountBody', 'PlSql::CountBody', \&PlSql::CountBody::CountBody, 'APPEL', 0 ],
     [ Ident::Alias_Case(), 'CountCase', 'PlSql::CountCase', \&PlSql::CountCase::CountCase, 'APPEL', 2 ],
     [ Ident::Alias_CaseLike_Else(), 'CountCaseLikeElse', 'PlSql::CountCaseLikeElse', \&PlSql::CountCaseLikeElse::CountCaseLikeElse, 'APPEL', 2 ],
     [ Ident::Alias_CaseWhen(), 'CountCaseWhen', 'PlSql::CountCaseWhen', \&PlSql::CountCaseWhen::CountCaseWhen, 'APPEL', 2 ],
     [ Ident::Alias_ComplexConditions(), 'CountComplexConditions', 'PlSql::CountComplexConditions', \&PlSql::CountComplexConditions::CountComplexConditions, 'APPEL', 2 ],
     [ Ident::Alias_AndOr(), 'CountConditionsAndOr', 'PlSql::CountConditionsAndOr', \&PlSql::CountConditionsAndOr::CountConditionsAndOr, 'APPEL', 2 ],
     [ Ident::Alias_CommentedOutCode(), 'CountCommentedOutCode', 'PlSql::CountCommentedOutCode', \&PlSql::CountCommentedOutCode::CountCommentedOutCode, 'APPEL', 2 ],
     [ Ident::Alias_CompareToNull(), 'CountCompareToNull', 'PlSql::CountCompareToNull', \&PlSql::CountCompareToNull::CountCompareToNull, 'APPEL', 2 ],
     [ Ident::Alias_CompareToEmptyString(), 'CountCompareToNull', 'PlSql::CountCompareToNull', \&PlSql::CountCompareToNull::CountCompareToNull, 'APPEL', 2 ],
     [ Ident::Alias_Dbms_Sql_Parse(), 'CountDbms_Sql', 'PlSql::CountDbms_Sql', \&PlSql::CountDbms_Sql::CountDbms_Sql, 'APPEL', 2 ],
     [ Ident::Alias_Dbms_Sql_Open(), 'CountDbms_Sql', 'PlSql::CountDbms_Sql', \&PlSql::CountDbms_Sql::CountDbms_Sql, 'APPEL', 2 ],
     [ Ident::Alias_PackageBodyVariables(), 'CountPackageVariables', 'PlSql::CountPackageVariables', \&PlSql::CountPackageVariables::CountPackageVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithExit_ConditionalLoops(), 'CountWithExit_ConditionalLoops', 'PlSql::CountWithExit_ConditionalLoops', \&PlSql::CountWithExit_ConditionalLoops::CountWithExit_ConditionalLoops, 'APPEL', 2 ],
     [ Ident::Alias_ExceptionWhen(), 'CountExceptionWhen', 'PlSql::CountExceptionWhen', \&PlSql::CountExceptionWhen::CountExceptionWhen, 'APPEL', 2 ],
     [ Ident::Alias_GlobalVariables(), 'CountFileGlobalVariables', 'PlSql::CountFileGlobalVariables', \&PlSql::CountFileGlobalVariables::CountFileGlobalVariables, 'APPEL', 2 ],
     [ Ident::Alias_FunctionDeclarations(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_ProcedureDeclarations(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_ProcedureImplementations(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_AnonymousBlocs(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 0 ],
     [ Ident::Alias_BodyPackage(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_SpecPackage(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_NonObjectType(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_SpecObjectType(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_BodyType(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_TriggerImplementations(), 'CountFunctionsMethodsAttributes', 'PlSql::CountFunctionsMethodsAttributes', \&PlSql::CountFunctionsMethodsAttributes::CountFunctionsMethodsAttributes, 'APPEL', 2 ],
     [ Ident::Alias_TopLevelAnonymousBlocs(), 'CountTopLevelAnonymousBlocs', 'PlSql::CountTopLevelAnonymousBlocs', \&PlSql::CountTopLevelAnonymousBlocs::CountTopLevelAnonymousBlocs, 'APPEL', 2 ],
     [ Ident::Alias_FunctionImplementations(), 'CountFunctionImplementations', 'PlSql::CountFunctionImplementations', \&PlSql::CountFunctionImplementations::CountFunctionImplementations, 'APPEL', 2 ],
     [ Ident::Alias_IllegalException(), 'CountIllegalException', 'PlSql::CountIllegalException', \&PlSql::CountIllegalException::CountIllegalException, 'APPEL', 2 ],
     [ Ident::Alias_LocalVariables(), 'CountLocalVariables', 'PlSql::CountLocalVariables', \&PlSql::CountLocalVariables::CountLocalVariables, 'APPEL', 2 ],
     [ Ident::Alias_MagicNumbers(), 'CountMagicNumbers', 'PlSql::CountMagicNumbers', \&PlSql::CountMagicNumbers::CountMagicNumbers, 'APPEL', 2 ],
     [ Ident::Alias_MagicString(), 'CountMagicString', 'PlSql::CountMagicString', \&PlSql::CountMagicString::CountMagicString, 'APPEL', 2 ],
     [ Ident::Alias_MissingWhenOthers(), 'CountMissingWhenOthers', 'PlSql::CountMissingWhenOthers', \&PlSql::CountMissingWhenOthers::CountMissingWhenOthers, 'APPEL', 2 ],
     [ Ident::Alias_Default(), 'CountMissingWhenOthers', 'PlSql::CountMissingWhenOthers', \&PlSql::CountMissingWhenOthers::CountMissingWhenOthers, 'APPEL', 2 ],
     [ Ident::Alias_MultipleInstructions(), 'CountMultipleInstructions', 'PlSql::CountMultipleInstructions', \&PlSql::CountMultipleInstructions::CountMultipleInstructions, 'APPEL', 2 ],
     [ Ident::Alias_WithoutFinalReturn_Functions(), 'CountReturnRoutines', 'PlSql::CountReturnRoutines', \&PlSql::CountReturnRoutines::CountReturnRoutines, 'APPEL', 2 ],
     [ Ident::Alias_WithReturnOutsideExceptionHandler_Procedure(), 'CountReturnRoutines', 'PlSql::CountReturnRoutines', \&PlSql::CountReturnRoutines::CountReturnRoutines, 'APPEL', 2 ],
     [ Ident::Alias_WithReturnOutsideExceptionHandler_Function(), 'CountReturnRoutines', 'PlSql::CountReturnRoutines', \&PlSql::CountReturnRoutines::CountReturnRoutines, 'APPEL', 2 ],
     [ Ident::Alias_RiskyCatches(), 'CountRiskyCatches', 'PlSql::CountRiskyCatches', \&PlSql::CountRiskyCatches::CountRiskyCatches, 'APPEL', 2 ],
     [ Ident::Alias_WithMissingParametersModes_Routines(), 'CountRoutinesParameters', 'PlSql::CountRoutinesParameters', \&PlSql::CountRoutinesParameters::CountRoutinesParameters, 'APPEL', 2 ],
     [ Ident::Alias_WithParametersModeOut_Functions(), 'CountRoutinesParameters', 'PlSql::CountRoutinesParameters', \&PlSql::CountRoutinesParameters::CountRoutinesParameters, 'APPEL', 2 ],
     [ Ident::Alias_WithTooMuchParametersMethods(), 'CountRoutinesParameters', 'PlSql::CountRoutinesParameters', \&PlSql::CountRoutinesParameters::CountRoutinesParameters, 'APPEL', 2 ],
     [ Ident::Alias_SignType(), 'CountSignType', 'PlSql::CountSignType', \&PlSql::CountSignType::CountSignType, 'APPEL', 2 ],
     [ Ident::Alias_ShortIdentifiers(), 'CountShortIdentifiers', 'PlSql::CountShortIdentifiers', \&PlSql::CountShortIdentifiers::CountShortIdentifiers, 'APPEL', 2 ],
     [ Ident::Alias_SqlLines(), 'CountSqlLines', 'PlSql::CountSqlLines', \&PlSql::CountSqlLines::CountSqlLines, 'APPEL', 2 ],
     [ Ident::Alias_NcharVariable(), 'CountTypeVariables', 'PlSql::CountTypeVariables', \&PlSql::CountTypeVariables::CountTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_Nvarchar2Variable(), 'CountTypeVariables', 'PlSql::CountTypeVariables', \&PlSql::CountTypeVariables::CountTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_ExceptionVariables(), 'CountTypeVariables', 'PlSql::CountTypeVariables', \&PlSql::CountTypeVariables::CountTypeVariables, 'APPEL', 0 ],
     [ Ident::Alias_BodyExceptionVariables(), 'CountAttributesExceptionVariables', 'PlSql::CountAttributesExceptionVariables', \&PlSql::CountAttributesExceptionVariables::CountAttributesExceptionVariables, 'APPEL', 2 ],
     [ Ident::Alias_SpecExceptionVariables(), 'CountAttributesExceptionVariables', 'PlSql::CountAttributesExceptionVariables', \&PlSql::CountAttributesExceptionVariables::CountAttributesExceptionVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithSqlCode_WhenOthers(), 'CountWithSqlCodeWhenOthers', 'PlSql::CountWithSqlCodeWhenOthers', \&PlSql::CountWithSqlCodeWhenOthers::CountWithSqlCodeWhenOthers, 'APPEL', 2 ],
     [ Ident::Alias_NotNullVariables(), 'CountWithNotNullParameterProcedures', 'PlSql::CountWithNotNullParameterProcedures', \&PlSql::CountWithNotNullParameterProcedures::CountWithNotNullParameterProcedures, 'APPEL', 2 ],
     [ Ident::Alias_WithoutPrecision_CharVariable(), 'CountWithoutConstraintByTypeVariables', 'PlSql::CountWithoutConstraintByTypeVariables', \&PlSql::CountWithoutConstraintByTypeVariables::CountWithoutConstraintByTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithoutPrecision_NcharVariable(), 'CountWithoutConstraintByTypeVariables', 'PlSql::CountWithoutConstraintByTypeVariables', \&PlSql::CountWithoutConstraintByTypeVariables::CountWithoutConstraintByTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithoutPrecision_VarcharVariable(), 'CountWithoutConstraintByTypeVariables', 'PlSql::CountWithoutConstraintByTypeVariables', \&PlSql::CountWithoutConstraintByTypeVariables::CountWithoutConstraintByTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithoutPrecision_Varchar2Variable(), 'CountWithoutConstraintByTypeVariables', 'PlSql::CountWithoutConstraintByTypeVariables', \&PlSql::CountWithoutConstraintByTypeVariables::CountWithoutConstraintByTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithoutPrecision_Nvarchar2Variable(), 'CountWithoutConstraintByTypeVariables', 'PlSql::CountWithoutConstraintByTypeVariables', \&PlSql::CountWithoutConstraintByTypeVariables::CountWithoutConstraintByTypeVariables, 'APPEL', 2 ],
     [ Ident::Alias_WithoutLabel_End(), 'CountWithoutLabel_End', 'PlSql::CountWithoutLabel_End', \&PlSql::CountWithoutLabel_End::CountWithoutLabel_End, 'APPEL', 2 ],
     [ Ident::Alias_WithoutParameter_Procedures(), 'CountWithoutParameterProcedures', 'PlSql::CountWithoutParameterProcedures', \&PlSql::CountWithoutParameterProcedures::CountWithoutParameterProcedures, 'APPEL', 2 ],
     [ Ident::Alias_WithSeveralExit_Loop(), 'CountWithSeveralExit_Loop', 'PlSql::CountWithSeveralExit_Loop', \&PlSql::CountWithSeveralExit_Loop::CountWithSeveralExit_Loop, 'APPEL', 2 ],
     [ Ident::Alias_WhenOthers(), 'CountWhenOthers', 'PlSql::CountWhenOthers', \&PlSql::CountWhenOthers::CountWhenOthers, 'APPEL', 2 ],
     [ Ident::Alias_WithoutSemiColumn_End(), 'CountWithoutSemiColumn_End', 'PlSql::CountWithoutSemiColumn_End', \&PlSql::CountWithoutSemiColumn_End::CountWithoutSemiColumn_End, 'APPEL', 2 ],
     [ Ident::Alias_Words(), 'CountWords', 'PlSql::CountWords', \&PlSql::CountWords::CountWords, 'APPEL', 2 ],
     [ Ident::Alias_DistinctWords(), 'CountWords', 'PlSql::CountWords', \&PlSql::CountWords::CountWords, 'APPEL', 2 ],

);

sub get_table_Comptages() {
  return \@table_Comptages;
}

our @table_Synth_Comptages = (
     [ Ident::Alias_VG(), 'CountVG', 'PlSql::SynthCount', \&PlSql::SynthCount::CountVG, 'APPEL', 2 ],

);

sub get_table_Synth_Comptages() {
  return \@table_Synth_Comptages;
}

1;
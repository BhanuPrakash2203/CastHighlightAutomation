
@ECHO OFF

REM ECHO *******************************************************
REM ECHO "HighLight analyzer & uploader script" 

REM Location of sources, each application folder must be named with the vallue set in the config file. TO BE UPDATED BEFORE USING THIS SCRIPT
SET PERL=C:\Program Files\CAST\HighlightAgent\strawberry\perl
SET analyzerDir=C:\Users\BBA\Desktop\HighlightAutomation\Highlight-Automation-Command\perl
SET SOURCES=C:\Users\BBA\Desktop\HighlightAutomation\Sources
SET login=email_id
SET pwd=Password
SET ignored_Dir=test,jquery,third-party,lib,3rd-party,COTS,external,node_modules,Tests,Test,Testing,t.ds,.flow.js,.git,.svn,gradlew,.vscode,Samples,.git,.svn, gradle, .circleci, .azure, .vscode
SET ignored_Files=.yaml, .gitignore,.gitmodules, Makefile, .npmignore, .checkstyle, build.xml, gradlew 
SET url=https://rpa.casthighlight.com
SET highlight_exe=C:\Users\BBA\Desktop\HighlightAutomation\Highlight-Automation-Command\HighlightAutomation.jar
SET Current_Folder=C:\Users\BBA\Desktop\HighlightAutomation
SET basicAuth=Yi5wcmFrYXNoK1NvbHZhdGhvbkBjYXN0c29mdHdhcmUuY29tOldlbGNvbWUxMjM0


REM Location of applications.txt file containg the list of apps to be scanned.

SET CONFIG=C:\Users\BBA\Desktop\HighlightAutomation\Config

SET RESULTATS=C:\Users\BBA\Desktop\HighlightAutomation\Resultats

ECHO ------------------------------------------------

ECHO highlight_exe : %highlight_exe%
ECHO CONFIG        : %CONFIG%
ECHO RESULTATS     : %RESULTATS%
ECHO Current_Folder: %Current_Folder%
ECHO perl: %PERL%
ECHO analyzerDir : %analyzerDir%
ECHO SOURCES: %SOURCES%
ECHO url: %url%

ECHO ------------------------------------------------


FOR /F "tokens=1,2,3* delims=; " %%a IN (%CONFIG%\applications.txt) DO (
ECHO ------------------------------------------------
ECHO ------------------------------------------------
ECHO Application name:"%%a"
ECHO Application ID:"%%b"
ECHO Company ID:"%%c"
ECHO ------------------------------------------------
ECHO ------------------------------------------------
REM	ECHO "#####" %%a "#####" %%b "#####" %%c "#####"

	REM romove existing logs : log file is created in the same location of this script
	IF EXIST %Current_Folder%\HLAutomation.log del %Current_Folder%\HLAutomation.log
	IF NOT EXIST %RESULTATS%\%%a mkdir %RESULTATS%\%%a

    REM	ECHO STARTING ANALYZE %%a
		
	 cd \	 
	 cd  C:\Automation_HL
	REM OPTION 2: Scan and UPLOAD
	ECHO %SOURCES%\%%a
	IF EXIST %SOURCES%\%%a (
	  REM java -jar %highlight_exe% --workingDir="%RESULTATS%\%%a" --sourceDir="%SOURCES%\%%a" --analyzerDir="%analyzerDir%" --serverUrl "%url%" --login "%login%" --password "%pwd%" --applicationId %%b --companyId %%c 	--ignoreDirectories "%ignored_Dir%" --ignoreFiles "%ignored_Files%"
	  java -jar %highlight_exe% --workingDir="%RESULTATS%\%%a" --sourceDir="%SOURCES%\%%a" --analyzerDir="%analyzerDir%" --serverUrl "%url%" --basicAuth %basicAuth% --applicationId %%b --companyId %%c --ignoreDirectories "%ignored_Dir%" --ignoreFiles "%ignored_Files%"
	 ) ELSE ( ECHO Source not present)
	 
	REM copy the log file to the workspace
	call :moveFile %%a

)

goto:End

:moveFile

	IF EXIST %RESULTATS%\%appli%\HLAutomation.log  move  %RESULTATS%\%appli%\HLAutomation.log  %Current_Folder%\HLAutomation_%appli%_%temps%.log

	goto :eof
	
:End    


pause

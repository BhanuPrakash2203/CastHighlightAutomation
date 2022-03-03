Using Highlight Excel Aotomation command: https://doc.casthighlight.com/import-export-apps-domains-users-bulk-excel/

1. Use below command to Export the as is data from Highlight Portal
java -jar Highlight-Excel-5.3.50-RELEASE.jar export --host=https://rpa.casthighlight.com/WS2/domains/<company_id> --login=b.prakash+lti@castsoftware.com --password=<Password> --file=Highlight-Excel_lti.xlsx

2. Use below command to Import the domain,application, User data to Highlight Portal
java -jar Highlight-Excel-5.3.50-RELEASE.jar import --host=https://rpa.casthighlight.com/WS2/domains/<company_id> --login=b.prakash+lti@castsoftware.com --password=<Password> --file=Highlight-Excel_lti.xlsx 

Automating Upload of Source code into HighLight.

1) Under Config folder there is a file "applications.txt". In this file make entries for applications to be uploaded into highlight. 
Data should be entered in below format.
application_name;application_id;company/domain_id

2) Company Id can be taken from Highlight portal from  Manage-Application Menu.
Application IDs along with application names can be extracted using below rest URI:
 https://rpa.casthighlight.com/WS2/domains/<company_id>/applications
 
Below online tool can be used to convert JSON to CSV
https://www.convertcsv.com/json-to-csv.htm

3) Keep Source code which is to be uploaded into HighLight analyzer in "Sources" folder or make changes to upload.bat, give value for following parameters.
   
		SET PERL= "Give location of PERL" ------ignore this parameter if getting ERR6 : "Directory containing perl script for analyzer should exist"
		SET analyzerDir="Give location of PERL"  ----Alternate directory for Highlight's analyzer scripts. Use this parameter if getting ERR6
 		SET SOURCES="Give location of Source Code to be scanned"
		SET login = "Give user id"
		SET pwd = "Give Password"
		SET ignored_Dir ="Give Directories to be ignored"
		SET ignored_Files="Give Files which are to be ignored"
		SET url = "Give Highlight URL"
		SET highlight_exe ="Path of HighlightAutomation.jar"
		SET Current_Folder ="Location of Automation_HL folder"
		SET RESULTATS ="Path of "Resultats" Folder"
		SET --basicAuth="BasicAuth value <=> Base64 encode of   login:password" -- use any online tool to do base64 encoding https://www.base64encode.org/ or Notepad++

4) There is a "Resultats" Folder which will have a 
    
	 a)HLTemporary folder which contains .csv files of analysis. 
	 b)Automation Log - Which can be used to see the errors if any  .

5) Run Upload.Bat file
Upload file consists of below command:
java -jar %highlight_exe% --workingDir="%RESULTATS%\%%a" --sourceDir="%SOURCES%\%%a" --analyzerDir="%analyzerDir%" --serverUrl "%url%" --login "%login%" --password "%pwd%" --applicationId %%b --companyId %%c 	  --ignoreDirectories "%ignored_Dir%" --ignoreFiles "%ignored_Files%"
Above command will iterate for each folder found inside "Sources" folder

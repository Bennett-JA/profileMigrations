Prerequisites:
Devices need to be on a known network that has been configured as part of the pre-provisioning package

WIndows10/11 Professional or enterprise edition

Tools
ForensiT User Profile Wizard - Download
ForensIT Guide - User Profile Wizard Corporate User Guide.pdf (forensit.com)
PREREQUISITES
Must have Corp Edition
Access to AMC Global admin account for Client
Ensure Azure AD join is configured in AAD

1.
Get Azure User list
Go to GitHub - ForensiT/PowerShell: PowerShell scripts for ForensiT tools
Download and run the Save-AzureADusers.ps1 script
sign in with amc client account when prompted
If unable to run from your computer sign into a client device with amc creds and run the script
after the script has been run you will have a list of all users in Azure AD
Provisioning package

2.
Create a provisioning package
open the windows store and search for windows configuration Designer and download it
open WCD and Select provision desktop devices and give the project a name
Run through the steps until you get to Account Management
Once at account Management select Enroll in Azure AD
Click Get Bulk Token
Sign in with amc client account
you will see a prompt asking to allow org to manage devices uncheck the box and select No, sign in to this app only (VERY IMPORTANT STEP IF NOT DONE CORRECTLY PROVISIONING PACKAGE WILL NOT WORK)
after selecting No, Sign in to this app only you will see bulk token fetched successfully
finish running through the WCD
Note if you dont want to rename the devices check out page 39-40
Once done open Advanced editor
Under connectivityProfiles add any additional wifi networks to the WLAN settings


3.
Creating account lookup CSV file
This is a bit of a manual process
open note or excel (if done in excel you do not need a comma)
Get the user name of users on the old domain
match the users old domain name to the new one separted by a comma
ex wlee,wlee@upauto.com
save that file
Run command to pull list of users with username and UPN 
get-aduser -filter * | select-object samaccountname, userprincipalname  | export-csv $filepath -notypeinformation
Open the CSV file in notepad and replace all the quotations - CTRL-H 



ForensIT
4.
Install ForensIT
After you purchase the corporate edition you will be emailed a link with an exe and config file download both
install ForensIT
navigate to C:\Program Files (x86)\ForensiT\User Profile Wizard Corporate\Deployment Kit or click the windows Icon and find the User Profile Wizard Deployment Kit

5.
Once you receive the config file you will need to edit silent mode to "True" as below

 <!-- Corporate Edition Settings -->
    <Silent>True</Silent>
    <NoMigrate>False</NoMigrate>
    <NoReboot>False</NoReboot>
    <RemoveAdmins>False</RemoveAdmins>
    <MachineLookupFile></MachineLookupFile>
    <Log>C:\Users\Public\Documents\Migrate.Log</Log> 
6.
Create a new migration project
After opening the UPWDK select create a new migration project
Give it a name 
click next

7.
Create folders on local device that is being used to build package. If using the remote script (See below) create a folder using the below format:

C:\Migration\<migration_name>\

Move all files into this folder and direct the file paths in the following steps to these files.
8.
Domain Information
Enter the name of the Azure domain that you will be migration to 
locate the file that was created in step 1 for the Azure ID file path
Locate the provisioning package that was created in step 2
click next

9.
Enter Existing Domain Info
Select Yes 
enter the existing domain name
click next

10.
upload the user lookup csv file from step 3
check skip migration is user is not found in lookup file
next

11.
Enter old domain creds
enter the creds for a administrator of the old domain
click next

12.
Script options
Select deploy using SCCM or GPO
by default the program will default to the migrate all users but they have 2 other scripts to choose from
click next after select the correct script

13.
Follow on script (optional)
you can choose to run a script once the migration is complete
note did not work during testing

14.
Creating the script
it will ask you to create the script select yes
it will put the exe in the below path
C:\ProgramData\ForensiT\User Profile Wizard Corporate\Deployment Files\project name
deploy the exe to all devices
Remote deployment
15.
Copy all files to a local OneDrive or SharePoint location and create a share URL for each
16.
Replace the URLs in the following script and change everything after the final "?" to download=1

e.g:


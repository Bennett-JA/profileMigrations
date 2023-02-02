#run on domain controller

$filepath = C:\temp\LookUpFile.csv

get-aduser -filter * | select-object samaccountname, userprincipalname  | export-csv $filepath -notypeinformation

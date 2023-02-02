get-aduser -filter * | select-object samaccountname, userprincipalname  | export-csv $filepath -notypeinformation

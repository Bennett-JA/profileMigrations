#Provisiong downloads

# Will also need to change file names on ones project specific
## change URLs below to be project specific
$ProvFilesDL = @{
    #directory name = c:\Migrations\<projectName>\
    'customizations.xml' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/Eb5E8PI85JJGsk2uA2z2A_YBP4ayUAUw5eeLWZGaIj2hgA?download=1'
    'ICD.log' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/ETiGbdCIRQtHoUcSJknUafQBI0PbqvvjUY-PAiMAGZSeXg?download=1'
    'ICDCommon.log' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EZAfTd6tBQFOvtH7Od_lW0YBETQHXan-ykMnKgaWKU6XHA?download=1'
    'SettingsMetadata.xml' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/ESILgfC6p2tHmbpKBXigOU4BF5F3GztILOlZoAbnsbpMIw?download=1'
    'TemplateState.data' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EUkb1wKCxYtMu9G7bvhrFKsBmeBnNtSqFnGKemrrqyyO2g?download=1'
    ##Project specific
    'BrCo_Migration.cat' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EafxAmvizfFNqV83D1jhzXoBewlhaBD4xug6ZSBwG2l_Xw?download=1'
    ##Project specific
    'BrCo_Migration.icdproj.xml' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EcSZliKriCFOr3gtPhkoTH0BsS2r-5uvSz3d-oeDd03M6Q?download=1'
    ##Project specific
    'BrCo_Migration.ppkg' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EdibyTZzJzhLli1rtZv2rCQByDWHMJ0yGjly184-l0QznA?download=1'
}
#forens downloads
$ForensFilesDL = @{
    #C:\migration\<projectName>
    'Migrate-BrCo_Migration.exe' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EbcdtMhJsEFOhSKhx_aHv3gBlWQEFA0xYjU5BlTurhiNPA?download=1'
    'Migrate-BrCo_Migration.ps1' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EV43o7Rcg99PvAdrIp4A1T4BrK5SMIYmeg25pLXVVi7-HQ?download=1' 
    'Profwiz.config' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/ETe5w4lQqdlOhbA3myk7vNsB4KNlgklPqELXDgOELhQpOQ?download=1'
    'Profwiz.exe' = 'https://amcsolutions-my.sharepoint.com/:u:/g/personal/jbennett_amcmodernit_com/EUUXKDWL9vVDrSlqK25YfA0BB8IqdPPO37dQmsnvkySTdg?download=1'
}

#Create directories
#Check if path exists, if not create it
## Change below to match project folder created on local device
$provPath = "C:\migration\BrCo_Migration"
$forensPath = "C:\migration\BrCo_Migration"

If(!(test-path $provpath))
{
      New-Item -ItemType Directory -Force -Path $provPath
}
#Download files to directories 
#provisiong downloads
foreach($file in $ProvFilesDL.GetEnumerator()){
    Write-Host "Downloading '$($file.Name)' from '$($file.Value)'"

    # construct output path, then download file
    $outputPath = Join-Path $provPath -ChildPath $file.Name
    Invoke-WebRequest -Uri $file.Value -OutFile $outputPath
}


foreach($file in $forensFilesDL.GetEnumerator()){
    Write-Host "Downloading '$($file.Name)' from '$($file.Value)'"

    # construct output path, then download file
    $outputPath = Join-Path $forensPath -ChildPath $file.Name
    Invoke-WebRequest -Uri $file.Value -OutFile $outputPath
}


# confirm files download succesful
foreach($file in $forensFilesDL.GetEnumerator()){
    if(test-path "$forensPath\$($file.Key)")
    {
        $continue = $true
    }
}

foreach($file in $ProvFilesDL.GetEnumerator()){
    if(test-path "$provPath\$($file.Key)")
    {
        $continue = $true
    }
}

if($continue -eq $true)
{
    write-host "All files downloaded - Starting migration"
    start-process "C:\migration\BrCo_Migration\Migrate-BrCo_Migration.exe"
    
}






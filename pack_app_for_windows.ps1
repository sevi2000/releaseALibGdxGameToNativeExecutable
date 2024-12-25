param(
    [string]$ProjectName,
    [string]$Version
    [string]$Extention
)
# 1a line is the same for every OS, 2a is personalized by OS.
jpackage`
     --input in -d out`
     --name $ProjectName` 
     --main-jar *.jar` 
     --app-version $Version`
     -t $Extention`
     --icon icon.ico`
     --win-shortcut`
     --win-menu` 
     --win-menu-group $ProjectName`

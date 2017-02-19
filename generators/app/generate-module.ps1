cls

$CONTROLLER_DIR = 'upload/%c%/controller/%t%/'
$LANGUAGE_DIR = 'upload/%c%/language/english/%t%/'
$MODEL_DIR = 'upload/%c%/model/%t%/'
$ADMIN_VIEW_DIR = 'upload/admin/view/template/%t%/'
$CATALOG_VIEW_DIR = 'upload/catalog/view/theme/default/template/%t%/'
$VQMOD_DIR = 'upload/vqmod/xml/'


echo "Welcome to the Opencart Module starter generator!"
############# Prompts

# Module Name
$module_name = Read-Host -Prompt 'What name would you like for your module?'
# End Module Name

# Version
$title = "Version"
$message = "What version of Opencart will your module be for?"

$v15x = New-Object System.Management.Automation.Host.ChoiceDescription "&1 1.5.x", `
    "1.5.x"

$v2x = New-Object System.Management.Automation.Host.ChoiceDescription "&2 2.0x", `
    "2.x"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($v15x, $v2x)

$result = $host.ui.PromptForChoice($title, $message, $options, 1) 

switch ($result)
    {
        0 {$version = "1_5"}
        1 {$version = "2_x"}
    }

# End Version
	
# Module Type
$title = "Module Type"
$message = "What type of module do you want to create?"

$modtype_module = New-Object System.Management.Automation.Host.ChoiceDescription "&Module", `
    "module"

$modtype_payment = New-Object System.Management.Automation.Host.ChoiceDescription "&Payment", `
    "payment"

$modtype_shipping = New-Object System.Management.Automation.Host.ChoiceDescription "&Shipping", `
    "shipping"

$modtype_total = New-Object System.Management.Automation.Host.ChoiceDescription "&Order Total", `
    "total"	
	
$modtype_feed = New-Object System.Management.Automation.Host.ChoiceDescription "&Feed", `
    "feed"	
	
$options = [System.Management.Automation.Host.ChoiceDescription[]]($modtype_module, $modtype_payment, $modtype_shipping, $modtype_total, $modtype_feed)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {$module_type = "module"}
        1 {$module_type = "payment"}
        2 {$module_type = "shipping"}
        2 {$module_type = "total"}
        2 {$module_type = "feed"}
		
	}
	
# END Module Type


# vQMod Support
$title = "vQMod Support"
$message = "Will the module require vQmod support?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "true"

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "false"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 1) 

switch ($result)
    {
        0 {$vqmod = $true}
        1 {$vqmod = $false}
    }

# End vQMod SUpport

$TextInfo = (Get-Culture).TextInfo
$titleize_format = $TextInfo.ToTitleCase($module_name)
$classify_format = $TextInfo.ToTitleCase($module_type) + $TextInfo.ToTitleCase($module_name) -replace (' ','')
$underscore_format = $TextInfo.ToLower($module_name) -replace (' ','_')


######## End Prompts

echo "Module:  $module_name"
echo "Version: $version"
echo "Module Type: $module_type"
echo "vQmod Support: $vqmod"
echo "Titlized Module Name: $titleize_format"
echo "Classify Module Name: $classify_format"
echo "Undersore Module Name: $underscore_format"


#############################################################
### Process Files ###########################################
#############################################################

$templateFile = "templates\$version\_admin_controller.php"
$destinationFile = $CONTROLLER_DIR -replace ("%c%","admin") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.php"
New-Item  $destinationFile -Type file -Force | Out-Null 
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force

$templateFile = "templates\$version\_admin_language.php"
$destinationFile = $LANGUAGE_DIR -replace ("%c%","admin") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.php"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force

$templateFile = "templates\$version\_admin_view.tpl"
$destinationFile = $ADMIN_VIEW_DIR -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.tpl"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force

############### Catalog ##################

$templateFile = "templates\$version\_catalog_controller.php"
$destinationFile = $CONTROLLER_DIR -replace ("%c%","catalog") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.php"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force


$templateFile = "templates\$version\_catalog_language.php"
$destinationFile = $LANGUAGE_DIR -replace ("%c%","catalog") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.php"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force


$templateFile = "templates\$version\_catalog_model.php"
$destinationFile = $MODEL_DIR -replace ("%c%","catalog") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.php"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force

$templateFile = "templates\$version\_catalog_view.tpl"
$destinationFile = $CATALOG_VIEW_DIR -replace ("%c%","catalog") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.tpl"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force

############## vQmod ########

if ($vqmod -eq $true) {
$templateFile = "templates\$version\_vqmod.xml"
$destinationFile = $VQMOD_DIR -replace ("%c%","catalog") -replace ("%t%",$module_type)
$destinationFile = $destinationFile + "$underscore_format.xml"
New-Item  $destinationFile -Type file -Force | Out-Null
Get-Content $templateFile |
Foreach-Object { $_ -replace "<%= classified_name %>", "$classify_format" } |
Foreach-Object { $_ -replace "<%= titleized_name %>", "$titleize_format" } |
Foreach-Object {   $_ -replace "<%= module_type %>","$module_type" } |
Foreach-Object {   $_ -replace "<%= underscored_name %>","$underscore_format" } |
Set-Content  -path "$destinationFile" -force
}

echo " " " " "Your module starter $titleize_format has been created successfully!"
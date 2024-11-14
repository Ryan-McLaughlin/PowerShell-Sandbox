cls

Function Parse-IniFile($file)
{
    $ini = @{}

    # default section if none exist
    $section = "NO_SECTION"
    $ini[$section] = @{}

    switch -regex -file $file {
        
        "^\[(.+)\]$" {
        
            $section = $matches[1].Trim()
            $ini[$section] = @{}
        }
        
        "^\s*([^#].+?)\s*=\s*(.*)" {
            $name,$value = $matches[1..2]

            # skip comments
            if (!($name.StartsWith(";"))) {
                $ini[$section][$name] = $value.Trim()
            }
        }
    }
    
    Write-Host $ini

    # Return the parsed INI data
    return $ini
}


$iniPath = Join-Path -Path $PSScriptRoot -ChildPath "sandbox.ini"
				   
$iniData = Parse-IniFile $iniPath


# Loop through and display the parsed INI data
foreach ($sectionName in $iniData.Keys) {
    Write-Host "$sectionName"
    
    foreach ($key in $iniData[$sectionName].Keys) {
        $value = $iniData[$sectionName][$key]
        Write-Host "  $key = $value"
    }
}


# Assuming you have a dictionary or hashtable named $iniData

# Specify the section and key you want to retrieve
$sectionName = "Settings"
$key = "Maximum"

# Check if the section exists in the dictionary
if ($iniData.ContainsKey($sectionName)) {
    # Check if the key exists within the section
    if ($iniData[$sectionName].ContainsKey($key)) {
        # Retrieve the value associated with the key
        $value = $iniData[$sectionName][$key]
        Write-Host "Value of $key in [$sectionName]: $value"
    } else {
        Write-Host "Key $key not found in [$sectionName]"
    }
} else {
    Write-Host "Section [$sectionName] not found"
}




<#
function Get-IniContent($filePath) {
    Write-Host "Get-IniContent()"
    $ini = @{}
    $section = ""

    Get-Content $filePath | ForEach-Object {
        $line = $_.Trim()

        if ($line -match "^\[([^\]]+)]$") {
            $section = $Matches[1]
            $ini[$section] = @{}
        }
        elseif ($line -match "^([^#].+?)\s*=\s*(.+)$") {
            $name, $value = $Matches[1..2]
            $ini[$section][$name] = $value
        }
    }

    return $ini
}

function Set-IniValue($filePath, $section, $name, $value) {
    Write-Host "Set-IniValue()"
    $ini = Get-IniContent $filePath

    if ($ini.ContainsKey($section)) {
        $ini[$section][$name] = $value
    }
    else {
        $ini[$section] = @{}
        $ini[$section][$name] = $value
    }

    $iniContent = $ini | ForEach-Object {
        $sectionName = $_.Key
        $sectionData = $_.Value

        "[{0}]" -f $sectionName
        $sectionData.GetEnumerator() | ForEach-Object {
            "{0} = {1}" -f $_.Key, $_.Value
        }
    }

    $iniContent | Out-File -FilePath $filePath -Encoding ASCII
}

# Example usage:
$scriptDirectory = $PSScriptRoot
$iniFilePath = Join-Path -Path $scriptDirectory -ChildPath "sandbox.ini"
$sectionName = "Settings"
$propertyName = "MaxScore"
$newValue = "1000"

# Read the value from the .ini file
$ini = Get-IniContent $iniFilePath
$oldValue = $ini[$sectionName][$propertyName]

Write-Host "Old value: [$sectionName][$propertyName] $oldValue"

# Set a new value in the .ini file
Set-IniValue $iniFilePath $sectionName $propertyName $newValue

Write-Host "New value: [$sectionName][$propertyName] $newValue"
#>
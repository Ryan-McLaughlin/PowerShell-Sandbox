<#
.SYNOPSIS
This is the Sandbox Form.

.DESCRIPTION
Sets up the form.

.AUTHOR
Ryan McLaughlin

.NOTES
File Name      : Sandbox.Form.ps1
Prerequisite   : PowerShell
#>

# Load the Windows Forms assembly
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
cls

function Parse-IniFile
{
    param
    (
        [string]$FilePath
    )

    # create empty hashtable
    $ini = @{}
}

function Get-IniValue
{
}

# Create a form
$form = New-Object Windows.Forms.Form
$form.Text = "Sandbox"
$form.Width = 420


# Show the form
$form.ShowDialog()

# Dispose of form when done
$form.Dispose()
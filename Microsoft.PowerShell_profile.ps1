# Created by Noah Dominic <github.com/noahdominic>

# ======================== #
# PowerShell customisation #
# ======================== #

Import-Module posh-git


<#
.SYNOPSIS
   Checks if a specified PowerShell module exists.

.DESCRIPTION
   The Check-ModuleExists function checks if a specified PowerShell module exists on the system.  It returns a message indicating whether the module exists or not.

.PARAMETER ModuleName
   Specifies the name of the PowerShell module to check.

.ALIASES
   checkmod

.NOTES
   Copyright (c) 2024  Noah Dominic Miranda Silvio <github.com/noahdominic>
#>
function Check-ModuleExists {
    param (
        [string]$ModuleName
    )

    if (Get-Module -ListAvailable -Name $ModuleName) {
        Write-Host "Module $ModuleName exists"
    } else {
        Write-Host "Module $ModuleName does not exist"
    }
}

New-Alias -Name checkmod -Value Check-ModuleExists

# ============================================================================
# Functions
# ============================================================================

## mkcd - Make a new dir $name and cd into $name
##
function Make-NewDirectory {
  param(
    [string]$DirectoryName
  )
  if (-not (Test-Path $DirectoryName)) {
    New-Item -ItemType Directory -Path $DirectoryName | Out-Null
    Set-Location -Path $DirectoryName
  } else {
    Write-Host "Directory '$DirectoryName' already exists."
  }
}

New-Alias -Name mkcd -Value Make-NewDirectory

## mkcd - Make a new dir $name and cd into $name
##
function Make-File {
  param(
    [string]$FileName
  )
  if (-not (Test-Path $FileName)) {
    New-Item -ItemType File -Path $FileName 
  } else {
    Write-Host "File '$FileName' already exists."
  }
}

New-Alias -Name mkfile -Value Make-File

function sudo {
    Start-Process @args -verb runas
}

# ============================================================================
# Development - Proj Management
# ============================================================================

## Git
function ga {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, ValueFromRemainingArguments=$true)]
        [string[]]$files = @(".")
    )

    foreach ($file in $files) {
        # Check if the file/directory exists
        if (-not (Test-Path $file)) {
            Write-Host "File or directory '$file' does not exist." -ForegroundColor Red
            continue
        }

        # Execute git add command
        git add $file
    }
}

New-Alias -Name gadd -Value 'git add'
function ga. {
    git add .
}
New-Alias -Name gcommit -Value 'git commit'
function gc-m {
    param([string]$message)
    & git commit -m $message
}
function gc-am {
    param([string]$message)
    & git commit -am $message
}
New-Alias -Name gpush -Value 'git push'
New-Alias -Name gstat -Value 'git status'
function ghash {
    param([string]$object)
    & git hash-object -w $object
}
New-Alias -Name gundo -Value 'git reset HEAD~'
New-Alias -Name gb -Value 'git branch'
New-Alias -Name gco -Value 'git checkout'
New-Alias -Name gcheckout -Value 'git checkout'
New-Alias -Name grebase -Value 'git rebase'
New-Alias -Name gmerge -Value 'git merge'

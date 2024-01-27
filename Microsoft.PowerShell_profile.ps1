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
### Git add
New-Alias -Name g -Value git
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
function ga. {
    git add .
}
New-Alias -Name gadd -Value ga
### Git commit
function gc-m {
    param([string]$message)
    & git commit -m $message
}
function gc-am {
    param([string]$message)
    & git commit -am $message
}
### Git status
function gss {
    git status
}
New-Alias -Name gstat -Value gss
### branching
function gb {
    param([string]$branch)
    & git branch $branch
}
function gco {
    param([string]$branch)
    & git checkout $branch
}
function gr {
    param([string]$branch)
    & git rebase $branch
}
function gm {
    param([string]$branch)
    & git merge $branch
}
function gpush {
    git push
}
function gsync {
    git pull
    git push
}
function gundo {
    git reset HEAD~
}

# phishDefenceLab
Testing laboratory for Phish Defense | Digital Forensics &amp; Incident Response

Phish Defence Lab is a powershell script, that will automatically setup your virtual machine with all the tools necessary for a Phish Defence System. It consists of various tools and settings needed for a Phishing Defence Threat Response. This repo provides a way to directly setup the entire lab in a Virtual environment, with just one command.

Required Operating System: Windows 10 x64

## Requirements
- Windows base machine

## How to setup
There are two scripts:
### 1. Manual Installation (setupLab.ps1):
This script manually downloads the tools from the source and installs it. To use this, follow the steps:
- Run powershell as administrator and type:
```
set-executionpolicy unrestricted
```
- Then run the script:
``` 
./setupLab.ps1
```

### 2. Using [chocolaty package manager](https://chocolatey.org/) (setupLabChoco.ps1):
This script will use the Chocolaty package manager to install all the tools
- Run powershell as administrator and type:
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
- Run the script:
```
./setupLabChoco.ps1
```

## Modifications:

### Forensics Tools:
- [Network monitor](https://www.microsoft.com/en-in/download/details.aspx?id=4865)
- [Wireshark](https://www.wireshark.org/download.html)
- [Process Hacker](https://processhacker.sourceforge.io/)
- [HashMyFiles](https://www.nirsoft.net/utils/hash_my_files.html)
- [Fiddler](https://www.telerik.com/download/fiddler-everywhere)
- [PEStudio](https://www.winitor.com/) 
- [PSTools](https://docs.microsoft.com/en-us/sysinternals/downloads/pstools)
- [SysInternals Suite](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)
- [file for windows](http://gnuwin32.sourceforge.net/packages/file.htm)
- [oletools](https://github.com/decalage2/oletools)
- [Regshot](https://sourceforge.net/projects/regshot/) Portable

### Other Softwares:
- [Python 3.8.6](https://www.python.org/downloads/release/python-386/)
- [Notepad++](https://notepad-plus-plus.org/downloads/)
- [Adobe Acrobat Reader](get.adobe.com/reader/) (Only in Chocolaty package manager)
- [Bulk Crap Uninstaller](https://www.bcuninstaller.com/)
- [7zip](https://www.7-zip.org/)
- [Winrar](https://www.win-rar.com/start.html?&L=0)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Chrome](https://www.google.com/intl/en_in/chrome/) (Only in Chocolaty package manager)

## Settings:
- Firewall and defender disabled
- Hidden files enabled
- Recommended add-ons and bookmarks setup in Firefox and Chrome
- Hardening disabled in Firefox and Chrome

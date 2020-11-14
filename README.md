# phishDefenceLab
Testing laboratory for Phish Defense | Digital Forensics &amp; Incident Response

Phish Defence Lab is a pre-configured virtual machine, consisting of various tools and settings needed for a Phishing Defence Threat Response. This repo provides a way to directly setup the entire lab in a Virtual environment, with just one command.
Operating system for the lab: Windows 7 pro x64
## Requirements
- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Windows base machine

## How to setup
There are two ways to setup the lab.
1. Powershell script:
To do this, you need to enable execution of scripts, which is by default disabled in windows. For this, go to powershell and type
```sh
PS C:\Users\user\pdclab> Set-ExecutionPolicy Unrestricted
```
After changing the Execution Policy, just execute the script
```sh
PS C:\Users\user\pdclab> .\setup.ps1
```

2. Using vagrant
Download the Vagrantfile from the repo and store it in a seperate folder. With this you can directly setup the box with one command
```sh
PS C:\Users\user\pdclab> vagrant up
```

Advantage of powershell script over directly using vagrant, is that script will automatically check for the presence of VirtualBox, Vagrant and the lab in your system.
Account : user
Password: resu

## Modifications:

### Forensics Tools:
- [Network monitor](https://www.microsoft.com/en-in/download/details.aspx?id=4865)
- [Wireshark](https://www.wireshark.org/download.html)
- [Process Hacker](https://processhacker.sourceforge.io/) Portable
- [HashMyFiles](https://www.nirsoft.net/utils/hash_my_files.html) Portable
- [Fiddler](https://www.telerik.com/download/fiddler-everywhere)
- [PEiD](https://www.aldeid.com/wiki/PEiD) Portable
- [PEStudio](https://www.winitor.com/) Portable
- [PSTools](https://docs.microsoft.com/en-us/sysinternals/downloads/pstools) (Environment Variables added)
- [SysInternals Suite](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) (Environment Variables added)
- [file for windows](http://gnuwin32.sourceforge.net/packages/file.htm)
- [oletools](https://github.com/decalage2/oletools)
- [Regshot](https://sourceforge.net/projects/regshot/) Portable
- [PDFStreamDumper](https://github.com/dzzie/pdfstreamdumper)

### Other Softwares:
- [Notepad++](https://notepad-plus-plus.org/downloads/) Portable
- [Adobe Acrobat Reader](get.adobe.com/reader/)
- [Bulk Crap Uninstaller](https://www.bcuninstaller.com/) Portable
- [7zip](https://www.7-zip.org/)
- [Winrar](https://www.win-rar.com/start.html?&L=0)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Chrome](https://www.google.com/intl/en_in/chrome/)

## Settings:
- Firewall and defender disabled
- Hidden files enabled
- Recommended add-ons and bookmarks setup in Firefox and Chrome
- Hardening disabled in Firefox and Chrome

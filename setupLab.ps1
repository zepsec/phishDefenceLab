$apps64 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*;
$apps32 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*;
$username = $env:username;
$EnvPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path;
$progfiles = "C:\Program Files";
$progfiles86 = "C:\Program Files (x86)";
$docsfolder = "C:\Users\$username\Documents";
$desktopfolder = "C:\Users\$username\Desktop";
$ctime = Get-Date -format "HH:mm:ss";

Function create-shortcut($a, $b) {
	$WshShell = New-Object -comObject WScript.Shell;
	$Shortcut = $WshShell.CreateShortcut("$desktopfolder" + $b);
	$Shortcut.TargetPath = $a;
	$Shortcut.Save();
}

echo ""
echo "[ $ctime ] ### Setting up your Phish Defense Lab ###"
echo ""

### Firefox Installation
echo "[ $ctime ] -> Checking if Firefox is installed";
try {
	$installPath = "C:\Program Files (x86)\Mozilla Firefox";
	If(($apps64.DisplayName -Match "Mozilla Firefox") -or ($apps32.DisplayName -Match "Mozilla Firefox")) {
		echo "[ $ctime ] --> Firefox already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Firefox does not exist, Installing...";
		$SourceURL = "https://cdn.stubdownloader.services.mozilla.com/builds/firefox-stub/en-US/win/f784a64aa08c168c5df9c5ec9207ad9edb679aeaf1d171896a402fffee31bed6/Firefox%20Installer.exe";
		$Installer = $env:TEMP + "\firefox.exe"; 
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/s" -Verb RunAs -Wait; 
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "Mozilla Firefox") -or ($apps32.DisplayName -Match "Mozilla Firefox")) {
			echo "[ $ctime ] ---> Firefox successfully installed";
			echo "[ $ctime ] ---> Creating Shortcut";
			If((Test-Path $desktopfolder\Firefox.lnk) -eq $False) { create-shortcut $installPath\firefox.exe "\Firefox.lnk"; }
			echo ""
		} else {
			echo "[ $ctime ] ---> Firefox was not successfully installed, Please download & install it manually from https://www.mozilla.org/en-US/firefox/new/";
			echo ""
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Firefox: Unknown Error. Please download & install it manually from https://www.mozilla.org/en-US/firefox/new/"
	echo ""; sleep 1;
}

### Notepad++ Installation
echo "[ $ctime ] -> Checking if Notepad++ is installed";
try {
	$installPath = "C:\Program Files\Notepad++"
	sleep 1;
	If(($apps64.DisplayName -Match "Notepad") -or ($apps32.DisplayName -Match "Notepad")) {
		echo "[ $ctime ] --> Notepad++ already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Notepad++ does not exist, Installing...";
		$SourceURL = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.1/npp.7.9.1.Installer.x64.exe";
		$Installer = $env:TEMP + "\npp.exe"; 
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/S" -Verb RunAs -Wait;
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "Notepad") -or ($apps32.DisplayName -Match "Notepad")) {
			echo "[ $ctime ] ---> Notepad++ successfully installed";
			echo "[ $ctime ] ---> Creating Shortcut on Desktop";
			If((Test-Path $desktopfolder\Notepad++.lnk) -eq $False) { create-shortcut $installPath\notepad++.exe "\Notepad++.lnk"; }
			echo ""
		} else {
			echo "[ $ctime ] ---> Notepad++ was not successfully installed. Please download & install it from https://notepad-plus-plus.org/downloads/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Notepad++: Unknown Error. Please download & install it manually from https://notepad-plus-plus.org/downloads/";
	echo ""; sleep 1;
}

### Fiddler Installation
echo "[ $ctime ] -> Checking if Fiddler is installed";
try {
	$installPath = "C:\Users\$username\AppData\Local\Programs\Fiddler"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> Fiddler already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Fiddler does not exist, Installing...";
		$SourceURL = "https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe";
		$Installer = $env:TEMP + "\fiddler.exe"; 
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		$proc = Start-Process -FilePath $Installer -Args "/S" -Verb RunAs -Wait;
		sleep 30;
		$proc | kill
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> Fiddler successfully installed";
			echo "[ $ctime ] ---> Creating Shortcut on Desktop"
			If((Test-Path $desktopfolder\Fiddler.lnk) -eq $False) { create-shortcut $installPath\Fiddler.exe "\Fiddler.lnk"; }
			echo ""
		} else {
			echo "[ $ctime ] ---> Fiddler was not successfully installed. Please download & install it manually from https://www.telerik.com/download/fiddler-everywhere";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Fiddler: Unknown Error. Please download & install it manually from https://www.telerik.com/download/fiddler-everywhere";
	echo ""; sleep 1;
}

### SysInternal Suite Installation
echo "[ $ctime ] -> Checking if SysInternal Suite is installed";
try {
	$installPath = $docsfolder + "\SysInternalsSuite"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> SysInternal Suite already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> SysInternal Suite does not exist, Installing...";
		$SourceURL = "https://download.sysinternals.com/files/SysinternalsSuite.zip";
		$Installer = $env:TEMP + "\sysinternals.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		echo "Adding SysInternals to Environment Variables"
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> SysInternal Suite successfully installed";
			echo "[ $ctime ] ---> Adding to environment variables"
			[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "user")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "Machine")
			echo "";
		} else {
			echo "[ $ctime ] ---> SysInternal Suite was not successfully installed. Please download and install it manually from https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Sysinternals Suite: Unknown Error. Please download & install it manually from https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite";
	echo ""; sleep 1;
}

### Wireshark Installation
echo "[ $ctime ] -> Checking if Wireshark is installed";
try{
	$installPath = "C:\Program Files\Wireshark"
	If(($apps64.DisplayName -Match "Wireshark") -or ($apps32.DisplayName -Match "Wireshark")) {
		echo "[ $ctime ] --> Wireshark already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Wireshark does not exist, Installing...";
		$SourceURL = "https://2.na.dl.wireshark.org/win64/Wireshark-win64-3.4.0.exe";
		$Installer = $env:TEMP + "\wireshark.exe"; 
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/S" -Verb RunAs -Wait;
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "Wireshark") -or ($apps32.DisplayName -Match "Wireshark")) {
			echo "[ $ctime ] ---> Wireshark successfully installed";
			echo "[ $ctime ] ---> Creating shortcut on Desktop";
			If((Test-Path $desktopfolder\Wireshark.lnk) -eq $False) { create-shortcut $installPath\Wireshark.exe "\Wireshark.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> Wireshark was not successfully installed. Please download & install it manually from https://www.wireshark.org/download.html";
			echo "";
		}
		echo "[ $ctime ] ---> Npcap does not support silent install, please download & install manually from https://nmap.org/npcap/"
		echo ""; sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Wireshark: Unknown Error. Please download & install it manually from https://www.wireshark.org/download.html";
	echo ""; sleep 1;
}

### Process Hacker Installation
echo "[ $ctime ] -> Checking if Process Hacker is installed";
try{
	$installPath = $progfiles + "\Process Hacker 2"
	If(($apps64.DisplayName -Match "Process Hacker") -or ($apps32.DisplayName -Match "Process Hacker")) {
		echo "[ $ctime ] --> Process Hacker already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Process Hacker does not exist, Installing...";
		$SourceURL = "https://github.com/processhacker/processhacker/releases/download/v2.39/processhacker-2.39-setup.exe";
		$Installer = $env:TEMP + "\phacker.exe";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/VERYSILENT" -Verb RunAs -Wait;
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "Process Hacker") -or ($apps32.DisplayName -Match "Process Hacker")) {
			echo "[ $ctime ] ---> Process Hacker successfully installed";
			echo "";
		} else {
			echo "[ $ctime ] ---> Process Hacker was not successfully installed. Please download & install it manually from https://processhacker.sourceforge.io/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Process Hacker: Unknown Error. Please download & install it manually from https://processhacker.sourceforge.io/";
	echo ""; sleep 1;
}

### HashMyFiles Installation
echo "[ $ctime ] -> Checking if HashMyFiles is installed";
try {
	$installPath = $docsfolder + "\HashMyFiles"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> HashMyFiles already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] -HashMyFiles does not exist, Installing...";
		$SourceURL = "https://www.nirsoft.net/utils/hashmyfiles-x64.zip";
		$Installer = $env:TEMP + "\hashmyfiles.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> HashMyFiles successfully installed";
			echo "[ $ctime ] ---> Creating Shortcut on Desktop";
			If((Test-Path $desktopfolder\HashMyFiles.lnk) -eq $False) { create-shortcut $installPath\HashMyFiles.exe "\HashMyFiles.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> HashMyFiles was not successfully installed. Please download & install it manually from https://www.nirsoft.net/utils/hash_my_files.html";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> HashMyFiles: Unknown Error. Please download & install it manually from https://www.nirsoft.net/utils/hash_my_files.html";
	echo ""; sleep 1;
}

### PEiD Installation
echo "[ $ctime ] -> Checking if PEiD is installed";
try {
	$installPath = $docsfolder + "\PEiD"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> PEiD already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> PEiD does not exist, Installing...";
		$SourceURL = "https://softpedia-secure-download.com/dl/83e679b18b63f741f51f6837accc596b/5fb9efff/100004102/software/programming/PEiD-0.95-20081103.zip";
		$Installer = $env:TEMP + "\PEiD.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> PEiD successfully installed";
			echo "[ $ctime ] ---> Creating shortcut on Desktop";
			If((Test-Path $desktopfolder\PEiD.lnk) -eq $False) { create-shortcut $installPath\PEiD.exe "\PEiD.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> PEiD was not successfully installed. Please download & install manually from https://www.aldeid.com/wiki/PEiD";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> HashMyFiles: Unknown Error. Please download & install it manually from https://www.aldeid.com/wiki/PEiD";
	echo ""; sleep 1;
}

### PEStudio Installation
echo "[ $ctime ] -> Checking if PEStudio is installed";
try {
	$installPath = $docsfolder
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> PEStudio already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> PEStudio does not exist, Installing...";
		$SourceURL = "https://www.winitor.com/tools/pestudio/current/pestudio.zip";
		$Installer = $env:TEMP + "\pestudio.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> PEStudio successfully installed";
			echo "[ $ctime ] ---> Creating shortcut on Desktop";
			If((Test-Path $desktopfolder\PEStudio.lnk) -eq $False) { create-shortcut $installPath\PEStudio\PEStudio.exe "\PEStudio.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> PEiD was not successfully installed. Please download & install manually from https://www.winitor.com/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> PEStudio: Unknown Error. Please download & install it manually from https://www.winitor.com/";
	echo ""; sleep 1;
}

### PSTools Installation
echo "[ $ctime ] -> Checking if PSTools is installed";
try {
	$installPath = $docsfolder + "\PSTools"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> PSTools already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> PSTools does not exist, Installing";
		$SourceURL = "https://download.sysinternals.com/files/PSTools.zip";
		$Installer = $env:TEMP + "\PSTools.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> PSTools successfully installed";
			echo "[ $ctime ] ---> Adding to Environment Variables";
			[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "user")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "Machine")
			echo "";
		} else {
			echo "[ $ctime ] ---> PSTools was not successfully installed. Please download & install manually from https://docs.microsoft.com/en-us/sysinternals/downloads/pstools";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> PSTools: Unknown Error. Please download & install it manually from https://docs.microsoft.com/en-us/sysinternals/downloads/pstools";
	echo ""; sleep 1;
}

### File for Windows
echo "[ $ctime ] -> Checking if File for Windows is installed";
try {
	$installPath = $progfiles86 + "\GnuWin32"
	If(($apps64.DisplayName -Match "GnuWin32: File") -or ($apps32.DisplayName -Match "GnuWin32: File")) {
		echo "[ $ctime ] -> File for Windows already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> File for Windows does not exist, Installing...";
		$SourceURL = "https://github.com/processhacker/processhacker/releases/download/v2.39/processhacker-2.39-setup.exe";
		$Installer = $env:TEMP + "\phacker.exe";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/VERYSILENT" -Verb RunAs -Wait;
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "GnuWin32: File") -or ($apps32.DisplayName -Match "GnuWin32: File")) {
			echo "[ $ctime ] ---> File for Windows successfully installed";
			echo "[ $ctime ] ---> Adding to Environment Variables";
			[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\bin\", "user")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\bin\", "Machine")
			echo "";
		} else {
			echo "[ $ctime ] ---> Process  was not successfully installed. Please download & manually install it from http://gnuwin32.sourceforge.net/packages/file.htm";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> File for Windows: Unknown Error. Please download & install it manually from http://gnuwin32.sourceforge.net/packages/file.htm";
	echo ""; sleep 1;
}

### 7-Zip Installation
echo "[ $ctime ] -> Checking if 7-Zip is installed";
try {
	$installPath = "C:\Program Files\7-Zip"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> 7-Zip already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> 7-Zip does not exist, Installing...";
		$SourceURL = "https://www.7-zip.org/a/7z1900-x64.exe";
		$Installer = $env:TEMP + "\7zip.exe"; 
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/S" -Verb RunAs -Wait; 
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> 7-Zip successfully installed";
			echo "[ $ctime ] ---> Adding to Environment Variable";
			[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "user")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath", "Machine")
			echo "";
		} else {
			echo "[ $ctime ] ---> 7-Zip was not successfully installed. Please download & install it manually from https://www.7-zip.org/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> 7-Zip: Unknown Error. Please download & install it manually from https://www.7-zip.org/";
	echo ""; sleep 1;
}

### Regshot installation
echo "[ $ctime ] -> Checking if Regshot is installed";
try {
	$installPath = $docsfolder + "\Regshot"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> Regshot already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Regshot does not exist, Installing...";
		$SourceURL = "https://excellmedia.dl.sourceforge.net/project/regshot/regshot/1.9.0/Regshot-1.9.0.7z";
		$Installer = $env:TEMP + "\Regshot.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		7z.exe x $Installer -o"$installPath"
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> Regshot successfully installed";
			echo "[ $ctime ] ---> Creating shortcut on Desktop";
			If((Test-Path $desktopfolder\Regshot.lnk) -eq $False) { create-shortcut $installPath\Regshot-x64-ANSI.exe "\Regshot.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> Regshot was not successfully installed. Please download & install manually from https://sourceforge.net/projects/regshot/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Regshot: Unknown Error. Please download & install it manually from https://sourceforge.net/projects/regshot/";
	echo ""; sleep 1;
}

### Python3 Installation
echo "[ $ctime ] -> Checking if Python3 is installed";
try {
	$installPath = "C:\Users\user\AppData\Local\Programs\Python"
	If((python -V) -ne $null) {
		echo "[ $ctime ] --> Python already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Python3 does not exist, Installing...";
		$SourceURL = "https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe";
		$Installer = $env:TEMP + "\python3.exe";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/passive PrependPath=1" -Verb RunAs -Wait; `
		Remove-Item $Installer;
		If((python -V) -ne $null) {
			echo "[ $ctime ] ---> Python3 successfully installed";
			echo "[ $ctime ] ---> Adding Environment Variable";
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\Python39\", "Machine")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\Python39\Scripts\", "Machine")
			echo "";
		} else {
			echo "[ $ctime ] ---> Python3 was not successfully installed. Please download & install it manually from https://www.python.org/downloads/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> Python3: Unknown Error. Please download & install it manually from https://www.python.org/downloads/";
	echo ""; sleep 1;
}

### Oletools Installation
try {
	echo "[ $ctime ] -> Installing OLETools";
	If((python -V) -eq $null) { 
		echo "[ $ctime ] ---> Please install python first"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] -> Checking if oletools exist";
		$installPath = "C:\Users\user\AppData\Roaming\Python\Python39\site-packages\oletools"
		If((Test-Path $installPath) -eq $True){
			echo "[ $ctime ] -> Oletools already exist"; echo ""; sleep 1;
		} else {
			echo "[ $ctime ] --> oletools not found, Installing..."; 
			pip3 install -U --user oletools
			echo "";
			If((Test-Path $installPath) -eq $True){
				echo "[ $ctime ] ---> Oletools installed Successfully";
				echo "";
			} else {
				echo "[ $ctime ] ---> Oletools were Not installed successfully. Please download and install it manually from https://github.com/decalage2/oletools";
				echo "";
			}
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> oletools: Unknown Error. Please download & install it manually from https://github.com/decalage2/oletools";
	echo ""; sleep 1;
}

### Bulk Crap Uninstaller
echo "[ $ctime ] -> Checking if Bulk Crap Uninstaller is installed";
try {
	$installPath = $docsfolder + "\BCU"
	If((Test-Path $installPath) -eq $True) {
		echo "[ $ctime ] --> Bulk Crap Uninstaller already exists"; echo ""; sleep 1;
	} else {
		echo "[ $ctime ] --> Bulk Crap Uninstaller does not exist, Installing...";
		$SourceURL = "https://osdn.mirror.constant.com//bulk-crap-uninstaller/72271/BCUninstaller_4.16_portable.zip";
		$Installer = $env:TEMP + "\bcu.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Expand-Archive -LiteralPath $Installer -DestinationPath $installPath
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "[ $ctime ] ---> Bulk Crap Uninstaller successfully installed";
			echo "[ $ctime ] ---> Creating shortcut on Desktop";
			If((Test-Path $desktopfolder\BCUninstaller.lnk) -eq $False) { create-shortcut $installPath\BCUninstaller.exe "\Regshot.lnk"; }
			echo "";
		} else {
			echo "[ $ctime ] ---> Bulk Crap Uninstaller was not successfully installed. Please download & install it manually from https://www.bcuninstaller.com/";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "[ $ctime ] -> oletools: Unknown Error. Please download & install it manually from https://www.bcuninstaller.com/";
	echo ""; sleep 1;
}

### Disable Firewall & Defender
try {
	echo "";
	echo "[ $ctime ] -> Disabling Firewall & Defender"
	netsh advfirewall set allprofiles state off
	Set-MpPreference -DisableRealtimeMonitoring $true
	sleep 1;
} catch {
	echo "[ $ctime ] -> Unknown Error. Please disable the Firewall & Defender manually.";
	echo ""; sleep 1;
}
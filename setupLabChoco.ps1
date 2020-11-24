$apps64 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*;
$apps32 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*;
$username = $env:username;
$EnvPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path;
$progfiles = "C:\Program Files";
$progfiles86 = "C:\Program Files (x86)";
$docsfolder = "C:\Users\$username\Documents";
$desktopfolder = "C:\Users\$username\Desktop";
$listinstall = choco list --localonly

echo ""
echo "### Setting up your Phish Defense Lab ###"
echo ""

### Firefox Installation
If(($listinstall | Select-String -Pattern "Firefox") -ne $null) {
	echo "Firefox already exists"; sleep 1;
} else {
	choco install firefox -y
}

### Chrome Installation
If(($listinstall | Select-String -Pattern "chrome") -ne $null) {
	echo "Chrome already exists"; sleep 1;
} else {
	choco install googlechrome -y
}

### Adobe Reader Installation
If(($listinstall | Select-String -Pattern "adobereader") -ne $null) {
	echo "Adobe Reader already exists"; sleep 1;
} else {
	choco install adobereader -y
}

### Notepad++ Installation
If(($listinstall | Select-String -Pattern "Notepadplusplus") -ne $null) {
	echo "Notepad++ already exists"; sleep 1;
} else {
	choco install notepadplusplus -y
}

### JRE Installation
If(($listinstall | Select-String -Pattern "jre") -ne $null) {
	echo "JRE8 already exists"; sleep 1;
} else {
	choco install jre8 -y
}

### JRE Installation
If(($listinstall | Select-String -Pattern "git") -ne $null) {
	echo "GIT already exists"; sleep 1;
} else {
	choco install git -y
}

### Fiddler Installation
If(($listinstall | Select-String -Pattern "Fiddler") -ne $null) {
	echo "Fiddler already exists"; sleep 1;
} else {
	choco install fiddler -y
}

### SysInternal Suite Installation
If(($listinstall | Select-String -Pattern "sysinternals") -ne $null) {
	echo "SysInternals Suite already exists"; sleep 1;
} else {
	choco install sysinternals -y
}

### Wireshark Installation
If(($listinstall | Select-String -Pattern "Wireshark") -ne $null) {
	echo "Wireshark already exists"; sleep 1;
} else {
	choco install wireshark -y
}

### Process Hacker Installation
If(($listinstall | Select-String -Pattern "processhacker") -ne $null) {
	echo "Process Hacker already exists"; sleep 1;
} else {
	choco install processhacker.portable -y
}

### HashMyFiles Installation
If(($listinstall | Select-String -Pattern "hashmyfiles") -ne $null) {
	echo "HashMyFiles already exists"; sleep 1;
} else {
	choco install hashmyfiles -y
}

### PEStudio Installation
If(($listinstall | Select-String -Pattern "pestudio") -ne $null) {
	echo "PEStudio already exists"; sleep 1;
} else {
	choco install pestudio -y
}

### PSTools Installation
If(($listinstall | Select-String -Pattern "pstools") -ne $null) {
	echo "PSTools already exists"; sleep 1;
} else {
	choco install pstools -y
}

### 7-Zip Installation
If(($listinstall | Select-String -Pattern "7zip") -ne $null) {
	echo "7-Zip already exists"; sleep 1;
} else {
	choco install 7zip -y
}

### Python3 Installation
If(($listinstall | Select-String -Pattern "python") -ne $null) {
	echo "Python3 already exists"; sleep 1;
} else {
	choco install python3 -y
}

### Bulk Crap Uninstaller
If(($listinstall | Select-String -Pattern "bulk-crap-uninstaller") -ne $null) {
	echo "Bulk Crap Uninstaller already exists"; sleep 1;
} else {
	choco install bulk-crap-uninstaller -y
}

### File for Windows
try {
	$installPath = $progfiles86 + "\GnuWin32"
	If(($apps64.DisplayName -Match "GnuWin32: File") -or ($apps32.DisplayName -Match "GnuWin32: File")) {
		echo "File for Windows already exists"; echo ""; sleep 1;
	} else {
		echo "Installing file for Windows";
		$SourceURL = "https://github.com/processhacker/processhacker/releases/download/v2.39/processhacker-2.39-setup.exe";
		$Installer = $env:TEMP + "\phacker.exe";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		Start-Process -FilePath $Installer -Args "/VERYSILENT" -Verb RunAs -Wait;
		Remove-Item $Installer;
		If(($apps64.DisplayName -Match "GnuWin32: File") -or ($apps32.DisplayName -Match "GnuWin32: File")) {
			echo "File for Windows successfully installed";
			echo "Adding to Environment Variables";
			[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\bin\", "user")
			[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$installPath\bin\", "Machine")
			echo "";
		} else {
			echo "File for Windows was not successfully installed. Please download & manually install it from http://gnuwin32.sourceforge.net/packages/file.htm";
			echo "";
		}
		sleep 1;
	}
} catch {
	echo "File for Windows: Unknown Error. Please download & install it manually from http://gnuwin32.sourceforge.net/packages/file.htm";
	echo ""; sleep 1;
}

### Regshot installation
try {
	$installPath = $docsfolder + "\Regshot"
	If((Test-Path $installPath) -eq $True) {
		echo "Regshot already exists"; echo ""; sleep 1;
	} else {
		echo "Installing Regshot";
		$SourceURL = "https://excellmedia.dl.sourceforge.net/project/regshot/regshot/1.9.0/Regshot-1.9.0.7z";
		$Installer = $env:TEMP + "\Regshot.zip";
		Invoke-WebRequest $SourceURL -OutFile $Installer;
		7z.exe x $Installer -o"$installPath"
		Remove-Item $Installer;
		If((Test-Path $installPath) -eq $True) {
			echo "Regshot successfully installed";
		} else {
			echo "Regshot was not successfully installed. Please download & install manually from https://sourceforge.net/projects/regshot/";
		}
		sleep 1;
	}
} catch {
	echo "Regshot: Unknown Error. Please download & install it manually from https://sourceforge.net/projects/regshot/";
	echo ""; sleep 1;
}

### Oletools Installation
try {
	echo "Installing OLETools";
	If((python -V) -eq $null) { 
		echo "ERROR! Please install python first"; echo ""; sleep 1;
	} else {
		$installPath = "C:\Users\user\AppData\Roaming\Python\Python39\site-packages\oletools"
		If((Test-Path $installPath) -eq $True){
			echo "Oletools already exist"; echo ""; sleep 1;
		} else {
			echo "Installing oletools"; 
			pip3 install -U --user oletools
			echo "";
			If((Test-Path $installPath) -eq $True){
				echo "Oletools installed Successfully";
				echo "";
			} else {
				echo "Oletools were Not installed successfully. Please download and install it manually from https://github.com/decalage2/oletools";
				echo "";
			}
		}
		sleep 1;
	}
} catch {
	echo "Oletools: Unknown Error. Please download & install it manually from https://github.com/decalage2/oletools";
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
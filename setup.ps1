$vboxLoc = cmd.exe /c "where.exe VBoxManage"
$vagrLoc = cmd.exe /c "where.exe vagrant"

echo "Checking if VirtualBox is installed..."
sleep 2
If ($(Test-Path "$vboxLoc") -eq $True) {
	echo "VirtualBox is available"
	sleep 2
} else {
	echo "ERROR!!!"
	sleep 2
	echo "VirtualBox is not installed"
	echo "Please install it from https://www.virtualbox.org/wiki/Downloads"
	sleep 2
	exit
}

echo "Checking if Vagrant is installed..."
sleep 2
If ($(Test-Path "$vagrLoc") -eq $True) {
	echo "Vagrant is available"
	sleep 2
} else {
	echo "ERROR!!!"
	sleep 2
	echo "Vagrant is not installed"
	echo "Please install it from https://www.vagrantup.com/downloads"
	sleep 2
	exit
}

If ($(Test-Path "Vagrantfile") -eq $True) {
	echo "Vagrantfile is present"
	sleep 2
} else {
	echo "ERROR!!!"
	sleep 2
	echo "Vagrantfile is not present"
	echo "Please download it."
	sleep 2
	exit
}
echo "Searching for vagrant file..."

echo "Continuing with box installation"
sleep 2

$box_list = cmd.exe /c "vagrant box list"

If ($vagrant_box_list -match "prakharhans/pdc_win7") {
	echo "rapid7/metasploitable3-$os_short already found in Vagrant box repository. Skipping the addition to Vagrant."
} else {
	vagrant up
}
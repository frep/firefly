#!/bin/bash
###################################################################################
#  file: setup.sh
# autor: frep
###################################################################################
# paths and variables
###################################################################################

setupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


###################################################################################
# functions
###################################################################################

function assertLaunchStartxScriptExists {
	if [ ! -f ~/launchAtStartX.sh ]; then
    		# script does not exist yet. Create it!
    		cp ${setupdir}/launchAtStartX.sh ~/
  	fi
  	if [ ! -f ~/.config/autostart/launchAtStartX.desktop ]; then
		if [ ! -d ~/.config/autostart ]; then
			mkdir ~/.config/autostart
		fi
    		# launchAtStartX.desktop does not exist yet. Create it!
    		cp -f ${setupdir}/launchAtStartX.desktop ~/.config/autostart/
  	fi
}

function setupUserFrep {
	sudo cp ${setupdir}/20-lubuntu.conf /etc/lightdm/lightdm.conf.d/20-lubuntu.conf
	cp ${setupdir}/chromium-browser.desktop /home/frep/Desktop/
	cp ${setupdir}/lxterminal.desktop /home/frep/Desktop/
	cp ${setupdir}/.gitconfig /home/frep/
	cp ${setupdir}/.conkyrc /home/frep/
}

function createUserFrep {
	sudo adduser frep
	sudo addgroup frep sudo
	setupUserFrep
}

function setKeyboardlayout {
  	sudo dpkg-reconfigure keyboard-configuration
}

function setTimezone {
	sudo apt-get install --reinstall tzdata
  	sudo dpkg-reconfigure tzdata
}

function updateAndUpgrade {
	sudo apt-get update && sudo apt-get upgrade -y
}

function installBasics {
	sudo apt-get install nano git psmisc build-essential -y
}

function installConky {
	sudo apt-get install conky -y
}

function startConkyAtStartx {
	assertLaunchStartxScriptExists
	cat ~/launchAtStartX.sh | sed '/^exit 0/d' > tmpFile
	echo "# CONKY" >> tmpFile
	echo "killall conky" >> tmpFile
	echo "sleep 5" >> tmpFile
	echo "conky --config=.conky/.conkyrc -d &" >> tmpFile
	echo "" >> tmpFile
	echo "exit 0" >> tmpFile
	sudo mv tmpFile ~/launchAtStartX.sh
	sudo chmod +x ~/launchAtStartX.sh
}

function installROS {
	echo "Install ROS:"
	echo "set locale"
	sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
	echo "setup sources.list"
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
	echo "setup key"
	wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
	echo "installation"
	sudo apt-get update
	sudo apt-get install ros-indigo-ros-base -y
	echo "initialize rosdep"
	sudo apt-get install python-rosdep -y
	sudo rosdep init
	rosdep update
	echo "setup enviroment"
	echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	echo "get rosinstall"
	sudo apt-get install python-rosinstall -y
}

function setupVnc {
	sudo apt-get install netatalk x11vnc -y
	x11vnc -storepasswd
	if [ ! -f ~/.config/autostart/x11vnc.desktop ]; then
                if [ ! -d ~/.config/autostart ]; then
                        mkdir ~/.config/autostart
                fi
                # x11vnc.desktop does not exist yet. Create it!
                cp -f ${setupdir}/x11vnc.desktop ~/.config/autostart/
        fi
	# enable screensharing in finder on OS X
	if [ -d /etc/avahi/services ]; then
		sudo cp ${setupdir}/rfb.service /etc/avahi/services
		sudo cp ${setupdir}/afpd.service /etc/avahi/services
	fi
}

function installJava {
	# unpack archive
	sudo tar zxvf ${setupdir}/jdk-8u51-linux-arm-vfp-hflt.tar.gz -C /opt
	# Set default java and javac to the new installed jdk8
	sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_51/bin/javac 1
	sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_51/bin/java 1
	sudo update-alternatives --config javac
	sudo update-alternatives --config java
	# set JAVA_HOME variable and PATH
	sudo echo "JAVA_HOME=\"/opt/jdk1.8.0_51\"" >> /etc/environment
	echo "" >> ~/.bashrc
  	echo "export JAVA_HOME=\"/opt/jdk1.8.0_51\"" >> ~/.bashrc
  	echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
}

function installKaraf {
	# unpack archive
	sudo tar zxvf ${setupdir}/apache-karaf-4.0.0.tar.gz -C /opt
	# set KARAFHOME variable and PATH
	echo "" >> ~/.bashrc
  	echo "export KARAFHOME=\"/opt/karaf/apache-karaf-4.0.0\"" >> ~/.bashrc
  	echo "export PATH=\$PATH:\$KARAFHOME/bin" >> ~/.bashrc
}

function installOffice {
	sudo apt-get install evince libreoffice -y
}

function replaceNetworkManagerWithWicd {
	#install wicd
	sudo apt-get install wicd -y
	#uninstall networkmanager
	sudo service network-manager stop
  	sudo update-rc.d -f network-manager remove
  	sudo apt-get purge network-manager -y
	#reboot needed!
	sudo reboot
}

function startWifiatStartX {
	assertLaunchStartxScriptExists
        cat ~/launchAtStartX.sh | sed '/^exit 0/d' > tmpFile
        echo "# start WIFI interface wlan0" >> tmpFile
	echo "sudo wifi-on.sh" >> tmpFile
        echo "exit 0" >> tmpFile
        sudo mv tmpFile ~/launchAtStartX.sh
        sudo chmod +x ~/launchAtStartX.sh

}

###################################################################################
# program
###################################################################################

#updateAndUpgrade
#setKeyboardlayout
#setTimezone
#createUserFrep
#installBasics
#installConky
#startConkyAtStartx
#installROS
#setupVnc
#installJava
#installKaraf
#installOffice
#startWifiatStartX

# Restart is needed after following function
#replaceNetworkManagerWithWicd

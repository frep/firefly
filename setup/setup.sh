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
	if [ ! -f ~/launchAtStartx.sh ]; then
    		# script does not exist yet. Create it!
    		cp ${setupdir}/system/launchAtStartx.sh ~/
  	fi
  	if [ ! -f ~/.config/autostart/launchAtStartx.desktop ]; then
		if [ ! -d ~/.config/autostart ]; then
			mkdir ~/.config/autostart
		fi
    		# launchAtStartx.desktop does not exist yet. Create it!
    		cp -f ${setupdir}/system/launchAtStartx.desktop ~/.config/autostart/
  	fi
}

function createUserFrep {
	sudo adduser frep
	sudo addgroup frep sudo
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
	sudo apt-get install nano git -y
}

function useOwnBashRc {
	cp ${setupdir}/system/.bashrc ~/.bashrc
}

function installConky {
	sudo apt-get install conky -y
}

function startConkyAtStartx {
	assertLaunchStartxScriptExists
	cat ~/launchAtStartx.sh | sed '/^exit 0/d' > tmpFile
	echo "# CONKY" >> tmpFile
	echo "killall conky" >> tmpFile
	echo "sleep 5" >> tmpFile
	echo "conky --config=.conky/.conkyrc -d &" >> tmpFile
	echo "" >> tmpFile
	echo "exit 0" >> tmpFile
	sudo mv tmpFile ~/launchAtStartx.sh
	sudo chmod +x ~/launchAtStartx.sh
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


###################################################################################
# program
###################################################################################

#updateAndUpgrade
#setKeyboardlayout
#setTimezone
#createUserFrep
#installBasics
#useOwnBashRc
#installConky
#startConkyAtStartx
#installROS

###################################################################################
# reminders (not scripted)
###################################################################################

# NEW USER
# create new user with "sudo adduser <newUser>"  (not useradd ...)
# use "sudo addgroup <newUser> <group>" for the following groups:
# adm dialout cdrom audio dip video plugdev admin

# AUTOLOGIN FREP IN XFCE
# change /etc/lxdm/default.conf:
# autologin=frep
# session=/usr/bin/startxfce4

# ROS -> Verifying os name
# change /etc/lsb-release to the following:
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=14.04
# DISTRIB_CODENAME=trusty
# DISTRIB_DESCRIPTION="Ubuntu 14.04"


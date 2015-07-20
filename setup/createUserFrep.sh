#!/bin/bash
###################################################################################
#  file: createUserFrep.sh
# autor: frep
###################################################################################
# paths and variables
###################################################################################

setupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


###################################################################################
# functions
###################################################################################

function setupUserFrep {
	sudo cp ${setupdir}/20-lubuntu.conf /etc/lightdm/lightdm.conf.d/20-lubuntu.conf
	sudo mkdir /home/frep/Desktop
	sudo cp ${setupdir}/chromium-browser.desktop /home/frep/Desktop/
	sudo cp ${setupdir}/lxterminal.desktop /home/frep/Desktop/
	sudo cp ${setupdir}/.gitconfig /home/frep/
	sudo cp ${setupdir}/.conkyrc /home/frep/
}

function createUserFrep {
	# sudo adduser frep
	# sudo addgroup frep sudo
	setupUserFrep
}


###################################################################################
# program
###################################################################################

createUserFrep

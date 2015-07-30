Steps to setup the firefly-rk3288
=================================
1. get this repository (probably needed to install git first)
2. inspect/adjust manageUsers.sh and setup.sh (after installing nano or an editor of your choice)
3. Optional: run `./manageUsers.sh`
4. Run `./setup.sh`

setup.sh description
--------------------
The `setup.sh` script provides the following functions:
* adjusting Timezone (dpkg-reconfigure tzdata)
* update and upgrade functions
* installation of conky
* installation of ROS
* setup VNC server
* installation of java8 
* installation of karaf
* installation of the xubuntu desktop

ToDo's
------
- [x] separation of user management and rest of setup.
- [x] setup.sh: move delete default user firefly into setup.sh (untested)
- [x] manageUsers.sh: change root password
- [ ] setup.sh: try to update bluez
- [ ] setup.sh: install ruby (? or get used to python)
- [ ] setup.sh: install InoTool and Arduino
- [x] setup.sh: use wicd ? -> keep networkmanager due to some wicd - problems!
- [ ] get used to gpio's 
- [x] setup.sh: install libreoffice and pdfviewer

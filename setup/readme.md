Steps to setup the firefly-rk3288
=================================
1. get this repository (probably needed to install git first)
2. inspect/adjust manageUsers.sh and setup.sh (after installing nano or an editor of your choice)
3. Optional: run `./manageUsers.sh`
4. Run `./setup.sh`

ToDo's
------
- [x] separation of user management and rest of setup.
- [x] manageUsers.sh: delete default user firefly
- [x] manageUsers.sh: change root password
- [x] setup.sh: install Java 8
- [x] setup.sh: install Karaf
- [x] use separate repository for java (https://github.com/frep/JavaArm)
- [ ] setup.sh: try to update bluez
- [ ] setup.sh: install ruby (? or get used to python)
- [ ] setup.sh: install InoTool and Arduino
- [x] setup.sh: use wicd ? -> keep networkmanager due to some wicd - problems!
- [x] setup.sh: maybe using xfce ? -> installation of xubuntu works!
- [ ] get used to gpio's 
- [x] setup.sh: install libreoffice and pdfviewer

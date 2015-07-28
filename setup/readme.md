Steps to setup the firefly-rk3288
=================================
1. get this repository (probably needed to install git first)
2. inspect setup.sh (after installing nano or an editor of your choice)
3. Optional: run `./manageUsers.sh.sh`
4. Run `./setup.sh`

ToDo's
------
- [x] separation of create User and rest of setup.
- [x] createUserFrep.sh: delete default user firefly
- [x] setup.sh: install Java 8
- [x] setup.sh: install Karaf
- [ ] use separate repository for additional/optional software like java, karaf, etc
- [ ] setup.sh: install ruby (? or get used to python)
- [ ] setup.sh: install InoTool and Arduino
- [x] setup.sh: use wicd ? -> keep networkmanager due to some wicd - problems!
- [ ] setup.sh: maybe using xfce ?
- [ ] get used to gpio's 
- [x] setup.sh: install libreoffice and pdfviewer

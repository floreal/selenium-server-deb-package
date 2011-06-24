# Synopsis

This project is meant to automate debian package for selenium-server
It will automatically download selenium-server from google code
file repository and package it with init.d scripts. 

# Builing

In order to build the debian package just run
  $ ./build.sh pkg [version]

Then it will be found in pkg sub directory
 
To remove the build package:
  $ ./build.sh clean
  
# Running

to run selenium-server daemon just use selenium server init script

# OniMeshLauncher For OSX
___

## Prerequisites

##### OpenNI2 SDK (version 2.2 beta currently)   
    http://structure.io/openni
##### OpenNI2 Installation Instructions OSX
1. Download the zipped OSX file
2. Double click the downloaded file to unzip the folder
3. Move the folder to the desired install directory ("/Applications" suggested for minimal build configuration, if installing to a different location use your selected install path in place of "/Applications" in the commands below)
4. Open a Terminal window
5. Enter the command `sudo /Applications/OpenNI-MacOSX-x64-2.2/install.sh`
6. Enter your admin password when prompted to install OpenNI2
##### OniMesh Placed in the Applications folder 
1. Clone the onimesh repository to your applications folder
2. Open a Terminal window
3. In Terminal, navigate to /Applications/onimesh
4. Enter the command 'make'
5. Output binary is located in the "bin" directory

##### OniMeshLauncher Placed in Applications folder
1. OniMeshLauncher has a forked repository that contains the exported application from xcode.
2. This exported application simply needs to be moved to the /Applications folder.
3. Once OniMeshLauncher is in the /Applications folder simply double click on it and it will launch.
### Usage
1. The user clicks Select ONI Files
2. The user clicks Select Output Directory
3. The user clicks Launch OniMesh
#### Important Usage Notes:
* Only ONI Files are used by OniMesh
  


### Credit
* Credit for the README editor goes to http://dillinger.io

License
----

MIT


**Free Software, Hell Yeah!**





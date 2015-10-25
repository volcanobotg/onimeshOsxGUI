/////////////////////////////////////////////////////////////////////////////////////////
//  OMTask.m
//  OniMesh Launcher
//
//  This is the Implementation for OMTask. OMTask is a class to handle the launching of
//  an external program. In this instance it is being used to launch a program called
//  OniMesh.
//
//  Created by David Andrews on 10/16/15.
//  Copyright © 2015 edu.volcanobotg.csci4738.dandrews. All rights reserved.
/////////////////////////////////////////////////////////////////////////////////////////

#import "OMTask.h"

@implementation OMTask {
    NSTask *task;
}

/////////////////////////////////////////////////////////////////////////////////////////
//StartTask
//Purpose: StartTask is the method that launches the external program OniMesh. StartTask
//         is called from the LaunchOniMeshButton method. In StartTask OniMesh is
//         launched passing in the selected files and selected output from the user.
//         StartTask also opens communications to OniMesh through pipes. These pipes
//         dump into a file until after the executable terminates. It then displays the
//         output in the console through NSLog.
/////////////////////////////////////////////////////////////////////////////////////////
-(void)StartTask{
    
    NSLog(@"My argument array: %@",_argumentArray);
    //Initializes the process
    task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = [pipe fileHandleForReading];
    
    //Launch path is where the executable to be launched is located.
    [task setCurrentDirectoryPath:@"/Applications/onimesh/bin"];
    [task setLaunchPath:@"/Applications/onimesh/bin/onimesh"];
    
    //This sets the array used for arguments sent to the launched program.
    [task setArguments:_argumentArray];
    
    //This sets the launched programs input and output to pipes so that they can
    //be read at a later time.
    [task setStandardOutput:pipe];
    [task setStandardError:[task standardOutput]];
    [task setStandardInput:[NSPipe new]];
    
    //The actual launch command after inititializations.
    [task launch];
    
    //Pauses the GUI until the launched program returns.
    [task waitUntilExit];
    
    //This is where the output from the launched program is read from the file it
    //was sent to.
    NSData *dataRead = [file readDataToEndOfFile];
    NSString *stringRead = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];
    NSLog(@"output: %@", stringRead);
    
}


@end

/////////////////////////////////////////////////////////////////////////////////////////



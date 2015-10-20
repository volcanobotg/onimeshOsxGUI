//
//  OMTask.m
//  OniMesh Launcher
//
//  Created by David Andrews on 10/16/15.
//  Copyright © 2015 edu.volcanobotg.csci4738.dandrews. All rights reserved.
//

#import "OMTask.h"

@implementation OMTask {
    NSTask *task;
}


-(void)StartTask{
    
    task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = [pipe fileHandleForReading];
    
    //[task setLaunchPath:@"/Users/davchrand/Desktop/Test"];
    [task setLaunchPath:@"/Users/davchrand/Desktop/GitRepositories/onimesh/bin/onimesh"];
    NSArray *argumentArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",@"/Users/davchrand/Desktop", @"/Users/davchrand/Desktop/StillVideo.oni"], nil];
    [task setArguments:argumentArray];
    NSLog(@"Made it here");
    [task setStandardOutput:pipe];
    [task setStandardError:[task standardOutput]];
    [task setStandardInput:[NSPipe new]];
    
    [task launch];
    [task waitUntilExit];
    
    NSData *dataRead = [file readDataToEndOfFile];
    NSString *stringRead = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];
    NSLog(@"output: %@", stringRead);
}


@end





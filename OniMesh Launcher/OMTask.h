/////////////////////////////////////////////////////////////////////////////////////////
//  OMTask.h
//  OniMesh Launcher
//
//  This is the Header file for OMTask. OMTask is a class to handle the launching of
//  an external program. In this instance it is being used to launch a program called
//  OniMesh.
//
//  Created by David Andrews on 10/16/15.
//  Copyright © 2015 edu.volcanobotg.csci4738.dandrews. All rights reserved.
/////////////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>


@interface OMTask : NSObject
@property NSString *argumentString;

-(void)StartTask;


@end


/////////////////////////////////////////////////////////////////////////////////////////


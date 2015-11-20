/*
 * Copyright (c) 2015-, Christopher Padgett, David Andrews, Luis Henrique Fae Barboza
 *
 * You may use, distribute and modify this code under the terms of the BSD license.
 *
 * You should have received a copy of the full BSD license with this file.
 * If not, please visit: https://github.com/volcanobotg/onimeshOsxGUI for full license information.
 */

/////////////////////////////////////////////////////////////////////////////////////////
//  OMTask.h
//  OniMesh Launcher
//
//  This is the Header file for OMTask. OMTask is a class to handle the launching of
//  an external program. In this instance it is being used to launch a program called
//  OniMesh.
/////////////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>


@interface OMTask : NSObject
@property NSArray *argumentArray;

-(void)StartTask;


@end


/////////////////////////////////////////////////////////////////////////////////////////


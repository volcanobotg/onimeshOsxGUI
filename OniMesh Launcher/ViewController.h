/*
 * Copyright (c) 2015-, Christopher Padgett, David Andrews, Luis Henrique Fae Barboza
 *
 * You may use, distribute and modify this code under the terms of the BSD license.
 *
 * You should have received a copy of the full BSD license with this file.
 * If not, please visit: https://github.com/volcanobotg/onimeshOsxGUI for full license information.
 */

/////////////////////////////////////////////////////////////////////////////////////////
//  ViewController.h
//  OniMesh Launcher
//
//  This is the header file for the view controller. It has the link to the output
//  label for the application output.
/////////////////////////////////////////////////////////////////////////////////////////


#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *outputLabel;


@end


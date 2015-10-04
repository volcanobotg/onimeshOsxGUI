//
//  ViewController.m
//  Oni-Mesh
//
//  Created by David Andrews on 10/3/15.
//  Copyright © 2015 edu.volcanobotg.csci4738.dandrews. All rights reserved.
//

#import "ViewController.h"
NSArray* fileNames;
NSURL *saveOutputUrl;
void _writeToTextFile();
BOOL fileWasCreated;

@implementation ViewController

@synthesize outputLabel = _outputLabel;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)selectFilesButton:(id)sender {
    
    // Get the main window for the document.
    NSWindow* window = [[[NSApplication sharedApplication ] windows] objectAtIndex:0];
    
    // Create and configure the panel.
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
    [panel setCanChooseDirectories:YES];
    [panel setAllowsMultipleSelection:YES];
    [panel setMessage:@"Import one or more files or directories."];
    
    // Display the panel attached to the document's window.
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        
        if (result == NSFileHandlingPanelOKButton) {
            
            fileNames = [panel URLs];
        }
        
    }];
    fileWasCreated = true;
    
}
- (IBAction)startButtonPressed:(id)sender {
    
    if (fileWasCreated){
        
        [_outputLabel setStringValue:@"Process has been Started"];
        // create the string to be written
        NSString * myString = [[NSString alloc]init];
        NSUInteger arraySize = [fileNames count];
        for (int i = 0; i < arraySize; i++)
        {
            myString = [myString stringByAppendingFormat:@"%@\n", fileNames[i]];
        }
        // get the file url
        NSSavePanel * outputSavePanel = [NSSavePanel savePanel]; NSInteger fileNamesOutput = [outputSavePanel runModal];
        if (fileNamesOutput == NSFileHandlingPanelCancelButton) { NSLog(@"writeUsingSavePanel cancelled"); return; }
        saveOutputUrl = [outputSavePanel URL];
    
        //write
        BOOL stringBoolResult = [myString writeToURL:saveOutputUrl atomically:YES encoding:NSASCIIStringEncoding error:NULL];
        if (! stringBoolResult) {
            NSLog(@"writeUsingSavePanel failed");
        }
    }
    else {
        NSLog(@"Error: No Files Have Been Selected\n");
        [_outputLabel setStringValue:@"Error: No Files Have Been Selected"];
    }
}

- (IBAction)stopButtonPressed:(id)sender {
    
    if (fileWasCreated) {
        
        NSFileManager *myFile = [[NSFileManager alloc] init];
        NSError *error = nil;
        if (![myFile removeItemAtURL:saveOutputUrl error:&error]) {
            NSLog(@"Error: %@", error);
        }
        [_outputLabel setStringValue:@"Process has been Stopped"];
    }
    else{
        
        NSLog(@"Error: No Files Have Been Selected");
        [_outputLabel setStringValue:@"Error: No Files Have Been Selected"];
    }
}

- (IBAction)pauseButtonPressed:(id)sender {
    if (fileWasCreated){
        [_outputLabel setStringValue:@"Pause Button works but does not have full functionality"];
    }
    else {
        
        [_outputLabel setStringValue:@"Error: No Files Have Been Selected"];
    }
    
}



@end

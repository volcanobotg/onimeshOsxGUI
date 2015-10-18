///////////////////////////////////////////////////////////////////////////////////////
//  ViewController.m
//  Oni-Mesh
//
//  Created by David Andrews on 10/3/15.
//  Copyright © 2015 edu.volcanobotg.csci4738.dandrews. All rights reserved.
///////////////////////////////////////////////////////////////////////////////////////

#import "ViewController.h"

//Global Variables
NSArray* fileNames; //takes file names that are selected
NSURL *saveOutputUrl; //takes the output path selected
BOOL fileWasCreated; //Bool to prevent deprecations by Stop and Pause buttons
BOOL fileWasSelected; //Bool to let Start button know if a file has been selected

void _writeToTextFile(); //function prototype


@implementation ViewController

@synthesize outputLabel = _outputLabel;

///////////////////////////////////////////////////////////////////////////////////////
//viewDidLoad
//Purpose: Standard xcode function for loading and refreshing the view.
//
///////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

///////////////////////////////////////////////////////////////////////////////////////
//setRepresentedObject
//Purpose: Standard xcode function for updating the view
//
///////////////////////////////////////////////////////////////////////////////////////
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

///////////////////////////////////////////////////////////////////////////////////////
//selectFilesButton
//Purpose: Responds to when the user clicks the Select Files button. When the button
//         is pressed opens a file browser window for the user to navigate to and
//         select files to be used by the program.
//Credit:  https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/UsingtheOpenandSavePanels/UsingtheOpenandSavePanels.html
//
///////////////////////////////////////////////////////////////////////////////////////
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
    fileWasSelected = true;
    
}

///////////////////////////////////////////////////////////////////////////////////////
//startButtonPressed
//Purpose: Responds to when the user clicks Start button. If files have been selected
//         startButtonPressed creates a text file with the URLs of the selected files.
//         The text file is saved to a user specified directory. The user selects the
//         save destination by using the native OSX save panel. If files have not been
//         selected then a message is displayed in the application telling the user to
//         select files.
//Credit: http://juliuspaintings.co.uk/cgi-bin/paint_css/animatedPaint/035-Simple-Read-Write.pl
//
///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)startButtonPressed:(id)sender {
    
    if (fileWasSelected){
        fileWasCreated = true;
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
            [_outputLabel setStringValue:@"writeUsingSavePanel failed"];
        }
    }
    else {
        //NSLog(@"Error: No Files Have Been Selected\n");
        [_outputLabel setStringValue:@"Error: No Files Have Been Selected"];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
//stopButtonPressed
//Purpose: stopButtonPressed responds to the user clicking Stop. If the user has
//         clicked Start previously the program will delete the text file that
//         was created by the startButtonPressed function. If the user just clicks
//         Stop the function returns message saying the process has not been started.
//
///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)stopButtonPressed:(id)sender {
    
    if (fileWasCreated) {
        
        fileWasCreated = false;
        NSFileManager *myFile = [[NSFileManager alloc] init];
        NSError *error = nil;
        if (![myFile removeItemAtURL:saveOutputUrl error:&error]) {
            //NSLog(@"Error: %@", error);
        }
        [_outputLabel setStringValue:@"Process has been Stopped"];
    }
    else{
        
        //NSLog(@"Error: No Files Have Been Selected");
        [_outputLabel setStringValue:@"Process has not been Started"];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
//pauseButtonPressed
//Purpose: pauseButtonPressed responds to the user clicking Pause. When Pause is
//         clicked after Start, displays a message that Pause has not been fully
//         implemented. If clicked before Start displays a message to the user that
//         the Process has not been Started.
//
///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)pauseButtonPressed:(id)sender {
    if (fileWasCreated){
        [_outputLabel setStringValue:@"Pause Button works but does not have full functionality"];
    }
    else {
        
        [_outputLabel setStringValue:@"Process has not been Started"];
    }
    
}



@end
///////////////////////////////////////////////////////////////////////////////////////
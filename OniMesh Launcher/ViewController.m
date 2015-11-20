/*
 * Copyright (c) 2015-, Christopher Padgett, David Andrews, Luis Henrique Fae Barboza
 *
 * You may use, distribute and modify this code under the terms of the BSD license.
 *
 * You should have received a copy of the full BSD license with this file.
 * If not, please visit: https://github.com/volcanobotg/onimeshOsxGUI for full license information.
 */

////////////////////////////////////////////////////////////////////////////////////////
//  ViewController.m
//  OniMesh Launcher
//
//  This is the implementation file for the view controller. It has the implementation
//  for the buttons on OniMesh Launcher.
////////////////////////////////////////////////////////////////////////////////////////


#import "ViewController.h"
#import "OMTask.h"


////////////////////////////////////////////////////////////////////////////////////////
//Global Variables
////////////////////////////////////////////////////////////////////////////////////////

//takes file names that are selected
NSArray* fileNames;
//takes the output path selected
NSURL *saveOutputUrl;
//Bool to prevent deprecations by Stop and Pause buttons
BOOL outputFileWasSelected = false;
//Bool to let Start button know if a file has been selected
BOOL fileWasSelected;

NSArray *omArgArray;

////////////////////////////////////////////////////////////////////////////////////////


@implementation ViewController {
    //Makes an object of OMTask for use by LaunchOniMeshButton
    OMTask *theTask;
}

@synthesize outputLabel = _outputLabel;

///////////////////////////////////////////////////////////////////////////////////////
//viewDidLoad
//
//Purpose: Standard Xcode function for loading and refreshing the view.
//
///////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    theTask = [[OMTask alloc] init];
    theTask.argumentArray = [[NSArray alloc] init];
}

///////////////////////////////////////////////////////////////////////////////////////
//setRepresentedObject
//
//Purpose: Standard Xcode function for updating the view
//
///////////////////////////////////////////////////////////////////////////////////////

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

///////////////////////////////////////////////////////////////////////////////////////
//selectONIFilesButton
//
//Purpose: Responds to when the user clicks the Select ONI Files button. When the button
//         is pressed opens a file browser window for the user to navigate to and
//         select ONI files to be used by the program.
//
//Credit:  https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/UsingtheOpenandSavePanels/UsingtheOpenandSavePanels.html
//
///////////////////////////////////////////////////////////////////////////////////////

- (IBAction)selectONIFilesButton:(id)sender {
    
    // Get the main window for the document.
    NSWindow* window = [[[NSApplication sharedApplication ] windows] objectAtIndex:0];
    
    // Create and configure the panel.
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:YES];
    [panel setMessage:@"Import one or more files."];
    
    // Display the panel attached to the applications window.
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        
        if (result == NSFileHandlingPanelOKButton) {
            
            fileNames = [panel URLs];
            
            //Lets the user know that they have selected files to be processed.
            [_outputLabel setStringValue:@"Files have been Selected"];
        }
        
    }];
    
    //Sets the boolean to true so that selectOutputDirectoryButton can proceed to
    //letting the user select an output.
    fileWasSelected = true;

}

///////////////////////////////////////////////////////////////////////////////////////
//selectOutputDirectoryButton
//
//Purpose: Responds to when the user clicks Select Output Directory button.
//         If files have been selected the user can select an output directory.
//         The user selects the save destination by using the native OSX save panel.
//         If files have not been selected then a message is displayed in the
//         application telling the user to select files.
//
//Credit: http://juliuspaintings.co.uk/cgi-bin/paint_css/animatedPaint/035-Simple-Read-Write.pl
//
///////////////////////////////////////////////////////////////////////////////////////

- (IBAction)selectOutputDirectoryButton:(id)sender {
    
    if (fileWasSelected){
        
        //Sets the boolean to true so that LaunchOniMeshButton can proceed to launching
        //the task.
        outputFileWasSelected = true;
        
        //Message to the user that an output location is being selected.
        [_outputLabel setStringValue:@"Output Location is being Selected"];
        
        //Create a NSOpenPanel and set its configuration
        NSOpenPanel * outputPanel = [NSOpenPanel openPanel];
        [outputPanel setCanChooseDirectories:YES];
        [outputPanel setCanCreateDirectories:YES];
        [outputPanel setMessage:@"Select the output directory."];
        
        //Display the panel to the user
        [outputPanel beginWithCompletionHandler:^(NSInteger result){
            //Only save the url if the ok button was pressed
            if (result == NSFileHandlingPanelOKButton) {
                //Sets the global saveOutputUrl to the file path that was selected for output.
                saveOutputUrl = [outputPanel URL];
                
                //Sends a messge to the user telling them that the output location has been
                //selected.
                NSString *outputString = @"Output locaction is being selected\n";
                outputString = [outputString stringByAppendingString:@"Output location has been selected\n "];
                [_outputLabel setStringValue:outputString];
            }
        }];
    }
    
    else {
        //NSLog(@"Error: No Files Have Been Selected\n");
        [_outputLabel setStringValue:@"Error: No .oni Files Have Been Selected"];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
//launchOniMeshButton
//
//Purpose: launchOniMeshButton responds to the user clicking Launch OniMesh.
//         If the user has satisfied SelectONIFilesButton and SelectOutputDirectoryButton
//         the application will launch OniMesh.
//         If the user has not satisfied SelectONIFilesButton and
//         SelectOutputDirectoryButton launchOniMeshButton with display a message
//         saying the process has not been started.
//
///////////////////////////////////////////////////////////////////////////////////////

- (IBAction)launchOniMeshButton:(id)sender {
    
    if (outputFileWasSelected) {
        
        //Sets the boolean back to false to restrict the user from activating multiple
        //times.
        outputFileWasSelected = false;
        
        //Creates onimesh argument array from output url and file names
        omArgArray = @[saveOutputUrl];
        omArgArray = [omArgArray arrayByAddingObjectsFromArray:fileNames];
        
        //Outputs to the GUI output to tell the user that it has launched OniMesh.
        NSString *waitForOniMeshString = @"OniMesh has been Launched\n";
        waitForOniMeshString = [waitForOniMeshString stringByAppendingString:@"Please wait for OniMesh to complete\n"];
        [_outputLabel setStringValue:waitForOniMeshString];
        
        //Calls StartTask from OMTask with our object of OMTask "theTask."
        theTask.argumentArray = omArgArray;
        [theTask StartTask];
        
        
        //Debugging calls to console to show what files paths were used.
        //NSLog(@"\nFiles to be read in:\n%@",myString);
        NSString * outputLocation = [saveOutputUrl absoluteString];
        NSString *launchOutputString = @"OniMesh has been Launched\n";
        launchOutputString = [launchOutputString stringByAppendingString:@"OniMesh has completed\n"];
        launchOutputString = [launchOutputString stringByAppendingString:@"OniMesh has output to\n"];
        launchOutputString = [launchOutputString stringByAppendingString:outputLocation];
        [_outputLabel setStringValue:launchOutputString];
        //NSLog(@"\nOutput Location \n%@\n", outputLocation);
        
        
    }
    
    else{
        //Sends message to the output to tell the user to select an output location.
        [_outputLabel setStringValue:@"Output Location has not been Selected"];
    }
}

@end


/////////////////////////////////////////////////////////////////////////////////////////


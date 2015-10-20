//
//  ViewController.m
//  OniMesh Launcher
//
//  Created by David Andrews on 10/18/15.
//  Copyright © 2015 David Andrews. All rights reserved.
//

#import "ViewController.h"
#import "OMTask.h"


////////////////////////////////////////////////////////////////////////////////////////
//Global Variables
////////////////////////////////////////////////////////////////////////////////////////
NSArray* fileNames; //takes file names that are selected
NSURL *saveOutputUrl; //takes the output path selected
BOOL outputFileWasSelected = true; //Bool to prevent deprecations by Stop and Pause buttons
BOOL fileWasSelected; //Bool to let Start button know if a file has been selected

////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////
//Function Prototypes
////////////////////////////////////////////////////////////////////////////////////////


@implementation ViewController {
    OMTask *theTask;
}

@synthesize outputLabel = _outputLabel;

///////////////////////////////////////////////////////////////////////////////////////
//viewDidLoad
//Purpose: Standard xcode function for loading and refreshing the view.
//
///////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    theTask = [[OMTask alloc] init];
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
//selectONIFilesButton
//Purpose: Responds to when the user clicks the Select Files button. When the button
//         is pressed opens a file browser window for the user to navigate to and
//         select files to be used by the program.
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
    //[panel setAllowedFileTypes:oni];
    [panel setMessage:@"Import one or more files."];
    
    // Display the panel attached to the document's window.
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        
        if (result == NSFileHandlingPanelOKButton) {
            
            fileNames = [panel URLs];
            [_outputLabel setStringValue:@"Files have been Selected"];
        }
        
    }];
    fileWasSelected = true;

}

///////////////////////////////////////////////////////////////////////////////////////
//selectOutputDirectoryButton
//Purpose: Responds to when the user clicks Start button. If files have been selected
//         startButtonPressed creates a text file with the URLs of the selected files.
//         The text file is saved to a user specified directory. The user selects the
//         save destination by using the native OSX save panel. If files have not been
//         selected then a message is displayed in the application telling the user to
//         select files.
//Credit: http://juliuspaintings.co.uk/cgi-bin/paint_css/animatedPaint/035-Simple-Read-Write.pl
//
///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)selectOutputDirectoryButton:(id)sender {
    
    if (fileWasSelected){
        outputFileWasSelected = true;
        [_outputLabel setStringValue:@"Output Location is being Selected"];
        
        
        // get the file url
        NSSavePanel * outputSavePanel = [NSSavePanel savePanel];
        NSInteger fileNamesOutput = [outputSavePanel runModal];
        //[outputSavePanel setCanChooseDirectories:YES];
        if (fileNamesOutput == NSFileHandlingPanelCancelButton) {
            NSLog(@"writeUsingSavePanel cancelled");
            outputFileWasSelected = false;
            return;
        }
        saveOutputUrl = [outputSavePanel URL];
        
        //write
        /*BOOL stringBoolResult = [myString writeToURL:saveOutputUrl atomically:YES encoding:NSASCIIStringEncoding error:NULL];
         if (! stringBoolResult) {
         [_outputLabel setStringValue:@"Selection of Output Location failed!"];
         }*/
        [_outputLabel setStringValue:@"Output Location has been Selected"];
    }
    
    else {
        //NSLog(@"Error: No Files Have Been Selected\n");
        [_outputLabel setStringValue:@"Error: No .oni Files Have Been Selected"];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
//launchOniMeshButton
//Purpose: stopButtonPressed responds to the user clicking Stop. If the user has
//         clicked Start previously the program will delete the text file that
//         was created by the startButtonPressed function. If the user just clicks
//         Stop the function returns message saying the process has not been started.
//
///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)launchOniMeshButton:(id)sender {
    
    [theTask StartTask];
    if (outputFileWasSelected) {
        
        
        //outputFileWasSelected = false;
        
        //NSFileManager *myFile = [[NSFileManager alloc] init];
        //NSError *error = nil;
        /*if (![myFile removeItemAtURL:saveOutputUrl error:&error]) {
         //NSLog(@"Error: %@", error);
         }*/
        // create the string to be written
        NSString * myString = [[NSString alloc]init];
        NSUInteger arraySize = [fileNames count];
        for (int i = 0; i < arraySize; i++)
        {
            myString = [myString stringByAppendingFormat:@"%@\n", fileNames[i]];
        }
        
        
        
        [theTask StartTask];
        
        
        
        NSLog(@"\nFiles to be read in:\n%@",myString);
        
        NSString * outputLocation = [saveOutputUrl absoluteString];
        NSLog(@"\nOutput Location \n%@\n", outputLocation);
        [_outputLabel setStringValue:@"OniMesh has been Launched"];
    }
    else{
        
        //NSLog(@"Error: No Files Have Been Selected");
        [_outputLabel setStringValue:@"Output Location has not been Selected"];
    }
}

@end

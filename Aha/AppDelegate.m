//
//  AppDelegate.m
//  Aha
//
//  Created by Tim Hart on 10/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "HelloWorldLayer.h"

@implementation AhaAppDelegate
@synthesize window=window_, glView=glView_, mainScene=mainScene_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

	// enable FPS and SPF
	//[director setDisplayStats:YES];
	
	// connect the OpenGL view with the director
	[director setView:glView_];

	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
	
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
	
	// Center main window
	[window_ center];
	
    CCScene *scene = [HelloWorldLayer scene];
    
    //Assign this to the property of app delegate. This is done so we can send the scene messages from the xib.
    mainScene_ = scene;
    
	[director runWithScene:scene];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[CCDirector sharedDirector] end];
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

//This shit doesn't work. Not sure why. I'll just build it into the Scene. How to send message from XIB to the scene?
/*
- (IBAction)resetCountinMainScene:(id)sender    {
    //Forget the warning here. It works mofo.
    HelloWorldLayer *layer = (HelloWorldLayer*)mainScene_;
    [layer performSelector:@selector(resetDingCount)];
}
 */
@end

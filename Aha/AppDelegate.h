//
//  AppDelegate.h
//  Aha
//
//  Created by Tim Hart on 10/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "HelloWorldLayer.h"

@interface AhaAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;
@property (strong) CCScene *mainScene;

- (IBAction)toggleFullScreen:(id)sender;

- (IBAction)resetCountinMainScene:(id)sender;

@end

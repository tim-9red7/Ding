//
//  HelloWorldLayer.h
//  Aha
//
//  Created by Tim Hart on 10/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

@property (assign) CCSprite *button;
@property (assign) CCLabelTTF *label;
@property (assign) CCLabelTTF *reset;
@property int ahaCount;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)updateLabel;

-(void)resetDingCount;

@end

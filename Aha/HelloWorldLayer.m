//
//  HelloWorldLayer.m
//  Aha
//
//  Created by Tim Hart on 10/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize button, label, ahaCount, reset;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]) ) {
		
        //Preload the textures
        [[CCTextureCache sharedTextureCache] addImage:@"bell.png"];
        [[CCTextureCache sharedTextureCache] addImage:@"belldown.png"];

        CCSprite *backgroud = [CCSprite spriteWithFile:@"dingBackground.png"];
        backgroud.anchorPoint = ccp(0,0);
        backgroud.position = ccp(0,0);
        [self addChild:backgroud];
        
		// create and initialize a Label
		label = [CCLabelTTF labelWithString:@"Dings: 0" fontName:@"Helvetica" fontSize:48];
        [label setColor:ccBLACK];
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( size.width /2 , size.height/8);
        
		[self addChild:label z:2];
        
        
        button = [CCSprite spriteWithFile:@"bell.png"];
        
        button.position = ccp(size.width /2, size.height/1.8);
        [self addChild:button z:1 tag:1];
        
        reset = [CCLabelTTF labelWithString:@"Reset Count" fontName:@"Helvetica" fontSize:16];
        [reset setColor:ccBLACK];
        reset.position = ccp(5,5);
        reset.anchorPoint = ccp(0,0);
        [self addChild:reset z:3 tag:2];
        
        //preload the sound
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"alright.mp3"];
        
        //turn on the mouse
        self.isMouseEnabled = YES;
        self.isKeyboardEnabled = YES;
        
        //Set ahaCount
        ahaCount = 0;
        
    
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(BOOL)ccMouseUp:(NSEvent *)event {
    CGPoint clickLocation = [[CCDirector sharedDirector] convertEventToGL:event];
    //Still need to implement the ability to up scores of players
    if (CGRectContainsPoint([[self getChildByTag:1] boundingBox], clickLocation)){
    
        CCTexture2D *t = [[CCTextureCache sharedTextureCache] textureForKey:@"bell.png"];
        [button setTexture:t];
       
        
        
        //Animation this mofo
        /*
        CGFloat x = button.position.x;
        CGFloat y = button.position.y;
        CCMoveTo *right = [CCMoveTo actionWithDuration:.1 position:CGPointMake(x + 1, y)];
        CCMoveTo *left = [CCMoveTo actionWithDuration:.1 position:CGPointMake(x - 1, y)];
        
        //CCSequence *seq = [CCSequence ac]
        [button runAction:right];
        [button runAction:left];
         */
    }
    return YES;
}

-(BOOL)ccMouseDown:(NSEvent *)event {
    
    CGPoint clickLocation = [[CCDirector sharedDirector] convertEventToGL:event];
    //Still need to implement the ability to up scores of players
    if (CGRectContainsPoint([[self getChildByTag:1] boundingBox], clickLocation)){
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.mp3" ];
        CCTexture2D *t = [[CCTextureCache sharedTextureCache] textureForKey:@"belldown.png"];
        [button setTexture:t];
        ahaCount = ahaCount + 1;
        [self updateLabel];
        
        CCShaky3D *shake = [CCShaky3D actionWithRange:1 shakeZ:YES grid:ccg(5, 5) duration:1];
        [button runAction:shake];
        
        //Particle Explosion
        //You don't need this. but you might make a really small one
        /*
        CCParticleSystem *system = [CCParticleExplosion node];
        system.position = clickLocation;
        [self addChild:system z:1 tag:5];
        */
    } else if (CGRectContainsPoint([[self getChildByTag:2] boundingBox], clickLocation )) {
        [self resetDingCount];
    }
    return YES;
}

-(BOOL)ccKeyUp:(NSEvent *)event {
    NSString *character = [event characters];
    unichar keyCode = [character characterAtIndex:0];
    if (keyCode == 32) {
            
            CCTexture2D *t = [[CCTextureCache sharedTextureCache] textureForKey:@"bell.png"];
            [button setTexture:t];
    }
    return YES;
}

-(BOOL)ccKeyDown:(NSEvent *)event {
    NSString *character = [event characters];
    unichar keyCode = [character characterAtIndex:0];
    if (keyCode == 32) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.mp3" ];
        CCTexture2D *t = [[CCTextureCache sharedTextureCache] textureForKey:@"belldown.png"];
        [button setTexture:t];
        ahaCount = ahaCount + 1;
        [self updateLabel];
        CCShaky3D *shake = [CCShaky3D actionWithRange:1 shakeZ:YES grid:ccg(5, 5) duration:1];
        [button runAction:shake];
    }
    return YES;
}

-(void)updateLabel {
    NSString *s = [NSString stringWithFormat:@"Dings: %d", ahaCount];
    [label setString:s];
}

-(void)resetDingCount {
    ahaCount = 0;
    [self updateLabel];
    CCScaleBy *scaleUp = [CCScaleBy actionWithDuration:.1 scale:1.6];
    CCTintTo *tintRed = [CCTintTo actionWithDuration:.1 red:255 green:0 blue:0];
    CCScaleBy *scaleDown = [CCScaleBy actionWithDuration:.1 scale:.625];
    CCTintTo *tintBlack = [CCTintTo actionWithDuration:.1 red:0 green:0 blue:0];
    CCSequence *s = [CCSequence actions:tintRed, scaleUp, scaleDown, tintBlack, nil];
    [label runAction:s];
    
    CCBlink *blink = [CCBlink actionWithDuration:.25 blinks:2];
    [reset runAction:blink];
}
@end

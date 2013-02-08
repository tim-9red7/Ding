//
//  Menu.m
//  Ding
//
//  Created by Tim Hart on 11/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"


@implementation Menu

+(CCScene *) scene
{
    CCScene *scene = [CCBReader sceneWithNodeGraphFromFile:@"Menu.ccbi"];
    return scene;
    
}

@end

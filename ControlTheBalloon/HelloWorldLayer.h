//
//  HelloWorldLayer.h
//  ControlTheBalloon
//
//  Created by Sen Ma on 14-3-5.
//  Copyright Sen Ma 2014年. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
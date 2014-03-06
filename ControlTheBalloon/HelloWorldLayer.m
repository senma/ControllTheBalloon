//
//  HelloWorldLayer.m
//  ControlTheBalloon
//
//  Created by Sen Ma on 14-3-5.
//  Copyright Sen Ma 2014年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@interface HelloWorldLayer()
@property (strong) CCSprite *back1;
@property (strong) CCSprite *back2;
@property float backHeight;
@property float backWidth;
@property (strong)CCSprite *block1;
@property (strong)CCSprite *block2;
@property (strong) NSMutableArray *blockArray1;
@end
// HelloWorldLayer implementation
@implementation HelloWorldLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
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
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {

		_back1=[CCSprite spriteWithFile:@"sky.png"];
        _back2=[CCSprite spriteWithFile:@"sky.png"];
        
        _backHeight=[_back1 boundingBox].size.height;
        _backWidth=[_back1 boundingBox].size.width;
        _back1.position=ccp(0,0);
        [self addChild:_back1 z:-1];
        _back2.position=ccp(0,_backHeight);
        [self addChild:_back2 z:-1];

        [[_back1 texture] setAliasTexParameters];
        [_back1 setAnchorPoint:ccp(0.5,0)];
        [[_back2 texture] setAliasTexParameters];
        [_back2 setAnchorPoint:ccp(0.5,0)];
        [self schedule:@selector(updateBack:)];
        
        CGSize size=[[CCDirector sharedDirector]winSize];
        
        _block1=[CCSprite spriteWithFile:@"block2.png"];
        _block2=[CCSprite spriteWithFile:@"block.png"];
        _blockArray1=[NSMutableArray array];
        
        NSLog(@"%f,  %f ,  %f,  %f ",size.height,size.width,
              _backHeight,_backWidth);
        //[self schedule:@selector(addBlockLine)];
        //[self addBlockLine];
        
        [self addAll];
	}
	return self;
}

-(void) addAll
{
    CGSize size=[[CCDirector sharedDirector] winSize];
    float diff=100.0f;
    int count=size.height/diff;
    
    for(int i=0;i<=count;i++)
    {
        
        [self addBlock1:i*diff];
    }

}
-(void) addBlockLine
{
    [self addBlock1:0.0f];
}
-(void) addBlock1:(float)height
{
    NSLog(@"========  %f",height);
    
    CGSize size=[[CCDirector sharedDirector] winSize];
    //CGSize bsize=_block1.boundingBox.size;
    /*
    CGRect repeatRect = CGRectMake(0, size.height, bsize.width, bsize.height);
    CCSprite* block = [CCSprite spriteWithFile:@"block2.png" rect:repeatRect];

    ccTexParams params ={
        GL_LINEAR,
        GL_LINEAR,
        GL_REPEAT,
        GL_REPEAT
    };
    */
    
	CGSize boxSize = CGSizeMake(100.0f, 10.0f);

    CCLayerColor *box = [CCLayerColor layerWithColor:ccc4(255,255,0,255)];
	box.anchorPoint = ccp(0.5,0.5);
	box.contentSize = boxSize;
	box.ignoreAnchorPointForPosition = NO;
   // box.position=ccp(size.width/2, size.height);
    box.position=ccp(size.width/2, height);
    
    //[block sets];
    //CCSprite * block=[CCSprite spriteWithTexture:<#(CCTexture2D *)#>];//[CCSprite //spriteWithFile:@"block2.png"];
    
    [self addChild:box z:1];
    
    
    float bearVelocity =480.0/6.0;
    
    float length=height;
    float delay=length/bearVelocity;
    
    id move=[CCMoveTo actionWithDuration:delay position:ccp(size.width/2,-100)];
    
    //[CCCallFunc actionWithTarget:self selector:@selector(check1)]
    
    id se=[CCSequence actions:move,[CCCallFuncN actionWithTarget:self selector:@selector(deleteThis:)], nil];
    
    [box runAction:se];
    //[_blockArray1 addObject:box];
}

- (void) deleteThis:(id)sender
{
    CGSize size=[[CCDirector sharedDirector] winSize];
    [self addBlock1:size.height];
    [sender removeFromParent ];
    //[sender dealloc];
}
-(void) updateBack:(ccTime)dt
{
    
    
    //float backHeigh=[_back1 boundingBox].size.height;
    //float backWidth=[_back1 boundingBox].size.width;
    
    CGPoint back1point=_back1.position;
    CGPoint back2point=_back2.position;
    
    back1point=ccp(back1point.x, back1point.y-1);
    back2point=ccp(back2point.x, back2point.y-1);
    
    _back1.position=back1point;
    
    _back2.position=back2point;
    
    //NSLog(@"xxx  %f    %f" ,_back1.position.y,_back2.position.y);
    
    if(back1point.y>(-_backHeight)&&back2point.y>(-_backHeight))
    {
        return;
    }
    //CGSize size=[[CCDirector sharedDirector]winSize];
    
    //NSLog(@"height 1= %f , 2=  %f",back1point.y,back2point.y);
    
    if(back1point.y<=(-_backHeight))
    {
       // NSLog(@"-----height 1= %f , 2=  %f,  achx,= %f anchy =%f  Bx=%f, By=%f ",back1point.y,back2point.y,_back1.anchorPoint.x ,_back1.anchorPoint.y,_back2.anchorPoint.x,_back2.anchorPoint.y);
        back1point=ccp(back1point.x, back2point.y+_backHeight);
        _back1.position=back1point;
    }
    
    if(back2point.y<=(0-_backHeight))
    {
        
       // NSLog(@"*****height 1= %f , 2=  %f,  achx,= %f anchy =%f  Bx=%f, By=%f ",back1point.y,back2point.y,_back1.anchorPoint.x ,_back1.anchorPoint.y,_back2.anchorPoint.x,_back2.anchorPoint.y);
        
        back2point=ccp(back2point.x, back1point.y+_backHeight);
        _back2.position=back2point;
    }
    
    
    
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    [_blockArray1 dealloc];
	[super dealloc];
}

@end

//
//  LevelSelectLayer.m
//  MazeMaster
//
//  Created by Gregory Klein on 8/13/13.
//  Copyright 2013 Binary Gods. All rights reserved.
//

#import "LevelSelectLayer.h"


@implementation LevelSelectLayer

- (id)init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if (self = [super init])
   {
      // ask director for the window size
      CGSize windowSize = [[CCDirector sharedDirector] winSize];

      // create and initialize a Label
		CCLabelTTF *levelSelectLabel = [CCLabelTTF labelWithString:@"Select Level"
                                                        fontName:@"Marker Felt"
                                                        fontSize:64];

		// position the label on the center of the screen
		levelSelectLabel.position = ccp(windowSize.width/2,
                                      windowSize.height - windowSize.height/4);

		// add the label as a child to this Layer
		[self addChild:levelSelectLabel];
	}
	return self;
}

- (void)dealloc
{
   [super dealloc];
}

// Helper class method that creates a Scene with the StartLayer as the only child.
+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	LevelSelectLayer *layer = [LevelSelectLayer node];

	// add layer as a child to scene
	[scene addChild:layer];

	// return the scene
	return scene;
}

@end

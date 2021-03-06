//
//  MMStartLayer.h
//  MazeMaster
//
//  Created by Gregory Klein on 8/4/13.
//  Copyright Binary Gods 2013. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// StartLayer
@interface MMStartLayer : CCLayer <GKAchievementViewControllerDelegate,
                                    GKLeaderboardViewControllerDelegate>

// returns a CCScene that contains the StartLayer as the only child
+ (CCScene *)scene;

@end

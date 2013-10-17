//
//  ControlsLayer.m
//  MazeMaster
//
//  Created by Justin Fila on 8/19/13.
//  Copyright 2013 Binary Gods. All rights reserved.
//

#import "ControlsLayer.h"
#import "CCNode+SFGestureRecognizers.h"
#import "GameController.h"
#import "Player.h"

static NSString * const UIGestureRecognizerNodeKey = @"UIGestureRecognizerNodeKey";

@implementation ControlsLayer

- (void)setupSwipeRecognizer
{
   UISwipeGestureRecognizer *recognizer;
   // add the different gesture recognizers for the 4 directions
   recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleSwipeFrom:)];
   [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
   [self addGestureRecognizer:recognizer];
   [recognizer release];

   recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleSwipeFrom:)];
   [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
   [self addGestureRecognizer:recognizer];
   [recognizer release];

   recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleSwipeFrom:)];
   [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
   [self addGestureRecognizer:recognizer];
   [recognizer release];

   recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleSwipeFrom:)];
   [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
   [self addGestureRecognizer:recognizer];
   [recognizer release];
}

-(id) init
{
   if (self = [super init])
   {
      _touchEnabled = YES;
      [self setupSwipeRecognizer];
      [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                                priority:INT_MIN+1
                                                         swallowsTouches:YES];
   }
   
   return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
            shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
   return YES;
}

// handles the swipe for each direction
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
   // TODO: that'd be nice to get the tags working instead of using the game controller...
   
   GameController *gameController = [GameController sharedController];
   
   PlayerDirection direction;
   switch (recognizer.direction)
   {
      case UISwipeGestureRecognizerDirectionRight:
         direction = e_EAST;
         break;
      case UISwipeGestureRecognizerDirectionLeft:
         direction = e_WEST;
         break;
      case UISwipeGestureRecognizerDirectionUp:
         direction = e_NORTH;
         break;
      case UISwipeGestureRecognizerDirectionDown:
         direction = e_SOUTH;
         break;
      default:
         break;
   }
   
   if ([gameController swipeStackIsEmpty] &&
       gameController.playerDirection == e_NONE)
   {
      gameController.playerDirection = direction;
   }
   else if ([gameController topSwipeStack] != direction)
   {
      [gameController pushSwipeStack:direction];
   }
   
   // only call the move player function if it is the first swipe (because it will
   // be called automatically at the end of the move)
   if ( !gameController.isPlayerMoving )
   {
      if ( [gameController playerCanMoveFromTile:gameController.level.maze.tileWithPlayer] )
      {
         gameController.isPlayerMoving = YES;
         gameController.playerShouldMove = YES;
      }
   }
}

//-(void) ccTouchesEnded:(NSSet *)touches
//             withEvent:(UIEvent *)event
//{
//   // TODO decelerate
//   GameController * gameController = [GameController sharedController];
//   gameController.playerShouldMove = NO;
////   gameController.gameLayer.playerSprite.playerVelocity = CGPointMake(1.0, 1.0);
//}

- (void)handleSingleTap:(NSArray *)touchPoint
{
   NSLog(@"single tap!");
   GameController * gameController = [GameController sharedController];
   gameController.playerShouldMove = NO;
}

- (void)handleDoubleTap:(NSArray *)touchPoint
{
   NSLog(@"double tap!");
}

- (BOOL)ccTouchBegan:(UITouch *)touch
           withEvent:(UIEvent *)event
{
   return YES;
}

- (void)ccTouchEnded:(UITouch *)touch
             withEvent:(UIEvent *)event
{
   CGPoint location = [touch locationInView:[touch view]];
   location = [[CCDirector sharedDirector] convertToGL:location];
   switch (touch.tapCount) {
      case 2:
         NSLog(@"single tap canceled");
         [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                  selector:@selector(handleSingleTap:)
                                                    object:[NSArray arrayWithObjects:[NSNumber numberWithInt:_lastTouchLocation.x],[NSNumber numberWithInt:_lastTouchLocation.y],nil]];
         [self handleDoubleTap:[NSArray arrayWithObjects:[NSNumber numberWithInt:location.x],[NSNumber numberWithInt:location.y],nil]];
         break;
      case 1:
         _lastTouchLocation = ccp(location.x,location.y);
         [self performSelector:@selector(handleSingleTap:) withObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:_lastTouchLocation.x],[NSNumber numberWithInt:_lastTouchLocation.y],nil] afterDelay:.17];
         break;
   }
}

-(void) dealloc
{
   [super dealloc];
}

@end

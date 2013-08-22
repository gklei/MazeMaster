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

static NSString * const UIGestureRecognizerNodeKey = @"UIGestureRecognizerNodeKey";

@implementation ControlsLayer

-(id) init
{
   if ( self = [super init] )
   {
      [self setTouchEnabled:YES];
      
      // add the different gesture recognizers for the 4 directions
      UISwipeGestureRecognizer *recognizer;
      
      recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
      [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
      [self addGestureRecognizer:recognizer];
      [recognizer release];
      
      recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
      [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
      [self addGestureRecognizer:recognizer];
      [recognizer release];
      
      recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
      [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
      [self addGestureRecognizer:recognizer];
      [recognizer release];
      
      recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
      [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
      [self addGestureRecognizer:recognizer];
      [recognizer release];
      
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
   
   GameController *gameController = [GameController gameController];
   
   if ( recognizer.direction == UISwipeGestureRecognizerDirectionRight )
   {
     gameController.playerDirection = e_EAST;
   }
   else if ( recognizer.direction == UISwipeGestureRecognizerDirectionLeft )
   {
      gameController.playerDirection = e_WEST;
   }
   else if ( recognizer.direction == UISwipeGestureRecognizerDirectionUp )
   {
      gameController.playerDirection = e_NORTH;
   }
   else if ( recognizer.direction == UISwipeGestureRecognizerDirectionDown )
   {
      gameController.playerDirection = e_SOUTH;
   }
   
   [gameController movePlayer];
}

-(void) dealloc
{
   [super dealloc];
}

@end
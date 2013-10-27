//
//  MMCharacter.h
//  MazeMaster
//
//  Created by Fila, Justin on 10/18/13.
//  Copyright (c) 2013 Binary Gods. All rights reserved.
//

#import "CCSprite.h"
#import "PlayerTypedefs.h"
#import "Tile.h"

@interface MMCharacter : CCSprite
{
}

@property (readwrite, assign) NSString *travelerKey;
@property (readwrite, assign) CGPoint velocity;
@property (readwrite, assign) CGPoint maxVelocity;
@property (readwrite, assign) CGPoint absolutePosition;
@property (readwrite, assign) CGPoint offset;
@property (nonatomic, assign) CharacterDirection direction;
@property (readwrite, assign) BOOL isMoving;
@property (readwrite, assign) BOOL shouldMove;
@property (readwrite, assign) BOOL isPlayer;
@property (readwrite, assign) Tile *currentTile;

-(id) initWithFile:(NSString *)filename;
- (id)initWithFile:(NSString *)filename
       travelerKey:(NSString *)travelerKey;

- (void)setupPathFinderWithTravelerKey:(NSString *)travelerKey;

-(void) attack;

-(void) pushMoveStack:(CharacterDirection)direction;
-(CharacterDirection) popMoveStack;
-(CharacterDirection) topMoveStack;
-(void) clearMoveStack;
-(BOOL) moveStackIsEmpty;

- (void)calculatePathToCharacter:(MMCharacter *)character;
- (void)beginExecutingCurrentPath;

+(MMCharacter *) characterWithFile:(NSString *)filename;

@end

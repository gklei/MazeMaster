//
//  MMMaze.m
//  MazeMaster
//
//  Created by Justin Fila on 8/13/13.
//  Copyright (c) 2013 Binary Gods. All rights reserved.
//

#import "MMMaze.h"
#import "MMTile.h"

@implementation MMMaze

-(id) initWithRows:(int)rows withColumns:(int)cols
{
   if ( self = [super init] )
   {
      _mazeDimensions.rows = rows;
      _mazeDimensions.cols = cols;
      _tiles = [[NSMutableArray alloc] init];
      
      // create the 2d array
      for (int i = 0; i < rows; i++)
      {
         NSMutableArray *subArray = [[NSMutableArray alloc] init];
         for (int j = 0; j < cols; j++)
         {
            // add the tile at the index
            MMTile *tile = [[MMTile alloc] init];
            tile.position = CGPointMake(j+1, i+1);
            [subArray addObject:tile];
         }
         
         [_tiles addObject:subArray];
         // needs to be released here because the reference count is
         // increased when it is added into an array
         [subArray release];
      }
      
      // now connect all the edges
      [self connectEdges:rows cols:cols];
   }
   return self;
}

- (MMTile *)getTileAtLocation:(CGPoint)location
                forTileSize:(CGSize)tileSize
{
   int xTile = (location.x / tileSize.width) + 1;
   int yTile = (location.y / tileSize.height) + 1;
   
   return [self tileAtPosition:CGPointMake(xTile, yTile)];
}

- (MMTile *)getRandomTile
{
   return [self tileAtPosition:ccp((arc4random() % _mazeDimensions.cols) + 1,
                                   (arc4random() % _mazeDimensions.rows) + 1)];
}

- (MMTile *)tileAtPosition:(CGPoint)tileCoordinates
{
   if (tileCoordinates.x == 0 ||
       tileCoordinates.y == 0)
      return nil;

   if (tileCoordinates.x > _mazeDimensions.cols ||
       tileCoordinates.y > _mazeDimensions.rows)
      return nil;
   
   return [[_tiles objectAtIndex:tileCoordinates.y - 1] objectAtIndex:tileCoordinates.x - 1];
}

- (void)addNorthEdgeToTileAtPosition:(CGPoint)tilePosition
{
   MMTile *tile = [self tileAtPosition:tilePosition];
   MMEdge *edge = tile.northEdge;
   if (edge == nil)
   {
      edge = [[MMEdge alloc] init]; // create the north edge
      edge.southTile = tile;
   }

   CGPoint northTilePosition = ccp(tile.position.x,
                                   tile.position.y+1);
   
   edge.northTile = [self tileAtPosition:northTilePosition];

   if (edge.northTile)
      edge.northTile.southEdge = edge;
}

- (void)addSouthEdgeToTileAtPosition:(CGPoint)tilePosition
{
   MMTile *tile = [self tileAtPosition:tilePosition];
   MMEdge *edge = tile.southEdge;
   if (edge == nil)
   {
      edge = [[MMEdge alloc] init]; // create the north edge
      edge.northTile = tile;
   }

   CGPoint southTilePosition = ccp(tile.position.x,
                                   tile.position.y-1);

   edge.southTile = [self tileAtPosition:southTilePosition];

   if (edge.southTile)
      edge.southTile.northEdge = edge;
}

- (void)addEastEdgeToTileAtPosition:(CGPoint)tilePosition
{
   MMTile *tile = [self tileAtPosition:tilePosition];
   MMEdge *edge = tile.eastEdge;
   if (edge == nil)
   {
      edge = [[MMEdge alloc] init];
      edge.westTile = tile;
   }

   CGPoint eastTilePosition = ccp(tile.position.x+1,
                                  tile.position.y);

   edge.eastTile = [self tileAtPosition:eastTilePosition];

   if (edge.eastTile)
      edge.eastTile.westEdge = edge;
}

- (void)addWestEdgeToTileAtPosition:(CGPoint)tilePosition
{
   MMTile *tile = [self tileAtPosition:tilePosition];
   MMEdge *edge = tile.westEdge;
   if (edge == nil)
   {
      edge = [[MMEdge alloc] init];
      edge.eastTile = tile;
   }

   CGPoint westTilePosition = ccp(tile.position.x-1,
                                  tile.position.y);

   edge.westTile = [self tileAtPosition:westTilePosition];

   if (edge.westTile)
      edge.westTile.eastEdge = edge;
}

-(void) connectEdges:(int)rows cols:(int)cols
{
   for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
      {
         CGPoint tilePosition = ccp(j+1, i+1);
         
         [self addNorthEdgeToTileAtPosition:tilePosition];
         [self addEastEdgeToTileAtPosition:tilePosition];
         [self addSouthEdgeToTileAtPosition:tilePosition];
         [self addWestEdgeToTileAtPosition:tilePosition];
      }
}

-(void) testMaze
{
   int rows = [_tiles count];
   int cols;
   for (int i = 0; i < rows; i++)
   {
      cols = [[_tiles objectAtIndex:i] count];
      for (int j = 0; j < cols; j++)
      {
         NSLog(@"Tile %dx%d: %@", i, j, [[_tiles objectAtIndex:i] objectAtIndex:j]);
      }
   }
}

-(void) dealloc
{
   _mazeDimensions.rows = nil;
   _mazeDimensions.cols = nil;
   
   // remove all the objects recursively
   [_tiles release];
   
   [super dealloc];
}

@end

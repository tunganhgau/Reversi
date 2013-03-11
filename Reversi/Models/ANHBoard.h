//
//  ANHBoard.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHCell.h"

typedef NS_ENUM(int, Direction){
    Top,
    TopRight,
    Right,
    BottomRight,
    Bottom,
    BottomLeft,
    Left,
    TopLeft
};

@interface ANHBoard : NSObject

@property (copy,nonatomic) NSMutableArray *cells;

@property (nonatomic) ANHCell *temp;
@property (nonatomic) BOOL blackTurn;

- (void) nextTurn;
- (BOOL) isBlackTurn;
- (void) initBoardState;
- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column;
- (NSMutableArray *) directionsValidToMoveFromCell:(ANHCell *)cell;
- (void) makeMoveAtCell:(ANHCell *)cell towardDirections:(NSArray *) directions;
@end

//
//  ANHBoard.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHCell.h"
#import "ANHBoardDelegate.h"
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

typedef NS_ENUM(int, PlayMode) {
    PlayerMode,
    ComputerMode
};

@interface ANHBoard : NSObject <NSCopying>

@property (copy,nonatomic) NSMutableArray *cells;
@property (nonatomic) Player whoseTurn;
@property (nonatomic) Player firstPlayer;
@property (nonatomic) Player secondPlayer;
@property (nonatomic) Player winner;
@property (nonatomic) PlayMode playMode;
@property (nonatomic) int blackScore;
@property (nonatomic) int whiteScore;
@property (nonatomic, weak) id<BoardDelegate> delegate;

- (void) switchTurn;
- (BOOL) isBlackTurn;
- (void) initBoardState;
- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column;
- (NSMutableArray *) directionsValidToMoveFromCell:(ANHCell *)cell;
- (BOOL) cellIsMoveable:(ANHCell *)cell;
- (void) makeMoveAtCell:(ANHCell *)cell;
- (NSArray *)playableCells;
- (BOOL) nextPlayerCanMakeMove;
- (void) resetBoard;
- (void) updateBoard;
- (BOOL) gameEnd;
- (ANHCell *) highestScoreCell;
@end

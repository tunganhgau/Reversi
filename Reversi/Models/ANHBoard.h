//
//  ANHBoard.h
//  Reversi
//
//  Represent the data of the game board, a board will contain it owns
//  data as well as 64 cells in a 2D array
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

typedef NS_ENUM(int, AIDifficulty){
    Easy,
    Medium,
    Hard
};

@interface ANHBoard : NSObject <NSCopying>

@property (copy,nonatomic) NSMutableArray *cells;
@property (nonatomic) Player whoseTurn;
@property (nonatomic) Player winner;
@property (nonatomic) PlayMode playMode;
@property (nonatomic) BOOL computerTurn;
@property (nonatomic) BOOL blackGoFirst;
@property (nonatomic) BOOL playerIsBlack;
@property (nonatomic) AIDifficulty AILevel;
@property (nonatomic) int blackScore;
@property (nonatomic) int whiteScore;
@property (nonatomic, strong) id<BoardDelegate> delegate;

- (void) switchTurn;
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
- (void) playerCannotMove;
@end

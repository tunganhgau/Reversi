//
//  ANHBoard.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHCell.h"

@interface ANHBoard : NSObject

@property (copy,nonatomic) NSMutableArray *cells;

@property (nonatomic) ANHCell *temp;
@property (nonatomic) BOOL blackTurn;

- (void) nextTurn;
- (BOOL) isBlackTurn;
- (void) initBoardState;
- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column;
- (BOOL) moveIsValidAtCell:(ANHCell *)cell;

@end

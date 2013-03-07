//
//  ANHBoard.m
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHBoard.h"
#import "ANHCell.h"

@implementation ANHBoard
@synthesize cells;

- (id) init{
    self = [super init];
    if (self) {
        for (int i = 0; i<8; i++) {
            [cells addObject:[[NSMutableArray alloc]init]];
        }
        for (int r = 0; r<8; r++) {
            for (int c = 0; c<8; c++) {
                ANHCell *cell = [[ANHCell alloc]initWithRow:r andColumn:c];
                [[cells objectAtIndex:r] addObject:cell];
            }
        }
        _blackTurn = YES;
    }
    
    return self;
}

- (void)nextTurn{
    if (self.blackTurn) {
        self.blackTurn = NO;
    }
    else{
        self.blackTurn = YES;
    }
        
}

- (BOOL) isBlackTurn{
    if (self.blackTurn == YES) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void) initBoardState{
    [self initCellState:WhiteCell AtRow:(NSUInteger )3 andColumn:(NSUInteger )3];
    [self initCellState:BlackCell AtRow:3 andColumn:4];
    [self initCellState:BlackCell AtRow:4 andColumn:3];
    [self initCellState:WhiteCell AtRow:4 andColumn:4];
}

- (void) initCellState:(CellState*)state AtRow:(int)row andColumn:(int)column{
    ANHCell *cell = [[cells objectAtIndex:3] objectAtIndex:3];
    cell.state = state;
}


@end

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
        cells = [[NSMutableArray alloc] init];
        for (int i = 0; i<8; i++) {
            [cells addObject:[[NSMutableArray alloc]init]];
        }
        for (int r = 0; r<8; r++) {
            for (int c = 0; c<8; c++) {
                //NSMutableArray *column = [[NSMutableArray alloc]init];
                ANHCell *cell = [[ANHCell alloc]initAtRow:r andColumn:c];
                [[cells objectAtIndex:r] addObject:cell];
            }
        }
        //[self initBoardState];
        _blackTurn = YES;
        //_temp = [[cells objectAtIndex:3]objectAtIndex:3];
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
    //CellState bCell = 1;
    [self initCellState:BlackCell atRow:3 andColumn:3];
    [self initCellState:WhiteCell atRow:3 andColumn:4];
    [self initCellState:WhiteCell atRow:4 andColumn:3];
    [self initCellState:BlackCell atRow:4 andColumn:4];
}

- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column{
    ANHCell *cell = [[cells objectAtIndex:row] objectAtIndex:column];
    cell.state = state;
}

- (BOOL) moveIsValidAtRow:(int)row andColumn:(int)column{
    BOOL isValid = YES;
    return isValid;
}

- (ANHCell *) topCellOf:(ANHCell *)cell{
    if (cell.row==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column];
}
- (ANHCell *) topLeftCell:(ANHCell *)cell{
    if (cell.row==0 || cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column-1];
    
}
- (ANHCell *) topRightCell:(ANHCell *)cell{
    if (cell.row==0 || cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column+1];
}
- (ANHCell *) leftCell:(ANHCell *)cell{
    if (cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column-1];
}
- (ANHCell *) rightCell:(ANHCell *)cell{
    if (cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column+1];
}
- (ANHCell *) bottomCell:(ANHCell *)cell{
    if (cell.row==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column];
}
- (ANHCell *) leftBottomCell:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column-1];
}
- (ANHCell *) rightBottomCell:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column+1];
}



@end

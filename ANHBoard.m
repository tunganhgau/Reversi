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
    [self initCellState:BlackCell atRow:3 andColumn:3];
    [self initCellState:WhiteCell atRow:3 andColumn:4];
    [self initCellState:WhiteCell atRow:4 andColumn:3];
    [self initCellState:BlackCell atRow:4 andColumn:4];
}

- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column{
    ANHCell *cell = [[cells objectAtIndex:row] objectAtIndex:column];
    cell.state = state;
}

- (BOOL) moveIsValidAtCell:(ANHCell *)cell{
    
    ANHCell *thisCell = cell;
    ANHCell *topCell = [self topCellOf:thisCell];
    ANHCell *topLeftCell = [self topLeftCellOf:thisCell];
    ANHCell *topRightCell = [self topRightCellOf:thisCell];
    ANHCell *leftCell = [self leftCellOf:thisCell];
    ANHCell *rightCell = [self rightCellOf:thisCell];
    ANHCell *bottomLeftCell = [self bottomLeftCellOf:thisCell];
    ANHCell *bottomRightCell = [self bottomRightCellOf:thisCell];
    ANHCell *bottomCell = [self bottomCellOf:thisCell];
    
    ANHCell *tempCell;
    CellState PlayerCell;
    CellState OponentCell;
    
    if ([self isBlackTurn]) {
        PlayerCell = BlackCell;
        OponentCell = WhiteCell;
    }
    else{
        PlayerCell = WhiteCell;
        OponentCell = BlackCell;
    }
    
    if (topCell) {
        if (topCell.state == OponentCell) {
            tempCell = [self topCellOf:topCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self topCellOf:tempCell];
            }
        }
    }
    if (topLeftCell) {
        if (topLeftCell.state == OponentCell) {
            tempCell = [self topLeftCellOf:topLeftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self topLeftCellOf:tempCell];
            }
        }
    }
    if (topRightCell) {
        if (topRightCell.state == OponentCell) {
            tempCell = [self topRightCellOf:topRightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self topRightCellOf:tempCell];
            }
        }
    }
    if (leftCell) {
        if (leftCell.state == OponentCell) {
            tempCell = [self topLeftCellOf:leftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self leftCellOf:tempCell];
            }
        }
    }
    if (rightCell) {
        if (rightCell.state == OponentCell) {
            tempCell = [self rightCellOf:rightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self rightCellOf:tempCell];
            }
        }
    }
    
    if (bottomLeftCell) {
        if (bottomLeftCell.state == OponentCell) {
            tempCell = [self bottomLeftCellOf:bottomLeftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self bottomLeftCellOf:tempCell];
            }
        }
    }
    if (bottomRightCell) {
        if (bottomRightCell.state == OponentCell) {
            tempCell = [self bottomLeftCellOf:bottomRightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self bottomRightCellOf:tempCell];
            }
        }
    }
    if (bottomCell) {
        if (bottomRightCell.state == OponentCell) {
            tempCell = [self bottomCellOf:bottomRightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell)
                    return YES;
                else
                    tempCell = [self bottomCellOf:tempCell];
            }
        }
    }
    return NO;
}



- (ANHCell *) topCellOf:(ANHCell *)cell{
    if (cell.row==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column];
}
- (ANHCell *) topLeftCellOf:(ANHCell *)cell{
    if (cell.row==0 || cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column-1];
    
}
- (ANHCell *) topRightCellOf:(ANHCell *)cell{
    if (cell.row==0 || cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column+1];
}
- (ANHCell *) leftCellOf:(ANHCell *)cell{
    if (cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column-1];
}
- (ANHCell *) rightCellOf:(ANHCell *)cell{
    if (cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column+1];
}
- (ANHCell *) bottomCellOf:(ANHCell *)cell{
    if (cell.row==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column];
}
- (ANHCell *) bottomLeftCellOf:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column-1];
}
- (ANHCell *) bottomRightCellOf:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column+1];
}



@end

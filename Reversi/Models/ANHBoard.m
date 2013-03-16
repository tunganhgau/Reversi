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
@synthesize firstPlayer;
@synthesize secondPlayer;
@synthesize whoseTurn;

@synthesize cells;
- (id) init{
    self = [super init];
    if (self) {
        // cells is an array, whose items are arrays that contains Cell objects (Basically, cells is a 2 dimensions array)
        cells = [[NSMutableArray alloc] init];
        // initialize the cells array with 8 sub-arrays
        for (int i = 0; i<8; i++) {
            [cells addObject:[[NSMutableArray alloc]init]];
        }
        // create Cell objects and add them to cells
        for (int r = 0; r<8; r++) {
            for (int c = 0; c<8; c++) {
                ANHCell *cell = [[ANHCell alloc]initAtRow:r andColumn:c];
                [[cells objectAtIndex:r] addObject:cell];
            }
        }
        if (_playMode == PlayerMode) {
            firstPlayer = BlackPlayer;
            secondPlayer = WhitePlayer;
            
        }
        else {
            firstPlayer = HumanPlayer;
            secondPlayer = ComputerPlayer;
        }
        self.whoseTurn = self.firstPlayer;
        _blackScore = 0;
        _whiteScore = 0;
    }
    
    return self;
}

// switch turn to the next user
// if the game is in computer mode, the AI will move
- (void)switchTurn{
    if (whoseTurn == secondPlayer) {
        self.whoseTurn = self.firstPlayer;
    }
    else{
        self.whoseTurn = self.secondPlayer;
        if (secondPlayer == ComputerPlayer) {
            if (![self gameEnd]) {
                ANHCell *bestMove  = [self highestScoreCell];
                [self makeMoveAtCell:bestMove towardDirections:[self directionsValidToMoveFromCell:bestMove]];
            }
        }
    }
}

- (BOOL) isBlackTurn{
    if (self.whoseTurn == BlackPlayer || self.whoseTurn == HumanPlayer) {
        return YES;
    }
    else{
        return NO;
    }
}

// initialize the game board with 2 white pieces and 2 black pieces crossed in the middle of the board
- (void) initBoardState{
    [self initCellState:WhiteCell atRow:3 andColumn:3];
    [self initCellState:BlackCell atRow:3 andColumn:4];
    [self initCellState:BlackCell atRow:4 andColumn:3];
    [self initCellState:WhiteCell atRow:4 andColumn:4];
    [self updateBoard];
    
}

- (void) initCellState:(CellState)state atRow:(int)row andColumn:(int)column{
    ANHCell *cell = [[cells objectAtIndex:row] objectAtIndex:column];
    cell.state = state;
}

// update the scores and inform the View Controller
- (void) updateBoard {
    [self updateScores];
    [self informGameView];
}

- (void) updateScores{
    int bScore = 0;
    int wScore = 0;
    for (int r = 0; r<8; r++) {
        for (int c = 0; c<8; c++) {
            ANHCell *cell = [[cells objectAtIndex:r] objectAtIndex:c];
            if (cell.state == BlackCell) {
                bScore++;
            }
            if (cell.state == WhiteCell) {
                wScore++;
            }
        }
    }
    self.blackScore = bScore;
    self.whiteScore = wScore;
}

// let the View Controller know that the game state has changed
- (void) informGameView{
    if ([self.delegate respondsToSelector:@selector(boardChanged)]) {
        [self.delegate boardChanged];
        if ([self gameEnd]) {
            if (self.blackScore > self.whiteScore) {
                self.winner = BlackPlayer;
            }
            else if (self.blackScore < self.whiteScore){
                self.winner = WhitePlayer;
            }
            [self.delegate gameEndedWithWinner:(Player) self.winner];
        }
    }
}

// detect when the game is finished
- (BOOL) gameEnd{
    if (self.blackScore+self.whiteScore == 64) {
        return YES;
    }
    if (self.blackScore == 0 || self.whiteScore == 0){
        return YES;
    }
    return NO;
}

// check if the given cell is moveable for the current player
- (BOOL)cellIsMoveable:(ANHCell *)cell{
    if ([self directionsValidToMoveFromCell:cell].count == 0) {
        return NO;
    }
    else
        return YES;
}

- (NSArray *)playableCells{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int r = 0; r<8; r++) {
        for (int c = 0; c<8; c++) {
            ANHCell *cell = [[self.cells objectAtIndex:r]objectAtIndex:c];
            if (cell.state == EmptyCell) {
                if ([self cellIsMoveable:cell]) {
                    [array addObject:cell];
                }
            }
        }
    }
    return array;
}

// check if a player can make a move by going through all the empty cell
- (BOOL)nextPlayerCanMakeMove{
    for (int r = 0; r<8; r++) {
        for (int c = 0; c<8; c++) {
            ANHCell *cell = [[self.cells objectAtIndex:r]objectAtIndex:c];
            if (cell.state == EmptyCell) {
                if ([self cellIsMoveable:cell]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

// take a cell and return an array of available directions that will make the cell is a valid move
- (NSMutableArray *) directionsValidToMoveFromCell:(ANHCell *)cell{
    NSMutableArray * directions = [[NSMutableArray alloc] init];
    // take the cell and find all the cells arround it 
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
    // the logic to check if a cell is a valid move is first to check if there is an oponent cell next to it, and for that direction, there is a player cell behind it
    if (topCell) {
        if (topCell.state == OponentCell) {
            tempCell = [self topCellOf:topCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:Top]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self topCellOf:tempCell];
            }
        }
    }
    if (topLeftCell) {
        if (topLeftCell.state == OponentCell) {
            tempCell = [self topLeftCellOf:topLeftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:TopLeft]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self topLeftCellOf:tempCell];
            }
        }
    }
    if (topRightCell) {
        if (topRightCell.state == OponentCell) {
            tempCell = [self topRightCellOf:topRightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:TopRight]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self topRightCellOf:tempCell];
            }
        }
    }
    if (leftCell) {
        if (leftCell.state == OponentCell) {
            tempCell = [self leftCellOf:leftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:Left]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self leftCellOf:tempCell];
            }
        }
    }
    if (rightCell) {
        if (rightCell.state == OponentCell) {
            tempCell = [self rightCellOf:rightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:Right]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self rightCellOf:tempCell];
            }
        }
    }
    
    if (bottomLeftCell) {
        if (bottomLeftCell.state == OponentCell) {
            tempCell = [self bottomLeftCellOf:bottomLeftCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:BottomLeft]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self bottomLeftCellOf:tempCell];
            }
        }
    }
    if (bottomRightCell) {
        if (bottomRightCell.state == OponentCell) {
            tempCell = [self bottomRightCellOf:bottomRightCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:BottomRight]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self bottomRightCellOf:tempCell];
            }
        }
    }
    if (bottomCell) {
        if (bottomCell.state == OponentCell) {
            tempCell = [self bottomCellOf:bottomCell];
            while (tempCell) {
                if (tempCell.state== PlayerCell){
                    [directions addObject:[NSNumber numberWithInt:Bottom]];
                    break;
                }
                else if (tempCell.state == EmptyCell) break;
                else
                    tempCell = [self bottomCellOf:tempCell];
            }
        }
    }
    return directions;
}


// for each available direction, turn all the oponent's cells into player cell
- (void)makeMoveAtCell:(ANHCell *)cell towardDirections:(NSMutableArray *) directions{
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
    cell.state = PlayerCell;
    for (NSNumber *num in directions) {
        Direction dir = [num intValue];
        // for each direction, set the cell to be the player cell until a player cell is reached
        if (dir == Top) {
            tempCell = [self topCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self topCellOf:tempCell];
            }
        }
        if (dir == TopRight) {
            tempCell = [self topRightCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self topRightCellOf:tempCell];
            }
        }
        if (dir == TopLeft) {
            tempCell = [self topLeftCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self topLeftCellOf:tempCell];
            }
        }
        if (dir == Left) {
            tempCell = [self leftCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self leftCellOf:tempCell];
            }
        }
        if (dir == Right) {
            tempCell = [self rightCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self rightCellOf:tempCell];
            }
        }
        if (dir == Bottom) {
            tempCell = [self bottomCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self bottomCellOf:tempCell];
            }
        }
        if (dir == BottomLeft) {
            tempCell = [self bottomLeftCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self bottomLeftCellOf:tempCell];
            }
        }
        if (dir == BottomRight) {
            tempCell = [self bottomRightCellOf:cell];
            while (tempCell.state != PlayerCell) {
                tempCell.state = PlayerCell;
                tempCell = [self bottomRightCellOf:tempCell];
            }
        }
    }
    [self switchTurn];
    [self updateBoard];
    // check if the next player is able to make a move, if not, tell the view controller and switch the turn back
    if (![self nextPlayerCanMakeMove]) {
        if (![self gameEnd]) {
            [self.delegate playerIsNotAbleToMakeMove:self.whoseTurn];
            [self switchTurn];
            [self updateBoard];
        }
    }
    
}

// return the top cell of the given cell
- (ANHCell *) topCellOf:(ANHCell *)cell{
    if (cell.row==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column];
}
// return the top left cell of the given cell
- (ANHCell *) topLeftCellOf:(ANHCell *)cell{
    if (cell.row==0 || cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column-1];
    
}
// return the top right cell of the given cell
- (ANHCell *) topRightCellOf:(ANHCell *)cell{
    if (cell.row==0 || cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row-1]objectAtIndex:cell.column+1];
}
//return the left cell of the given cell
- (ANHCell *) leftCellOf:(ANHCell *)cell{
    if (cell.column==0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column-1];
}
// return the right cell of the given cell
- (ANHCell *) rightCellOf:(ANHCell *)cell{
    if (cell.column==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row]objectAtIndex:cell.column+1];
}
// return the bottom cell of the given cell
- (ANHCell *) bottomCellOf:(ANHCell *)cell{
    if (cell.row==7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column];
}
// return the bottom left cell of the given cell
- (ANHCell *) bottomLeftCellOf:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 0) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column-1];
}
// return the bottom right of the given cell
- (ANHCell *) bottomRightCellOf:(ANHCell *)cell{
    if (cell.row==7 || cell.column == 7) {
        return nil;
    }
    else
        return [[cells objectAtIndex:cell.row+1]objectAtIndex:cell.column+1];
}

// reset the game board, also set its initial state
- (void) resetBoard{
    for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
            ANHCell *tempCell;
            tempCell = [[self.cells objectAtIndex:i]objectAtIndex:j];
            tempCell.state = EmptyCell;
        }
    }
    
    [self initBoardState];
}

- (ANHCell *) highestScoreCell{
    NSArray *availableCell = [self playableCells];
    ANHCell *bestMove;
    if (availableCell.count > 0) {
        bestMove = [availableCell objectAtIndex:0];
    }
    
    for (ANHCell *cell in availableCell) {
        if ([self scoreForCellEasy:cell] > [self scoreForCellEasy:bestMove]) {
            bestMove = cell;
        }
    }
    return bestMove;
}

- (int) scoreForCellEasy:(ANHCell *)cell{
    return [self directionsValidToMoveFromCell:cell].count;
}

@end

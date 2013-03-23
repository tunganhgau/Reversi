//
//  ANHCell.m
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHCell.h"

@implementation ANHCell
@synthesize row;
@synthesize column;
@synthesize delegate;
@synthesize state;


- (id) initAtRow:(int)r andColumn:(int)c{
    self = [super init];
    if (self) {
        row = r;
        column = c;
        state = EmptyCell;
    }
    return self;
}

// Let the CellView know that there is a new Piece
- (void) newPiecePlayed{
    if ([delegate respondsToSelector:@selector(newPiece)]) {
        [delegate newPiece];
    }
}

// Let the CellView know it needs to flip Piece
- (void) pieceFlipped{
    if ([delegate respondsToSelector:@selector(flipPiece)]) {
        [delegate flipPiece];
    }
}

- (void) emptyCell{
    if ([delegate respondsToSelector:@selector(clearCell)]) {
        [delegate clearCell];
    }
}

// setter for state, whenever the state changed, inform its View
- (void) setState:(CellState) s{
    CellState beforeState = state;
    state = s;
    if (beforeState == EmptyCell) {
        [self newPiecePlayed];
    }
    else {
        [self pieceFlipped];
    }
    if (state == EmptyCell) {
        [self emptyCell];
    }
}

@end
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

- (id) copyWithZone:(NSZone *)zone{
    ANHCell *another = [[ANHCell alloc] init];
    another.state = self.state;
    another.delegate = self.delegate;
    another.row = self.row;
    another.column = self.column;
    return another;
}

- (void) cellChangedWithCellAnimation:(BOOL)flip{
    if ([delegate respondsToSelector:@selector(cellChanged:)]) {
        [delegate cellChanged:flip];
    }
}
// setter for state, whenever the state changed, inform its View
- (void) setState:(CellState) s{
    CellState beforeState = state;
    state = s;
    if (state == EmptyCell) {
        [self cellChangedWithCellAnimation:NO];
    }
    else{
        if (beforeState == EmptyCell) {
            [self cellChangedWithCellAnimation:NO];
        }
        else {
            [self cellChangedWithCellAnimation:YES];
        }
    }
}

@end
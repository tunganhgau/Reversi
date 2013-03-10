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

- (id) initWithRow:(int)r andColumn:(int)c{
    self = [super init];
    if (self) {
        row = r;
        column = c;
        state = EmptyCell;
    }
    return self;
}

// Let the CellView know that its state has changed
- (void) informCellView{
    if ([delegate respondsToSelector:@selector(cellStateChanged)]) {
        [delegate cellStateChanged];
    }
}

- (void) setState:(CellState) s{
    state = s;
    [self informCellView];
}

@end

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


- (id) initWithRow:(int)r andColumn:(int)c{
    self = [super init];
    if (self) {
        row = r;
        column = c;
        _state = EmptyCell;
    }
    return self;
}

- (void) setState:(CellState*)state{
    _state = state;
}

@end

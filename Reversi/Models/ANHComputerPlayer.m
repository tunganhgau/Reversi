//
//  ANHComputerPlayer.m
//  Reversi
//
//  Created by Anh Nguyen on 3/15/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHComputerPlayer.h"

@implementation ANHComputerPlayer

- (id) initWithBoard:(ANHBoard *)board{
    self = [super init];
    if (self) {
        self.board = board;
    }
    return self;
}

- (NSArray *) cellAvailableToMove{
    return [self.board playableCells];
}

- (ANHCell *) highestScoreCell{
    NSArray *availableCell = [self cellAvailableToMove];
    ANHCell *bestMove;
    if (availableCell.count > 0) {
        bestMove = [availableCell objectAtIndex:0];
    }
    
    for (ANHCell *cell in availableCell) {
        if ([self scoreForCell:cell] > [self scoreForCell:bestMove]) {
            bestMove = cell;
        }
    }
    return bestMove;
}

- (int) scoreForCell:(ANHCell *)cell{
    
    return 0;
}

@end

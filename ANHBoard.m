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

- (id) init{
    self = [super init];
    if (self) {
        _blackTurn = YES;
    }
    
    return self;
}

- (void)switchTurn{
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

@end

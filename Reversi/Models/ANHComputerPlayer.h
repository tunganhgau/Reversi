//
//  ANHComputerPlayer.h
//  Reversi
//
//  Created by Anh Nguyen on 3/15/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHBoard.h"
#import "ANHCell.h"

@interface ANHComputerPlayer : NSObject

@property (nonatomic, weak) ANHBoard *board;

- (NSArray *) cellAvailableToMove;
- (ANHCell *) highestScoreCell;

@end

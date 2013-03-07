//
//  ANHBoard.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANHBoard : NSObject

@property (copy,nonatomic) NSArray *cell;

@property (nonatomic) int column;
@property (nonatomic) int row;
@property (nonatomic) BOOL blackTurn;

- (void) switchTurn;
- (BOOL) isBlackTurn;

@end

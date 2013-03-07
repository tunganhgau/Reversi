//
//  ANHBoard.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANHBoard : NSObject


@property (nonatomic) BOOL blackTurn;

- (void) switchTurn;
- (BOOL) isBlackTurn;

@end

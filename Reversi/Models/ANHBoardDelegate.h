//
//  ANHBoardDelegate.h
//  Reversi
//
//  Created by Anh Nguyen on 3/13/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(int, Player){
    BlackPlayer,
    WhitePlayer
};

@protocol BoardDelegate <NSObject>
- (void) boardChanged;
- (void) gameEndedWithWinner:(Player) winner;
@end

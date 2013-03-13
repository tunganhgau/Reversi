//
//  ANHBoardDelegate.h
//  Reversi
//
//  Created by Anh Nguyen on 3/13/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BoardDelegate <NSObject>

- (void) boardChanged;

@end

//
//  ANHCell.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellState){
    EmptyCell,
    WhiteCell,
    BlackCell
};

@interface ANHCell : NSObject

@property (nonatomic) CellState *state;

@property (nonatomic) int column;
@property (nonatomic) int row;

- (id) initWithRow:(int)r andColumn:(int)c;

- (void) setState:(CellState*)state;

@end

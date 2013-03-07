//
//  ANHCell.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, CellState){
    EmptyCell = 0,
    BlackCell = 1,
    WhiteCell = 2
};

@interface ANHCell : NSObject

@property (nonatomic) CellState state;
//@property (nonatomic) int state;
@property (nonatomic) int column;
@property (nonatomic) int row;

- (id) initWithRow:(int)r andColumn:(int)c;


@end

//
//  ANHCell.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    EmptyCell,
    BlackCell,
    WhiteCell
}CellState;

@interface ANHCell : NSObject

@property (nonatomic) CellState state;
//@property (nonatomic) int state;
@property (nonatomic) int column;
@property (nonatomic) int row;

- (id) initWithRow:(int)r andColumn:(int)c;


@end

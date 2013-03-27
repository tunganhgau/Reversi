//
//  ANHCell.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHCellStateDelegate.h"

typedef enum{
    EmptyCell,
    BlackCell,
    WhiteCell
}CellState;

@interface ANHCell : NSObject //<NSCopying>

@property (nonatomic) CellState state;
@property (nonatomic, strong) id <CellStateDelegate> delegate;
@property (nonatomic) int column;
@property (nonatomic) int row;
@property (nonatomic, weak) ANHCell *topNeighbor;
@property (nonatomic, weak) ANHCell *topRightNeighbor;
@property (nonatomic, weak) ANHCell *RightNeighbor;
@property (nonatomic, weak) ANHCell *bottomRightNeighbor;
@property (nonatomic, weak) ANHCell *bottomNeighbor;
@property (nonatomic, weak) ANHCell *bottomLeftNeighbor;
@property (nonatomic, weak) ANHCell *leftNeighbor;
@property (nonatomic, weak) ANHCell *topLeftNeighbor;

- (id) initAtRow:(int)r andColumn:(int)c;
- (void) cellChangedWithCellAnimation:(BOOL) flip;
@end

//
//  ANHGameCellView.h
//  Reversi
//
//  Responsible for displaying each cell of the game board
//  It might be nothing when the cell is empty, or display black or white piece
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHCell.h"
#import "ANHBoard.h"
#import "ANHCellStateDelegate.h"

@interface ANHGameCellView : UIView<CellStateDelegate>

@property (weak, nonatomic) ANHCell *cell;
@property (weak, nonatomic) ANHBoard *board;
@property (nonatomic) float height;
@property (nonatomic) float width;

@property (nonatomic, strong) UIImageView *whiteView;
@property (nonatomic, strong) UIImageView *blackView;

- (id)initWithFrame:(CGRect)frame cell:(ANHCell *) cell board:(ANHBoard *)board;
- (void) flipPiece;
- (void) cellChanged:(BOOL)flip;
- (void) updateCellView;
@end

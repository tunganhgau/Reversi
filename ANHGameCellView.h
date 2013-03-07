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

@interface ANHGameCellView : UIView

@property (weak, nonatomic) ANHCell *cell;
@property (weak, nonatomic) ANHBoard *board;
@property (nonatomic) float height;
@property (nonatomic) float width;

@property (nonatomic) int row;
@property (nonatomic) int column;

@property (nonatomic) BOOL isEmpty;
@property (nonatomic, strong) UIImageView *whiteView;
@property (nonatomic, strong) UIImageView *blackView;


// set the image for the cell (white or black piece), given the 
//- (void) setImage
- (id)initWithFrame:(CGRect)frame andCell:(ANHCell *) cell row:(int)r column:(int)c board:(ANHBoard *)board;

- (void) setStartState;

@end

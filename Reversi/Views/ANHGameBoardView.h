//
//  ANHGameBoardView.h
//  Reversi
//
//  Responsible for displaying the game board 
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHBoard.h"

@interface ANHGameBoardView : UIView

@property (nonatomic) float height;
@property (nonatomic) float width;

@property (weak, nonatomic) ANHBoard *gameBoard;
@property (copy, nonatomic) NSMutableArray *cellViews;

- (id)initWithFrame:(CGRect)frame andBoard:(ANHBoard *)board;
- (void) updateBoardView;
@end

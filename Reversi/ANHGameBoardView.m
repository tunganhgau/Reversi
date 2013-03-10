//
//  ANHGameBoardView.m
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHGameBoardView.h"
#import "ANHGameCellView.h"


@implementation ANHGameBoardView
@synthesize cells;
@synthesize gameBoard;

- (id)initWithFrame:(CGRect)frame andBoard:(ANHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        gameBoard = board;
        _height = frame.size.height;
        _width = frame.size.width;
        // length of each cell is 1/8 of the board length
        float cellHeight = self.height/8;
        float cellWidth = self.width/8;
        //initialze the CellView
        for (int row = 0 ; row < 8; row++) {
            for (int column = 0; column < 8; column++) {
                CGRect cellFrame = CGRectMake(row*cellHeight, column*cellHeight, cellWidth, cellHeight);
                // each GameCellView object will contain a reference to a Cell Object
                ANHCell *cell = [[gameBoard.cells objectAtIndex:row]objectAtIndex:column];
                ANHGameCellView *cellView = [[ANHGameCellView alloc]initWithFrame:cellFrame cell:cell board:board];
                // set the delegate of Cell object to be its CellView
                cell.delegate = cellView;
                [self addSubview:cellView];
            }
        }
        // set the gameBoard to its initial state
        [gameBoard initBoardState];
        // Added a background and a gameboard image
        UIImage *background = [UIImage imageNamed:@"gameBoard.png"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:background];
        bgView.frame = CGRectMake(0, 0, _width, _height);
        bgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:bgView];
        [self sendSubviewToBack:bgView];
        
        [self updateBoard];
        
    }
    return self;
}

- (void) updateBoard{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

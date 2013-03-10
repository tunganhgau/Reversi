//
//  ANHGameCellView.m
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHGameCellView.h"
#import "ANHCell.h"

//#typedef blackPiece = "

@implementation ANHGameCellView

- (id)initWithFrame:(CGRect)frame cell:(ANHCell *) cell board:(ANHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        _height = frame.size.height;
        _width = frame.size.width;
        // add a tap gesture recognizer
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        //initial each cell with two hidden images of black and white Piece
        UIImage *blackImage = [UIImage imageNamed:@"blackPiece.png"];
        UIImage *whiteImage = [UIImage imageNamed:@"whitePiece.png"];
        _whiteView = [[UIImageView alloc] initWithImage:whiteImage];
        _blackView = [[UIImageView alloc] initWithImage:blackImage];
        // reduce the back ground frame so it won't take the whole View
        CGRect bgRect = CGRectMake(0.05*self.width, 0.05*self.height, 0.9*self.width, 0.9*self.height);
        _whiteView.frame = bgRect;
        _blackView.frame = bgRect;
        // fit the game piece picture into the frame
        _whiteView.contentMode = UIViewContentModeScaleAspectFit;
        _blackView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_whiteView];
        [self addSubview:_blackView];
        // cell started empty
        _whiteView.hidden = YES;
        _blackView.hidden = YES;
        
        // reference to a Cell and the Board
        _cell = cell;
        _board = board;
        
    }
    return self;
}


// Response to a Tap Gesture
- (void) cellTapped:(UITapGestureRecognizer *) recognizer{
    if (self.cell.state == EmptyCell) {
        if ([self.board isBlackTurn]) {
            self.cell.state = BlackCell;
        }
        else{
            self.cell.state = WhiteCell;
        }
        [self updateCell];
        [self.board nextTurn];
    }
}

// Update the View of the cell
- (void) updateCell{
    if (!self.cell.state) {
        self.blackView.hidden = NO;
        self.whiteView.hidden = NO;
    }
    else if (self.cell.state == BlackCell) {
        self.blackView.hidden = NO;
        self.whiteView.hidden = YES;
    }
    else{
        self.blackView.hidden = YES;
        self.whiteView.hidden = NO;
    }
}

- (void) cellStateChanged{
    [self updateCell];
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

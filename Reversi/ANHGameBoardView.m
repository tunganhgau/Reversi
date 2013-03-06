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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _height = frame.size.height;
        _width = frame.size.width;
        float cellHeight = self.height/8;
        float cellWidth = self.width/8;
        for (int row = 0 ; row < 8; row++) {
            for (int column = 0; column < 8; column++) {
                CGRect cellFrame = CGRectMake(row*cellHeight, column*cellHeight, cellWidth, cellHeight);
                ANHGameCellView *cell = [[ANHGameCellView alloc]initWithFrame:cellFrame];
                //cell.image = [UIImage imageNamed:@"blackPiece"];
                [self addSubview:cell];
                
            }
        }
        //UIImage *background = [UIImage imageNamed:@"gameBoard"];
        //UIImageView *bgView = [[UIImageView alloc]initWithImage:background];
        UILabel *hello = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        hello.text = @"hello";
        [self addSubview:hello];
        //[self sendSubviewToBack:bgView];
        
    }
    return self;
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

//
//  ANHGameCellView.h
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ANHGameCellView : UIView

@property (nonatomic) float height;
@property (nonatomic) float width;

@property (nonatomic) int row;
@property (nonatomic) int column;

@property (nonatomic) BOOL isEmpty;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

// set the image for the cell (white or black piece), given the 
//- (void) setImage

@end

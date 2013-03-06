//
//  ANHGameBoardView.h
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ANHGameBoardView : UIView

@property (nonatomic) float height;
@property (nonatomic) float width;

@property (copy, nonatomic) NSArray *cells;

@end

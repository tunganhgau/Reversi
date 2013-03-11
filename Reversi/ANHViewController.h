//
//  ANHViewController.h
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHGameBoardView.h"

@interface ANHViewController : UIViewController

@property (strong, nonatomic) ANHGameBoardView *gameBoardView;
@property (strong, nonatomic) ANHBoard *gameBoard;
@property (strong, nonatomic) IBOutlet UILabel *blackScoreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *whoseTurnImage;
@property (strong, nonatomic) IBOutlet UILabel *whiteScoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetGame:(UIButton *)sender;

@end

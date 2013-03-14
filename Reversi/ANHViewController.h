//
//  ANHViewController.h
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHGameBoardView.h"
#import "ANHBoardDelegate.h"

@interface ANHViewController : UIViewController<BoardDelegate>

@property (strong, nonatomic) ANHGameBoardView *gameBoardView;
@property (strong, nonatomic) ANHBoard *gameBoard;
@property (strong, nonatomic) IBOutlet UIImageView *whoseTurnImage;
@property (strong, nonatomic) IBOutlet UITextView *blackScoreTextView;
@property (strong, nonatomic) IBOutlet UITextView *whiteScoreTextView;
@property (strong, nonatomic) IBOutlet UILabel *whoseTurnLabel;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetGame:(UIButton *)sender;
- (void) boardChanged;
- (void) gameEndedWithWinner:(Player)winner;
- (void) playerIsNotAbleToMakeMove:(Player)player;

@end

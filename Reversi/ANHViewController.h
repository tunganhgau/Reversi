//
//  ANHViewController.h
//  Reversi
//
//  The main view controller, which is the actual game
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ANHGameBoardView.h"
#import "ANHBoardDelegate.h"
#import "ANHGameCellView.h"
#import "ANHCell.h"
#import "ANHSettingViewController.h"
#import "ANHSettingDelegate.h"

@interface ANHViewController : UIViewController<BoardDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate,ANHSettingDelegate>
struct data{
    
};
@property (strong, nonatomic) UIPopoverController *myPopover;
@property (strong, nonatomic) ANHGameBoardView *gameBoardView;
@property (strong, nonatomic) ANHBoard *gameBoard;
@property (strong, nonatomic) ANHBoard *currentBoard;
@property (strong, nonatomic) NSMutableArray *boardStack;
@property (strong, nonatomic) IBOutlet UIImageView *whoseTurnImage;
@property (strong, nonatomic) IBOutlet UITextView *blackScoreTextView;
@property (strong, nonatomic) IBOutlet UITextView *whiteScoreTextView;
@property (strong, nonatomic) IBOutlet UILabel *whoseTurnLabel;
@property (strong, nonatomic) IBOutlet UITextView *whoseTurnTextView;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) AVAudioPlayer *woodSound;
@property (strong, nonatomic) AVAudioPlayer *winSound;
@property (strong, nonatomic) AVAudioPlayer *loseSound;
@property (nonatomic) PlayMode playMode;
@property (nonatomic) BOOL muteSound;
@property (nonatomic) BOOL soundOn;
@property (nonatomic) BOOL blackGoFirst;
@property (nonatomic) BOOL playerIsBlack;
@property (nonatomic) AIDifficulty AILevel;
- (IBAction)undoMove:(UIButton *)sender;
- (IBAction)resetGame:(UIButton *)sender;
- (void) boardChanged;
- (void) gameEndedWithWinner:(Player)winner;
- (void) playerIsNotAbleToMakeMove:(Player)player;
@end

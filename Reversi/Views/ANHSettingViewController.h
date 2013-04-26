//
//  ANHSettingViewController.h
//  Reversi
//
//  The setting view controller 
//
//  Created by Anh Nguyen on 3/15/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHViewController.h"
#import "ANHSettingDelegate.h"
#import "ANHBoard.h"

@interface ANHSettingViewController : UIViewController

@property (nonatomic, weak) UIViewController *sourceView;
@property (nonatomic, weak) id <ANHSettingDelegate> delegate;
@property (nonatomic) BOOL soundOn;
@property (nonatomic) BOOL blackGoFirst;
@property (nonatomic) BOOL playerIsBlack;
@property (nonatomic) AIDifficulty AILevel;
@property (nonatomic) BOOL computerMode;
@property (nonatomic) PlayMode playMode;
@property (strong, nonatomic) ANHBoard *currentBoard;
@property (weak, nonatomic) IBOutlet UISegmentedControl *firstMoveSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySegment;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
- (IBAction)cancelPressed:(UIButton *)sender;
- (IBAction)savePressed:(UIButton *)sender;
- (IBAction)firstMoveSegmentChanged:(UISegmentedControl *)sender;
- (IBAction)colorSegmentChanged:(UISegmentedControl *)sender;
- (IBAction)difficultySegmentChanged:(UISegmentedControl *)sender;
- (IBAction)soundSwitchChanged:(UISwitch *)sender;

@end

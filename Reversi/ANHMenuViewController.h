//
//  ANHMenuViewController.h
//  Reversi
//
//  The first view of the game, which let the user choose to play vs
// a player or vs computer
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHBoard.h"
#import "ANHBoardDelegate.h"
#import "ANHViewController.h"
@interface ANHMenuViewController : UIViewController

@property (nonatomic, weak) ANHBoard *board;
@property (nonatomic, strong) ANHViewController *gameView;
- (IBAction)playWithPlayerButtonPressed:(UIButton *)sender;
- (IBAction)playWithComputerButtonPressed:(UIButton *)sender;

@end

//
//  ANHMenuViewController.h
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHBoard.h"
#import "ANHBoardDelegate.h"
@interface ANHMenuViewController : UIViewController

@property (nonatomic, weak) ANHBoard *board;

- (IBAction)playWithPlayerButtonPressed:(UIButton *)sender;
- (IBAction)playWithComputerButtonPressed:(UIButton *)sender;

@end

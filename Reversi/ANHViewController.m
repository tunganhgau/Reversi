//
//  ANHViewController.m
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHViewController.h"
#import "ANHGameBoardView.h"
#import "ANHBoard.h"
@interface ANHViewController ()

@end

@implementation ANHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    float screenWidth = self.view.bounds.size.width;
    CGRect boardRect = CGRectMake(0.05*screenWidth, 0.15*screenWidth, 0.9*screenWidth, 0.9*screenWidth);
    _gameBoard = [[ANHBoard alloc]init];
    _gameBoardView = [[ANHGameBoardView alloc] initWithFrame:boardRect andBoard:_gameBoard];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
    [self.view addSubview:self.gameBoardView];
    //[self.view sendSubviewToBack:self.gameBoardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
#import "ANHCell.h"

@implementation ANHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    float screenWidth = self.view.bounds.size.width;
    CGRect boardRect = CGRectMake(0.05*screenWidth, 120, 0.9*screenWidth, 0.9*screenWidth);
    _gameBoard = [[ANHBoard alloc]init];
    _gameBoard.delegate = self;
    _gameBoardView = [[ANHGameBoardView alloc] initWithFrame:boardRect andBoard:_gameBoard];
    // set the gameBoard to its initial state after initialize the board View, otherwise, the gameboard need to know its cells first
    [_gameBoard initBoardState];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
    [self.view addSubview:self.gameBoardView];
    //[self alertTest];
    [self.view addSubview:self.blackScoreLabel];
    //_whoseTurnImage
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) alertTest{
    ANHCell * temp = [[self.gameBoard.cells objectAtIndex:3]objectAtIndex:2];
    NSString *m = [NSString stringWithFormat:@"%d,%d", temp.row, temp.column];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TEST" message:m delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (IBAction)resetGame:(UIButton *)sender {
    [self.gameBoard resetBoard];
}

- (void) boardChanged{
    [self updateGame];
}

- (void) updateGame{
    //self.blackScoreLabel.attributedText = [NSString stringWithFormat:@"%d",self.gameBoard.blackScore];
    //self.whiteScoreLabel.attributedText = [NSString stringWithFormat:@"%d",self.gameBoard.whiteScore];
    if ([self.gameBoard isBlackTurn]){
        self.whoseTurnImage.image = [[UIImage alloc]initWithCIImage:[UIImage imageNamed:@"blackPiece.png"].CIImage];
    }
    else {
        self.whoseTurnImage.image = [[UIImage alloc]initWithCIImage:[UIImage imageNamed:@"whitePiece.png"].CIImage];
    }
}
@end

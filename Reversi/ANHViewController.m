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
    _whoseTurnImage.image = [UIImage imageNamed:@"blackPiece.png"];
    _whoseTurnLabel.textColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetGame:(UIButton *)sender {
    [self.gameBoard resetBoard];
}

- (void) boardChanged{
    [self updateGame];
}

- (void) updateGame{
    self.blackScoreTextView.text = [NSString stringWithFormat:@"%d",self.gameBoard.blackScore];
    self.whiteScoreTextView.text = [NSString stringWithFormat:@"%d",self.gameBoard.whiteScore];
    if ([self.gameBoard isBlackTurn]){
        self.whoseTurnImage.image = [UIImage imageNamed:@"whitePiece.png"];
        self.whoseTurnLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.whoseTurnImage.image = [UIImage imageNamed:@"blackPiece.png"];
        self.whoseTurnLabel.textColor = [UIColor blackColor];
    }
}

- (void) gameEndedWithWinner:(Player)winner{
    NSString *message;
    if (winner == BlackPlayer) {
        message = [NSString stringWithFormat:@"Black player won"];
    }
    else if (winner == WhitePlayer){
        message = [NSString stringWithFormat:@"White player won"];
    }
    else {
        message = [NSString stringWithFormat:@"Draw. That was a nice game"];
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulation" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end

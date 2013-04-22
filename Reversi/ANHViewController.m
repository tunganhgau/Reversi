//
//  ANHViewController.m
//  Reversi
//
//  Created by Anh Nguyen on 3/5/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHViewController.h"
#import "ANHBoard.h"

@implementation ANHViewController
@synthesize woodSound;
@synthesize soundOn;
@synthesize winSound;
@synthesize loseSound;

- (id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    float screenWidth = self.view.bounds.size.width;
    float screenHeight = self.view.bounds.size.height;
    CGRect boardRect;
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        boardRect = CGRectMake(0.05*screenWidth, 0.12*screenHeight, 0.9*screenWidth, 0.9*screenWidth);
    }
    else {
        boardRect =  CGRectMake((screenHeight - 0.9*screenHeight)*1.75, 0, 0.9*screenWidth, 0.9*screenWidth);
    }
    _gameBoard = [[ANHBoard alloc]init];
    _gameBoard.delegate = self;
    if (self.playMode == PlayerMode) {
        _gameBoard.playMode = PlayerMode;
    }
    else {
        _gameBoard.playMode = ComputerMode;
    }
    _gameBoardView = [[ANHGameBoardView alloc] initWithFrame:boardRect andBoard:_gameBoard];
    // set the gameBoard to its initial state after initialize the board View, otherwise, the gameboard need to know its cells first
    [_gameBoard initBoardState];
    _boardStack = [[NSMutableArray alloc] init];
    _startBoard = [_gameBoard copyWithZone:nil];
    [_boardStack addObject:_startBoard];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
    [self.view addSubview:self.gameBoardView];
    _whoseTurnImage.image = [UIImage imageNamed:@"blackPiece.png"];
    _whoseTurnLabel.textColor = [UIColor blackColor];
    
    soundOn = YES;
    [self initSoundEffects];
    //[self playWinSound];
}

//-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        [self updateLandscapeView];
//    }
//    else{
//        [self updatePortraitView];
//    }
//}
//
//
//- (void)updateLandscapeView{
//    float screenWidth = self.view.bounds.size.width;
//    float screenHeight = self.view.bounds.size.height;
//    CGRect boardRect =  CGRectMake((screenHeight - 0.9*screenWidth)/1.9, 0, 0.9*screenWidth, 0.9*screenWidth);
//    self.gameBoardView.frame = boardRect;
//    CGRect whoseTurnFrame = CGRectMake(0, 0, 80, 80);
//    self.whoseTurnImage.frame = whoseTurnFrame;
//}
//
//- (void)updatePortraitView{
//    float screenWidth = self.view.bounds.size.width;
//    float screenHeight = self.view.bounds.size.height;
//    CGRect boardRect = CGRectMake(0.04*screenWidth, 0.15*screenHeight, 0.9*screenWidth, 0.9*screenWidth);
//    self.gameBoardView.frame = boardRect;
//}

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
    if (self.gameBoard.whoseTurn == BlackPlayer){
        self.whoseTurnImage.image = [UIImage imageNamed:@"blackPiece.png"];
        self.whoseTurnTextView.textColor = [UIColor blackColor];
    }
    else {
        self.whoseTurnImage.image = [UIImage imageNamed:@"whitePiece.png"];
        self.whoseTurnTextView.textColor = [UIColor whiteColor];
    }
}

- (void) gameEndedWithWinner:(Player)winner{
    if (self.playMode == ComputerMode) {
        if ((self.gameBoard.playerIsBlack == YES && winner == WhitePlayer) || (self.gameBoard.playerIsBlack == NO && winner == BlackPlayer)) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Nice try, that was a nice game" message:@"The computer win" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self playLoseSound];
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulation" message:@"You win" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self playWinSound];
        }
    }
    else {
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
        [self playWinSound];
    }
}

// if the player is not able to make move, show an allert to let them know
- (void) playerIsNotAbleToMakeMove:(Player)player{
    NSString *message;
    if (self.playMode == PlayerMode) {
        if (player == BlackPlayer) {
            message = [NSString stringWithFormat:@"It is White player's turn now"];
        }
        else if (player == WhitePlayer){
            message = [NSString stringWithFormat:@"It is Black player's turn now"];
        }
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"You have no way to move" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        if (player == BlackPlayer) {
            if (self.gameBoard.playerIsBlack) {
                message = [NSString stringWithFormat:@"You have to skip this turn"];
            }
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Black player cannot move" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            if (!self.gameBoard.playerIsBlack) {
                message = [NSString stringWithFormat:@"You have to skip this turn"];
            }
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"White player cannot move" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)undoMove:(UIButton *)sender {
    // retrieve the last board, unless the board is already at its initial state
    if (self.boardStack.count > 1) {
        // if the game is in player mode, undo one move
        if (self.playMode == PlayerMode) {
            self.gameBoard = [self.boardStack objectAtIndex:(self.boardStack.count - 1)];
            [self.boardStack removeLastObject];
        }
        // if the board is in AI mode, undo two move since the very last move was computer's move and we dont want the computer to make the same move
        else {
            // remove the last move made by computer in AI mode
            [self.boardStack removeLastObject];
            self.gameBoard = [self.boardStack objectAtIndex:(self.boardStack.count - 1)];
            [self.boardStack removeLastObject];
        }
    }
    else{
        self.gameBoard = [self.startBoard copyWithZone:nil];
    }
    self.gameBoardView.gameBoard = self.gameBoard;
    //self.gameBoard.delegate = self;
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            ANHGameCellView *temp = [[self.gameBoardView.cellViews objectAtIndex:row] objectAtIndex:col];
            temp.board = self.gameBoard;
            temp.cell = [[self.gameBoard.cells objectAtIndex:row] objectAtIndex:col];
            [temp updateCellView];
        }
    }
    [self updateGame];
}

// save the current board for undo feature
- (void) newPiecePlayed{
    [self.boardStack addObject:[self.gameBoard copyWithZone:nil]];
    [self playWoodSound];
}

- (void) playWoodSound{
    if (soundOn) {
        [woodSound play];
    }
}

- (void) playWinSound{
    if (soundOn) {
        [winSound play];
    }
}

- (void)playLoseSound{
    if (soundOn) {
        [loseSound play];
    }
}

- (void) initSoundEffects{
    NSString *winSoundPath = [[NSBundle mainBundle]pathForResource:@"win_sound" ofType:@"mp3"];
    winSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:winSoundPath] error:nil];
    NSString *woodSoundPath = [[NSBundle mainBundle]pathForResource:@"wood_sound" ofType:@"aac"];
    woodSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:woodSoundPath] error:nil];
    NSString *loseSoundPath = [[NSBundle mainBundle]pathForResource:@"lose_sound" ofType:@"mp3"];
    loseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:loseSoundPath] error:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ANHSettingViewController *settingPopover = (ANHSettingViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"settingView"]) {
        settingPopover.sourceView = self;
        settingPopover.delegate = self;
        settingPopover.blackGoFirst = self.gameBoard.blackGoFirst;
        settingPopover.playerIsBlack = self.gameBoard.playerIsBlack;
        settingPopover.AILevel = self.gameBoard.AILevel;
        settingPopover.soundOn = self.soundOn;
        settingPopover.computerMode = self.playMode;
        self.myPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0) {
        //self.gameBoard.blackGoFirst = self.blackGoFirst;
        //self.gameBoard.playerIsBlack = self.playerIsBlack;
        self.gameBoard.AILevel = self.AILevel;
        [self.gameBoard resetBoard];
        if (self.playMode == ComputerMode) {
            // in computer mode, detect if the computer has to go first
            if (!self.gameBoard.blackGoFirst) {
                if (self.gameBoard.playerIsBlack) {
                    self.gameBoard.whoseTurn = BlackPlayer;
                    [self.gameBoard switchTurn];
                }
            }
            else {
                if (!self.gameBoard.playerIsBlack) {
                    self.gameBoard.whoseTurn = WhitePlayer;
                    [self.gameBoard switchTurn];
                }
            }
            
        }
        [self cancelSetting];
    }
}

- (void)soundSwitchToggled{
    soundOn = !soundOn;
}

- (void)settingChangedWith:(BOOL)blackGoFirst andPlayerColor:(BOOL)blackColor andAILevel:(int)level{
    self.gameBoard.blackGoFirst = blackGoFirst;
    self.gameBoard.playerIsBlack = blackColor;
    self.AILevel = level;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting Changed" message:@"The game will restart with the new setting" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) cancelSetting{
    [self.myPopover dismissPopoverAnimated:YES];

}
/*
 Things to do:
 2 UIAlert appear when play with AI
 Alert when AI has no move
 
 */
@end

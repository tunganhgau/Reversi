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
    
    
    // this step is to check if there is already a gameBoard exist(only for iPhone when switching view) 
    if (self.currentBoard) {
        _gameBoard = self.currentBoard;
    }
    else{
        // initialize gameBoard
        _gameBoard = [[ANHBoard alloc]init];
    }
    if (self.playMode == PlayerMode) {
        _gameBoard.playMode = PlayerMode;
    }
    else {
        _gameBoard.playMode = ComputerMode;
    }
    // init a game board view with the given board
    _gameBoardView = [[ANHGameBoardView alloc] initWithFrame:boardRect andBoard:_gameBoard];
    _gameBoard.delegate = self;
    // set the gameBoard to its initial state after initialize the board View, otherwise, the gameboard need to know its cells first
    if (!self.currentBoard) {
        [_gameBoard initBoardState];
    }
    else {
        [self updateGame];
        // this means the game is at the initial state, and check if AI should go first
        if (_gameBoard.blackScore == 2 && _gameBoard.whiteScore == 2) {
            [_gameBoard makeAIFirstMove];
        }
    
    }

    // boardStack is used to save all the boards in the past to support undo a move
    if (!self.boardStack) {
        _boardStack = [[NSMutableArray alloc] init];
        [_boardStack addObject:self.gameBoard];
    }
    
    // init other needed elements
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
    [self.view addSubview:self.gameBoardView];
    _whoseTurnImage.image = [UIImage imageNamed:@"blackPiece.png"];
    _whoseTurnLabel.textColor = [UIColor blackColor];
    soundOn = YES;
    [self checkPreSet];	
    [self initSoundEffects];
    [self updateGame];
    
    
    // data persistent
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSData *testData = [dict objectForKey:@"GameBoard"];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:testData];
        ANHBoard *testBoard = [unarchiver decodeObjectForKey:@"GameBoard"];
        NSLog(@"blackscore %d", testBoard.blackScore);
        NSLog(@"%d", [[dict objectForKey:@"PlayMode"] intValue]);
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationWillResignActive:)
     name:UIApplicationWillResignActiveNotification
     object:app];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// resetGame get called when user hits the reset button
- (IBAction)resetGame:(UIButton *)sender {
    [self.gameBoard resetBoard];
    self.boardStack = [[NSMutableArray alloc] init];
    [self.boardStack addObject:self.gameBoard];
    
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
    [self.gameBoardView updateBoardView];
}

// method to be called when the game ended, it will show an alert with sound depend on the situation of the game
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
        //self.gameBoard = [self.startBoard copyWithZone:nil];
    }
    // set the game with the new board, and update the view
    self.gameBoardView.gameBoard = self.gameBoard;
    [self updateGame];
}

- (void) newPiecePlayed{
    [self.boardStack addObject:[self.gameBoard copyWithZone:nil]];
    [self playWoodSound];
    //NSLog(@"%d",self.boardStack.count);
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

// prepare the data to the next view
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.myPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        }
        else
        {
            settingPopover.savedBoards = [[NSMutableArray alloc] init];
            for (id eachBoard in self.boardStack) {
                [settingPopover.savedBoards addObject:[(ANHBoard *)  eachBoard copyWithZone:nil]];
            }
            settingPopover.currentBoard = [self.gameBoard copyWithZone:nil];
            settingPopover.playMode = self.playMode;
        }
    }
    //NSLog(self.soundOn ? @"Yes" : @"No");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // if the user chooses OK, save the setting, and reset the game with the new setting
    if (buttonIndex != 0) {
        self.gameBoard.AILevel = self.AILevel;
        self.gameBoard.blackGoFirst = self.blackGoFirst;
        self.gameBoard.playerIsBlack = self.playerIsBlack;
        [self.gameBoard resetBoard];
        self.boardStack = [[NSMutableArray alloc] init];
        //[self.boardStack addObject:self.gameBoard];
        [self cancelSetting];
    }
}

- (void) soundSwitchToggled;{
    self.soundOn  = !self.soundOn;
}

- (void)settingChangedWith:(BOOL)blackGoFirst andPlayerColor:(BOOL)blackColor andAILevel:(int)level{
    // these are temporary saved, until the user taps on OK on the next step
    self.blackGoFirst = blackGoFirst;
    self.playerIsBlack = blackColor;
    self.AILevel = level;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting Changed" message:@"The game will restart with the new setting" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) cancelSetting{
    [self.myPopover dismissPopoverAnimated:YES];
}

- (void) checkPreSet{
    if (self.muteSound) {
        self.soundOn = NO;
    }
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    NSString *filePath = [self dataFilePath];
    NSMutableData *dataObj = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObj];
    
    [archiver encodeObject:self.gameBoard forKey:@"GameBoard"];
    
    [archiver finishEncoding];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:self.playMode],@"PlayMode",
                          [NSNumber numberWithBool:self.muteSound],@"MuteSound",
                          [NSNumber numberWithBool:self.soundOn],@"SoundOn",
                          [NSNumber numberWithBool:self.blackGoFirst],@"BlackGoFirst",
                          [NSNumber numberWithBool:self.playerIsBlack],@"PlayerIsBlack",
                          [NSNumber numberWithInt:self.AILevel],@"AILevel",
                          dataObj, @"GameBoard",nil];
    
    [data writeToFile:filePath atomically:YES];
    NSLog(@"%d", [[data objectForKey:@"PlayMode"] intValue]);
    //BOOL b = [boolNumber boolValue];
}

/*
 Things to do:
 2 UIAlert appear when play with AI
 Alert when AI has no move
 
 */
@end

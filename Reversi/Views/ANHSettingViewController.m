//
//  ANHSettingViewController.m
//  Reversi
//
//  Created by Anh Nguyen on 3/15/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHSettingViewController.h"

@interface ANHSettingViewController ()

@end

@implementation ANHSettingViewController
@synthesize soundOn;
@synthesize blackGoFirst;
@synthesize playerIsBlack;
@synthesize AILevel;
@synthesize firstMoveSegment;
@synthesize colorSegment;
@synthesize difficultySegment;
@synthesize soundSwitch;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.computerMode) {
            //self.view.frame.size.height = 300;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (blackGoFirst) {
        firstMoveSegment.selectedSegmentIndex = 0;
    }
    else {
        firstMoveSegment.selectedSegmentIndex = 1;
    }
    if (playerIsBlack) {
        colorSegment.selectedSegmentIndex = 0;
    }
    else {
        colorSegment.selectedSegmentIndex = 1;
    }
    difficultySegment.selectedSegmentIndex = AILevel;
    [soundSwitch setOn:soundOn];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
}

- (IBAction)cancelPressed:(UIButton *)sender {
    [self.delegate cancelSetting];
}

- (IBAction)savePressed:(UIButton *)sender {
    ANHViewController *gameView = (ANHViewController *)self.sourceView;
    if (gameView.gameBoard.blackGoFirst != self.blackGoFirst || gameView.gameBoard.playerIsBlack != self.playerIsBlack || gameView.gameBoard.AILevel != self.AILevel) {
        if ([self.delegate respondsToSelector:@selector(settingChangedWith:andPlayerColor:andAILevel:)]) {
            [self.delegate settingChangedWith:self.blackGoFirst andPlayerColor:self.playerIsBlack andAILevel:self.AILevel];
        }
    }
    if (self.soundOn != soundSwitch.isOn) {
        if ([self.delegate respondsToSelector:@selector(soundSwitchToggled)]) {
            [self.delegate soundSwitchToggled];
        }
    }
}

- (IBAction)firstMoveSegmentChanged:(UISegmentedControl *)sender{
    blackGoFirst = !firstMoveSegment.selectedSegmentIndex;
}
- (IBAction)colorSegmentChanged:(UISegmentedControl *)sender{
    playerIsBlack = !colorSegment.selectedSegmentIndex;
}
- (IBAction)difficultySegmentChanged:(UISegmentedControl *)sender{
    AILevel = difficultySegment.selectedSegmentIndex;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ANHViewController *gameView = (ANHViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"cancel"]){
        gameView.currentBoard = [self.currentBoard copyWithZone:nil];
        gameView.boardStack = [[NSMutableArray alloc] init];
        for (id eachBoard in self.savedBoards) {
<<<<<<< HEAD
            [gameView.boardStack addObject:(ANHBoard *)eachBoard];
=======
            [gameView.boardStack addObject:[(ANHBoard *)eachBoard copyWithZone:nil]];
>>>>>>> iPhone-Setting
        }
    }
    else{
        if (self.currentBoard.blackGoFirst != self.blackGoFirst || self.currentBoard.playerIsBlack != self.playerIsBlack || self.currentBoard.AILevel != self.AILevel) {
            if ([self.delegate respondsToSelector:@selector(settingChangedWith:andPlayerColor:andAILevel:)]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting Changed" message:@"The game will restart with the new setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self.currentBoard resetBoard];
                self.currentBoard.AILevel = self.AILevel;
                self.currentBoard.blackGoFirst = self.blackGoFirst;
                self.currentBoard.playerIsBlack = self.playerIsBlack;
                
            }
        }
        if (self.soundOn != soundSwitch.isOn) {
            if ([self.delegate respondsToSelector:@selector(soundSwitchToggled)]) {
                [self.delegate soundSwitchToggled];
            }
        }
        gameView.currentBoard = [self.currentBoard copyWithZone:nil];
        if (!soundSwitch.isOn) {
            gameView.muteSound = YES;
        }
        
    }
    
    gameView.playMode = self.playMode;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // if the user chooses OK, save the setting, and reset the game with the new setting
    if (buttonIndex != 0) {
        self.currentBoard.AILevel = self.AILevel;
        self.currentBoard.blackGoFirst = self.blackGoFirst;
        self.currentBoard.playerIsBlack = self.playerIsBlack;
        //[self.gameBoard resetBoard];
        //self.boardStack = [[NSMutableArray alloc] init];
        //[self.boardStack addObject:self.gameBoard];
        [self.delegate cancelSetting];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

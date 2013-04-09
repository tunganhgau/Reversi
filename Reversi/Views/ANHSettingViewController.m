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
}

- (IBAction)firstMoveSegmentChanged:(UISegmentedControl *)sender{
    blackGoFirst = !firstMoveSegment.selectedSegmentIndex;
}
- (IBAction)colorSegmentChanged:(UISegmentedControl *)sender{
    playerIsBlack = colorSegment.selectedSegmentIndex;
}
- (IBAction)difficultySegmentChanged:(UISegmentedControl *)sender{
    AILevel = difficultySegment.selectedSegmentIndex;
}
- (IBAction)soundSwitchChanged:(UISwitch *)sender{
    soundOn = soundSwitch.isOn;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ANHViewController *gameView = (ANHViewController *)segue.destinationViewController;
    if (gameView.gameBoard.blackGoFirst != self.blackGoFirst || gameView.gameBoard.playerIsBlack != self.playerIsBlack || gameView.gameBoard.AILevel != self.AILevel || gameView.soundOn != self.soundOn) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting Changed" message:@"Do you want to start a new game with this setting?" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
        gameView.gameBoard.blackGoFirst = self.blackGoFirst;
        gameView.gameBoard.playerIsBlack = self.playerIsBlack;
        gameView.gameBoard.AILevel = self.AILevel;
        gameView.soundOn = self.soundOn;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    ANHViewController *gameView = (ANHViewController *)self.sourceView;
    if (gameView.gameBoard.blackGoFirst != self.blackGoFirst || gameView.gameBoard.playerIsBlack != self.playerIsBlack || gameView.gameBoard.AILevel != self.AILevel) {
        if ([self.delegate respondsToSelector:@selector(settingChangedWith:andPlayerColor:andAILevel:)]) {
            [self.delegate settingChangedWith:self.blackGoFirst andPlayerColor:self.playerIsBlack andAILevel:self.AILevel];
        }
        
//        gameView.gameBoard.blackGoFirst = self.blackGoFirst;
//        gameView.gameBoard.playerIsBlack = self.playerIsBlack;
//        gameView.gameBoard.AILevel = self.AILevel;
//        gameView.soundOn = self.soundOn;
    }
    if (gameView.soundOn != self.soundOn) {
        if ([self.delegate respondsToSelector:@selector(soundSwitchToggled)]) {
            [self.delegate soundSwitchToggled];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

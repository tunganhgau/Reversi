//
//  ANHMenuViewController.m
//  Reversi
//
//  Created by Anh Nguyen on 3/6/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import "ANHMenuViewController.h"
#import "ANHViewController.h"
@interface ANHMenuViewController ()

@end

@implementation ANHMenuViewController

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
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"grass_pattern.png"]];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ANHViewController *gameViewController = (ANHViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"playerMode"]) {
        gameViewController.playMode = PlayerMode;
    }
    else {
        gameViewController.playMode = ComputerMode;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playWithPlayerButtonPressed:(UIButton *)sender {
    //self.gameView = [self.storyboard instantiateViewControllerWithIdentifier:@"GameView"];
}

- (IBAction)playWithComputerButtonPressed:(UIButton *)sender {
    //self.gameView = [self.storyboard instantiateViewControllerWithIdentifier:@"GameView"];
}
@end

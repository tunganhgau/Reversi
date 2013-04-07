//
//  ANHSettingViewController.h
//  Reversi
//
//  Created by Anh Nguyen on 3/15/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHViewController.h"



@interface ANHSettingViewController : UIViewController

@property (nonatomic) BOOL soundEffect;
@property (nonatomic) BOOL blackGoFirst;
@property (nonatomic) AIDifficulty AILevel;

@end

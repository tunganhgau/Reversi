//
//  ANHSettingDelegate.h
//  Reversi
//
//  Created by Anh Nguyen on 4/8/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANHSettingDelegate <NSObject>

-(void) soundSwitchToggled;
-(void) settingChangedWith:(BOOL)blackGoFirst andPlayerColor:(BOOL)blackColor andAILevel:(int)level;
-(void) cancelSetting;

@end

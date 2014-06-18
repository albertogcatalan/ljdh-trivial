//
//  WinnerController.h
//  ljdhtri
//
//  Created by Alberto González on 01/10/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "SettingsManager.h"

@interface WinnerController : UIViewController{
    int scoreLevel;
    int scoreTotal;
}

@property(nonatomic,retain) IBOutlet UILabel*winnerLabel;
@property(nonatomic,retain) IBOutlet UIButton*twitterbutton;

- (IBAction)pulsarTweet:(id)sender;
-(void)sendEasyTweet;
@end

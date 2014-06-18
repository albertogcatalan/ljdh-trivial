//
//  ViewController.h
//  ljdhtri
//
//  Created by Alberto on 09/08/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "SettingsManager.h"

@interface ViewController : UIViewController{
    int scoreTotal;
    
}
@property(nonatomic,retain) IBOutlet UILabel*puntosInicial;
@property(nonatomic,retain) IBOutlet UIButton*twitterbutton;

- (IBAction)pulsarTweet:(id)sender;
-(void)sendEasyTweet;
- (void)canTweetStatus;

@end

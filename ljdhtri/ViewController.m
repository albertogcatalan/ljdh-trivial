//
//  ViewController.m
//  ljdhtri
//
//  Created by Alberto on 09/08/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize puntosInicial, twitterbutton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SettingsManager *sm = [SettingsManager sharedSettingsManager];
    [sm loadFromFileInLibraryDirectory:@"ljdhtriData.plist"];
    scoreTotal = [sm getInt:@"scoreTotal"];
   [puntosInicial setText:[NSString stringWithFormat:@"%d", scoreTotal]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canTweetStatus) name:ACAccountStoreDidChangeNotification object:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.twitterbutton = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Check to make sure our UI is set up appropriately, depending on if we can tweet or not.
    [self canTweetStatus];
}
- (IBAction)pulsarTweet:(id)sender
{
    if ([TWTweetComposeViewController canSendTweet]){
        [self sendEasyTweet];
    }
}
- (void)sendEasyTweet {
    // Set up the built-in twitter composition view controller.
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    // Set the initial tweet text. See the framework for additional properties that can be set.
    [tweetViewController setInitialText:[NSString stringWithFormat:@"Tengo %d sinsajos en #LJDHTrivial", scoreTotal]];
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                break;
            case TWTweetComposeViewControllerResultDone:
                // The tweet was sent.
                break;
            default:
                break;
        }
        
        // Dismiss the tweet composition view controller.
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    // Present the tweet composition view controller modally.
    [self presentModalViewController:tweetViewController animated:YES];
}
- (void)canTweetStatus {
    if ([TWTweetComposeViewController canSendTweet]) {
        self.twitterbutton.enabled = YES;
        self.twitterbutton.alpha = 1.0f;
    } else {
        self.twitterbutton.enabled = NO;
        self.twitterbutton.alpha = 0.5f;
    }
}




@end

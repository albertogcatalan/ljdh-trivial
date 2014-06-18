//
//  GameOverController.m
//  ljdhtri
//
//  Created by Alberto González on 01/10/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import "GameOverController.h"

@interface GameOverController ()

@end

@implementation GameOverController

@synthesize gameoverLabel;

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
    SettingsManager *sm = [SettingsManager sharedSettingsManager];
    
    [sm loadFromFileInLibraryDirectory:@"ljdhtriData.plist"];
    scoreTotal = [sm getInt:@"scoreTotal"];
    
    [sm loadFromFileInLibraryDirectory:@"ljdhtriData.plist"];
    scoreLevel = [sm getInt:@"scoreLevel"];
    
    [gameoverLabel setText:[NSString stringWithFormat:@"Sinsajos: %d", scoreLevel]];
    scoreTotal = scoreTotal + scoreLevel;
    [sm setInteger:scoreTotal keyString:@"scoreTotal"];
    [sm saveToFileInLibraryDirectory:@"ljdhtriData.plist"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

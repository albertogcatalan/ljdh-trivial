//
//  GameOverController.h
//  ljdhtri
//
//  Created by Alberto González on 01/10/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsManager.h"

@interface GameOverController : UIViewController{
    int scoreLevel;
    int scoreTotal;
}
@property(nonatomic,retain) IBOutlet UILabel*gameoverLabel;

@end

//
//  GameController.h
//  ljdhtri
//
//  Created by Alberto González on 27/09/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsManager.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface GameController : UIViewController{
    int scoreLevel;

}

//declaracion de objetos
@property(nonatomic,retain) IBOutlet UILabel*pregunta;
@property(nonatomic,retain) IBOutlet UILabel*nivel;
@property(nonatomic,retain) IBOutlet UILabel*tiempo;
@property(nonatomic,retain) IBOutlet UILabel*puntos;
@property(nonatomic,retain) IBOutlet UILabel*fallos;
@property(nonatomic,retain) IBOutlet UIButton*boton1;
@property(nonatomic,retain) IBOutlet UIButton*boton2;
@property(nonatomic,retain) IBOutlet UIButton*boton3;
@property (retain, nonatomic) NSTimer *timer;

//declaracion de metodo
- (IBAction)pulsarBoton:(id)sender;

-(void)iniciarNivel;
-(void)iniciarTimer;
-(void)gameover;
-(void)winner;



@end

//
//  GameController.m
//  ljdhtri
//
//  Created by Alberto González on 27/09/12.
//  Copyright (c) 2012 Abelabs. All rights reserved.
//

#import "GameController.h"
#import "GameOverController.h"
#import "WinnerController.h"


@interface GameController ()

@end

@implementation GameController{
    AVAudioPlayer *reproductor;
}

//getters y setters
@synthesize pregunta, boton1, boton2, boton3, nivel, tiempo, fallos, puntos, timer;

//variables
int stage = 0;
int fails = 0;
int points = 0;
int reloj = 30;
int lastRandomIndex = 0;

//constantes
int maxStage = 20;
int maxFails = 3;

//objetos
NSString* plistPath;
NSArray* libroA1;
NSString *question;
NSString *button1;
NSString *button2;
NSString *button3;
NSString *buttonCorrect;
NSString *correcta;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
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
    stage = 0;
    fails = 0;
    points = 0;
    [nivel setText:[NSString stringWithFormat:@"Nivel 1-1"]];
    [fallos setText:[NSString stringWithFormat:@"Fallos %d-3", fails]];
    
    NSString *newAudioFile = [[NSBundle mainBundle] pathForResource:@"timer" ofType:@"caf"];
    
    reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:newAudioFile] error:NULL];
    reproductor.volume = 2.0f;
    [reproductor prepareToPlay];
    [reproductor setNumberOfLoops:30];
    [reproductor play];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(iniciarTimer) userInfo:nil repeats:YES];
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"libro1" ofType:@"plist"];
    libroA1 = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [self iniciarNivel];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)iniciarTimer
{

    reloj -= 1;
    [tiempo setText:[NSString stringWithFormat:@"%d", reloj]];
    
    if (reloj <= 0){
        [timer invalidate];
        if([reproductor isPlaying]){
            [reproductor stop];
        }
        [self gameover];
        
    }
    
    if (stage == maxStage || fails == maxFails)
    {
        if([reproductor isPlaying]){
            [reproductor stop];
        }
    }
}

-(void)gameover{
    SettingsManager *sm = [SettingsManager sharedSettingsManager];
    scoreLevel = points;
    [sm setInteger:scoreLevel keyString:@"scoreLevel"];
    [sm saveToFileInLibraryDirectory:@"ljdhtriData.plist"];
    
    GameOverController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOver"];
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
}
-(void)winner{
    SettingsManager *sm = [SettingsManager sharedSettingsManager];
    scoreLevel = points;
    [sm setInteger:scoreLevel keyString:@"scoreLevel"];
    [sm saveToFileInLibraryDirectory:@"ljdhtriData.plist"];
    
    WinnerController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Winner"];
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
}

-(void)iniciarNivel
{
    if (fails < maxFails) {
        stage += 1;
        if (stage < maxStage){
           
            //generamos aleatoriamente la pregunta
            NSUInteger randomIndex = arc4random() % [libroA1 count];  
            
            if (stage != 1) {
                //comprobamos que no se repita
                while (randomIndex == lastRandomIndex) {
                    randomIndex = arc4random() % [libroA1 count];
                }
            }
            
            lastRandomIndex = randomIndex;
            
            question = [[libroA1 objectAtIndex:randomIndex] objectAtIndex:0];
            button1= [[libroA1 objectAtIndex:randomIndex] objectAtIndex:1];
            button2 = [[libroA1 objectAtIndex:randomIndex] objectAtIndex:2];
            button3 = [[libroA1 objectAtIndex:randomIndex] objectAtIndex:3];
            buttonCorrect = [[libroA1 objectAtIndex:randomIndex] objectAtIndex:4];
            
            [pregunta setText:(question)];
            [boton1 setTitle:(button1) forState:(UIControlStateNormal)];
            [boton2 setTitle:(button2) forState:(UIControlStateNormal)];
            [boton3 setTitle:(button3) forState:(UIControlStateNormal)];
            [nivel setText:[NSString stringWithFormat:@"Nivel 1-%d", stage]];
            
            reloj = 30;
            
           
            
        } else {
            
            [self winner];
            
        }
    
    } else {
        [self gameover];
    }
    
    
}


- (IBAction)pulsarBoton:(id)sender
{
    correcta = [[sender titleLabel] text];
    
    NSString *cadena1;
    NSString *cadena2;
    cadena1 = [self removeEndSpaceFrom:correcta];
    cadena2 = [self removeEndSpaceFrom:buttonCorrect];

  //  NSLog(@" Respuesta boton %@", cadena1);
   // NSLog(@" Respuesta verdadera %@", cadena2);
    
    if ([cadena1 isEqualToString:cadena2]){
        //NSLog(@"OSTIA");
        int generated = (random() % 5) + 1;
        points += generated;
        
        SettingsManager *sm = [SettingsManager sharedSettingsManager];
        scoreLevel = points;
        [sm setInteger:scoreLevel keyString:@"scoreLevel"];
        [sm saveToFileInLibraryDirectory:@"ljdhtriData.plist"];
        
        [puntos setText:[NSString stringWithFormat:@"%d", points]];
        
        [self iniciarNivel];
        
    } else {
        fails += 1;
        [fallos setText:[NSString stringWithFormat:@"Fallos %d-3", fails]];
        
         [self iniciarNivel];
        
    }
    
    
}
-(NSString *)removeEndSpaceFrom:(NSString *)strtoremove{
    NSUInteger location = 0;
    unichar charBuffer[[strtoremove length]];
    [strtoremove getCharacters:charBuffer];
    int i = 0;
    for ( i = [strtoremove length]; i >0; i--){
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:charBuffer[i - 1]]){
            break;
        }
    }
    return  [strtoremove substringWithRange:NSMakeRange(location, i  - location)];
}

@end

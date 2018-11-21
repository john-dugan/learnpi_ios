//
//  GameViewController.m
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>
#import "PiSingleton.h"

@interface GameViewController (){
    NSUInteger currentIndex;
    int64_t currentSelection;
    NSUInteger score;
    unichar currentSelectionChar;
    BOOL newHigh;
    NSString *nextDigit;
    
    SystemSoundID soundEffect;
    CFURLRef        soundFileURLRef;
  
    int16_t strikes;
}

@property (nonatomic, retain) PiSingleton *piSingleton;

@end

@implementation GameViewController

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
    
    self.piSingleton = [PiSingleton sharedPiScore];
    
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"piNoise"
                                                withExtension: @"m4a"];
    
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef,
                                      &soundEffect
                                      );
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleTapToShow)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.piView addGestureRecognizer:gestureRecognizer];
     
     self.piString = [PiSingleton piString:true];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self resetGame];
    [self setupButtons];

    if(self.piSingleton.altLayout) [self goofyButtonLayout];
    
    if(self.piSingleton.strikesOff){
        self.strikesLabel.hidden = true;
        strikes = 2;
    }
    
    if(self.piSingleton.digitInput){
        self.slider.hidden = TRUE;
        self.jumpDigitTextField.hidden = false;
        self.jumpDigitButton.hidden = false;
    }
    else{
        self.slider.hidden = false;
        self.jumpDigitTextField.hidden = true;
        self.jumpDigitButton.hidden = true;
    }
    
    if(self.piSingleton.practiceMode){
        self.strikesLabel.hidden = YES;
        self.tapToShowLabel.hidden = NO;
    }
    else{
        self.tapToShowLabel.hidden = YES;
        self.slider.hidden=YES;
        self.jumpDigitButton.hidden = YES;
        self.jumpDigitTextField.hidden = YES;
    }
}

-(void)resetGame{
    
    NSNumber *highScore = [self.piSingleton highestScore];
    self.bestLabel.text = [NSString stringWithFormat:@"Best: %@ Digits!", highScore];
    
    newHigh = false;
    self.strikesLabel.text = @"";
    self.currentLabel.textColor = [UIColor whiteColor];
    currentIndex = 0;
    score = 0;
    strikes = 0;
    
    self.currentCountLabel.text = [NSString stringWithFormat:@"Current Digit:%lu", (unsigned long)score];

    [self updateLabels];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait );
}

-(IBAction)buttonPressed:(id)sender{
    
    if(self.piSingleton.soundOn)AudioServicesPlaySystemSound (soundEffect);
    
    currentSelection = [sender tag];
    currentSelectionChar = [[NSString stringWithFormat:@"%lld", currentSelection] characterAtIndex:0];
    
    
    if([sender tag] == 10){
        currentSelectionChar = '.';
        if(score == 1){
            score--;
        }
    }
    
    unichar currChar = [self.piString characterAtIndex:currentIndex];
    if(currChar == currentSelectionChar ){
        
        currentIndex++;
        score++;
        [self updateLabels];
        self.currentCountLabel.text = [NSString stringWithFormat:@"Current Digit:%lu", (unsigned long)score];
        self.currentLabel.textColor = [UIColor whiteColor];
        if(strikes>0 && score%100==0){
            strikes--;
            [self updateStrikesLabel];
        }
        
    }
    else {
        //testing = game over, otherwise keep trying
        self.currentLabel.textColor = [UIColor redColor];
        self.strikesLabel.text = @"XXX";
        
        if(!self.piSingleton.practiceMode){
            
            if (strikes < 2){
                strikes++;
                [self updateStrikesLabel];
            }
            else{
                
                self.fourthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex, 1)];
                self.fifthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex+1, 1)];
                self.sixthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex+2, 1)];
                
                nextDigit = [self.piString substringWithRange:NSMakeRange(currentIndex, 1)];
                
                if(score > 0){
                    [self.piSingleton.highScores addObject:[NSNumber numberWithInt:score]];
                    [self.piSingleton save];
                }
                
                if(currentIndex > [self.piSingleton.highestScore intValue]){
                    newHigh = TRUE;
                }
                
                [self gameOver];
            }
            
        }
    }
}

-(void)sliderMoved:(UISlider *)sender{
    currentIndex = self.slider.value;
    score = currentIndex;
    [self updateLabels];
    
    if(currentIndex>1){
        score--;
    }
    self.currentCountLabel.text = [NSString stringWithFormat:@"Current Digit:%lu", (unsigned long)score];
}

-(void) updateStrikesLabel{
    switch (strikes) {
        case 0:{
            self.strikesLabel.text = @"";
            break;
        }
        case 1:{
            self.strikesLabel.text=@"X";
            break;
        }
        case 2:{
            self.strikesLabel.text = @"XX";
            break;
        }
        default:
            break;
    }
    
}

-(void) updateLabels{
    
    if (currentIndex>3) {
        self.zeroLabel.text =  [self.piString substringWithRange:NSMakeRange(currentIndex-4, 1)];
    }
    
    else {
        self.zeroLabel.text = @"";
    }
    
    if (currentIndex>2) {
        self.firstLabel.text =  [self.piString substringWithRange:NSMakeRange(currentIndex-3, 1)];
    }
    else {
        self.firstLabel.text = @"";
    }
    
    if (currentIndex>1) {
        self.secondLabel.text =  [self.piString substringWithRange:NSMakeRange(currentIndex-2, 1)];
    }
    else {
        self.secondLabel.text = @"";
    }
    
    if (currentIndex>0) {
        self.currentLabel.text =  [self.piString substringWithRange:NSMakeRange(currentIndex-1, 1)];
    }
    else {
        self.currentLabel.text = @"?";
    }
    
    
    if(self.piSingleton.practiceMode){
        self.fourthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex, 1)];
        self.fifthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex+1, 1)];
        self.sixthLabel.text = [self.piString substringWithRange:NSMakeRange(currentIndex+2, 1)];
    }
    else {
        self.fourthLabel.text = @"?";
        self.fifthLabel.text = @"?";
        self.sixthLabel.text = @"?";
    }
    self.slider.value = currentIndex;
    
}

-(void)setupButtons{
    
    self.oneButton = [self styleButton:self.oneButton];
    self.twoButton = [self styleButton:self.twoButton];
    self.threeButton = [self styleButton:self.threeButton];
    self.fourButton = [self styleButton:self.fourButton];
    self.fiveButton = [self styleButton:self.fiveButton];
    self.sixButton = [self styleButton:self.sixButton];
    self.sevenButton = [self styleButton:self.sevenButton];
    self.eightButton = [self styleButton:self.eightButton];
    self.nineButton = [self styleButton:self.nineButton];
    self.zeroButton = [self styleButton:self.zeroButton];
    self.decimalButton = [self styleButton:self.decimalButton];
    self.homeButton = [self styleButton:self.homeButton];
    self.jumpDigitButton = [self styleButton:self.jumpDigitButton];
    
}

-(UIButton *)styleButton:(UIButton *)button{
    button.layer.cornerRadius = 0;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.clipsToBounds = YES;
    
    return button;
}

-(void)goofyButtonLayout{
    
    self.oneButton.tag = 7;
    [self.oneButton setTitle:@"7" forState:UIControlStateNormal];
    self.twoButton.tag = 8;
    [self.twoButton setTitle:@"8" forState:UIControlStateNormal];
    self.threeButton.tag = 9;
    [self.threeButton setTitle:@"9" forState:UIControlStateNormal];
    self.sevenButton.tag = 1;
    [self.sevenButton setTitle:@"1" forState:UIControlStateNormal];
    self.eightButton.tag = 2;
    [self.eightButton setTitle:@"2" forState:UIControlStateNormal];
    self.nineButton.tag = 3;
    [self.nineButton setTitle:@"3" forState:UIControlStateNormal];
}

-(IBAction)homePressed{
    if(self.piSingleton.practiceMode){
        [self performSegueWithIdentifier:@"menu" sender:self];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to quit?" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Show Menu", nil];
        alert.tag = 333;
        [alert show];
    }
}

- (IBAction)jumpDigitButtonPressed:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Jump to digit" message:@"" delegate:self cancelButtonTitle:@"Jump!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.jumpDigitTextField = [alert textFieldAtIndex:0];
    self.jumpDigitTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.jumpDigitTextField.placeholder = @"1-4999";
    alert.tag = 666;
    [alert show];
    
}

-(void)toggleTapToShow{
    self.tapToShowLabel.hidden = !self.tapToShowLabel.hidden;
}

-(void)gameOver{
    
    NSString *responseString;
    if(newHigh){
        responseString = [NSString stringWithFormat:@"The next digit was: %@ \n\n New High Score: %lu!  ", nextDigit, (unsigned long)score];
        
    }
    else {
        responseString = [NSString stringWithFormat:@"Better luck next time! \n The next digit was: %@ \n Your score: %lu", nextDigit, (unsigned long)score];
        
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:responseString delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:@"Show Menu", nil];
    alertView.tag = 999;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Menu button mid game
    if(alertView.tag == 333){
        if(buttonIndex != alertView.cancelButtonIndex){
            [self performSegueWithIdentifier:@"menu" sender:self];
        }
    }
    //jump to digit
    else if(alertView.tag == 666){
        
        NSString * strippedNumber = [self.jumpDigitTextField.text stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self.jumpDigitTextField.text length])];
        
        NSUInteger inputDigit = [strippedNumber intValue]+1;
        
        if(inputDigit>5000){
            inputDigit = 5000;
        }
        
        currentIndex = inputDigit;
        score = currentIndex;
        [self updateLabels];
        
        if(currentIndex>1){
            score--;
        }
        self.currentCountLabel.text = [NSString stringWithFormat:@"Current Digit:%lu", (unsigned long)score];
        
    }
    else if(alertView.tag == 999){
        if(buttonIndex != alertView.cancelButtonIndex){
            [self performSegueWithIdentifier:@"menu" sender:self];
        }
        else{
            [self resetGame];
        }
    }
}

-(UIViewController *)viewControllerForPresentingModalView{
    return self.navigationController;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end

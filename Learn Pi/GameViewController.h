//
//  GameViewController.h
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UIButton *oneButton;
@property (nonatomic, retain) IBOutlet UIButton *twoButton;
@property (nonatomic, retain) IBOutlet UIButton *threeButton;
@property (nonatomic, retain) IBOutlet UIButton *fourButton;
@property (nonatomic, retain) IBOutlet UIButton *fiveButton;
@property (nonatomic, retain) IBOutlet UIButton *sixButton;
@property (nonatomic, retain) IBOutlet UIButton *sevenButton;
@property (nonatomic, retain) IBOutlet UIButton *eightButton;
@property (nonatomic, retain) IBOutlet UIButton *nineButton;
@property (nonatomic, retain) IBOutlet UIButton *zeroButton;
@property (nonatomic, retain) IBOutlet UIButton *decimalButton;
@property (nonatomic, retain) IBOutlet UIButton *homeButton;

@property (weak, nonatomic) IBOutlet UIView *piView;

@property (nonatomic, retain) IBOutlet UILabel *zeroLabel;
@property (nonatomic, retain) IBOutlet UILabel *firstLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentLabel;
@property (nonatomic, retain) IBOutlet UILabel *fourthLabel;
@property (nonatomic, retain) IBOutlet UILabel *fifthLabel;
@property (nonatomic, retain) IBOutlet UILabel *sixthLabel;

@property (nonatomic, retain) IBOutlet UILabel *currentCountLabel;
@property (nonatomic, retain) IBOutlet UILabel *bestLabel;
@property (strong, nonatomic) IBOutlet UILabel *strikesLabel;

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UITextField *jumpDigitTextField;
@property (strong, nonatomic) IBOutlet UIButton *jumpDigitButton;

@property (weak, nonatomic) IBOutlet UILabel *tapToShowLabel;


//@property (nonatomic) BOOL testMode;
@property (nonatomic, retain) NSString *piString;



-(IBAction)sliderMoved:(UISlider *)sender;
-(IBAction)buttonPressed:(id)sender;
-(IBAction)homePressed;
- (IBAction)jumpDigitButtonPressed:(id)sender;

@end
 

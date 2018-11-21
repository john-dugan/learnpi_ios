//
//  LearnPiViewController.h
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ShowMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *piTextView;
@property (weak, nonatomic) IBOutlet UILabel *groupByLabel;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

@property (nonatomic) int16_t groupSize;
- (IBAction)stepperValueChanged:(id)sender;

@end

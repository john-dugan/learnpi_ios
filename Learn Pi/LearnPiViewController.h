//
//  LearnPiViewController.h
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LearnPiViewController : UIViewController 

@property (nonatomic, retain) IBOutlet UIButton *testButton;
@property (nonatomic, retain) IBOutlet UIButton *practiceButton;
@property (nonatomic, retain) IBOutlet UIButton *showMeButton;
@property (nonatomic, retain) IBOutlet UIButton *upgradeButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (nonatomic, retain) IBOutlet UILabel *highScoreLabel;
@property (strong, nonatomic) IBOutlet UIView *adHolderView;
@property (strong, nonatomic) IBOutlet UILabel *bgPi;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgPiConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *settingsWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *testButtonConstraint;

-(IBAction)upgradeButton:(id)sender;



@end

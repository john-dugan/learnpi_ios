//
//  LearnPiViewController.m
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import "LearnPiViewController.h"
#import "GameViewController.h"

@interface LearnPiViewController ()

@end

@implementation LearnPiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupButtons];
    [self piDay];
    self.title = @"Menu";
    
    self.bgPi.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:450.0f];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];

    int64_t highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
    self.highScoreLabel.text = [NSString stringWithFormat:@"High Score: %lld Digits!", highscore];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *bundleID = [mainBundle bundleIdentifier];
    
    if([bundleID isEqualToString:@"Learn-Pi-Free"]){
//        AdSingleton *adSingleton = [AdSingleton sharedInstance];
//        adSingleton.bannerView.rootViewController = self;
//        [adSingleton getBanner];
//        [self.adHolderView addSubview:adSingleton.bannerView];
    }
    else{
        self.adHolderView.hidden = YES;
        self.upgradeButton.hidden = YES;
        self.settingsWidthConstraint.constant = self.testButtonConstraint.constant;
        [self.view layoutIfNeeded];
    }
    
    self.bgPiConstraint.constant = -5000;
    [UIView animateWithDuration:125.0f
                          delay:0.1f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];

}


-(IBAction)upgradeButton:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/learn-pi/id513763695?ls=1&mt=8"]];
    
}


-(void)setupButtons{
    
    self.testButton = [self styleButton:self.testButton];
    self.practiceButton = [self styleButton:self.practiceButton];
    self.showMeButton = [self styleButton:self.showMeButton];
    self.upgradeButton = [self styleButton:self.upgradeButton];
    self.settingsButton = [self styleButton:self.settingsButton];
    
}

-(UIButton *)styleButton:(UIButton *)button{
    button.layer.cornerRadius = 0;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.clipsToBounds = YES;
    
    return button;
}

- (NSString *)adWhirlApplicationKey {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        return @"73f8499f4589431eb9b52e28d45b4d39";
    }
    else
    {
        return @"486a3be16bba4ad28caa1b76f12b718b";
    }
    
}
-(UIViewController *)viewControllerForPresentingModalView{
    return self.navigationController;
}

-(IBAction)piDay{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    
    if(day == 14 && month == 3){
        UIAlertView *alertView;
        
        alertView = [[UIAlertView alloc] initWithTitle:@"Happy Pi Day!" message:@"Thanks for playing" delegate:self cancelButtonTitle:@"Yeah Pi!" otherButtonTitles:nil];
        
        [alertView show];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

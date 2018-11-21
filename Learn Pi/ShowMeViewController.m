//
//  LearnPiViewController.m
//  Learn Pi
//
//  Created by John Dugan on 3/24/12.
//  Copyright (c) 2012 DuganSoft. All rights reserved.
//

#import "ShowMeViewController.h"
#import "LearnPiViewController.h"
#import "PiSingleton.h"

@interface ShowMeViewController ()

@end

@implementation ShowMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.groupSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"groupsize"];
    
    if(self.groupSize <= 0){
        self.groupSize = 5;
    }
        
    self.stepper.value = self.groupSize;
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [self formatPiText];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait  || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void)formatPiText{
    NSString *piString = [PiSingleton piString:false];

    NSMutableString *newString = [NSMutableString string];
    for (int i = 0; i < [piString length]; i++)
    {
        int ascii = [piString characterAtIndex:i];
        
        if (i % self.groupSize == 0 && i>0)
        {
            [newString appendString:@"  "];
        }
        [newString appendFormat:@"%c",ascii];
        
    }
    self.piTextView.text = newString;
    self.groupByLabel.text = [NSString stringWithFormat:@"Grouping: %d", self.groupSize];
}

-(UIViewController *)viewControllerForPresentingModalView{
    return self.navigationController;
}

- (IBAction)stepperValueChanged:(UIStepper *)sender  {
    self.groupSize = sender.value;
    [[NSUserDefaults standardUserDefaults] setInteger:self.groupSize forKey:@"groupsize"];
    [self formatPiText];
}
    
@end

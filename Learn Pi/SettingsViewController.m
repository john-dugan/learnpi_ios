//
//  SettingsViewController.m
//  Learn Pi
//
//  Created by John Dugan on 2/11/13.
//
//

#import "SettingsViewController.h"
#import "PiSingleton.h"

@interface SettingsViewController ()

@property (nonatomic, retain) PiSingleton *piSingleton;

@end

@implementation SettingsViewController

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

}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    if(self.piSingleton.altLayout) {
        [self.layoutSwitch setOn:YES animated:YES];
    }
    if(self.piSingleton.soundOn) {
        [self.soundSwitch setOn:YES animated:YES];
    }
    if(self.piSingleton.strikesOff) {
        [self.strikesSwitch setOn:YES animated:YES];
    }
    if(self.piSingleton.digitInput) {
        [self.digitInputSwitch setOn:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)layoutSwitchChanged:(id)sender {
    
    self.piSingleton.altLayout = [sender isOn];
    [self.piSingleton save];
}

- (IBAction)soundSwitchChanged:(id)sender {
    self.piSingleton.soundOn = [sender isOn];
    [self.piSingleton save];
}

- (IBAction)strikesSwitchChanged:(id)sender {
    self.piSingleton.strikesOff = [sender isOn];
    [self.piSingleton save];
}

- (IBAction)digitInputSwitchChanged:(id)sender {
    self.piSingleton.digitInput = [sender isOn];
    [self.piSingleton save];
}

@end

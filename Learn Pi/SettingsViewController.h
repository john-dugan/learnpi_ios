//
//  SettingsViewController.h
//  Learn Pi
//
//  Created by John Dugan on 2/11/13.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (nonatomic,retain) IBOutlet UISwitch *layoutSwitch;
@property (nonatomic,retain) IBOutlet UISwitch *soundSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *strikesSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *digitInputSwitch;

- (IBAction)layoutSwitchChanged:(id)sender;
- (IBAction)soundSwitchChanged:(id)sender;
- (IBAction)strikesSwitchChanged:(id)sender;
- (IBAction)digitInputSwitchChanged:(id)sender;


@end

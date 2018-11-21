//
//  MenuViewController.h
//  Learn Pi Free
//
//  Created by John Dugan on 2/8/15.
//
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *practiceButton;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIButton *showMeButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

- (IBAction)practiceButtonPressed:(id)sender;
- (IBAction)testButtonPressed:(id)sender;
- (IBAction)showMeButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;

@end

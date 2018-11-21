//
//  MenuViewController.m
//  Learn Pi Free
//
//  Created by John Dugan on 2/8/15.
//
//

#import "MenuViewController.h"
#import "PiSingleton.h"

@interface MenuViewController ()

@property (nonatomic, retain) NSArray *sortedScores;
@property (nonatomic, retain) PiSingleton *piSingleton;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.piSingleton = [PiSingleton sharedPiScore];
    [self setupButtons];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    self.sortedScores =  [self.piSingleton.highScores sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.piSingleton.highScores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PiCell"];
    
    UILabel *scoreLabel = (UILabel *)[cell viewWithTag:1];
    scoreLabel.text = [NSString stringWithFormat:@"%d. %@ digits", indexPath.row + 1, [self.sortedScores objectAtIndex:indexPath.row]];
    
    return cell;
}

- (IBAction)practiceButtonPressed:(id)sender {
    self.piSingleton.practiceMode = true;
    [self.piSingleton save];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)testButtonPressed:(id)sender {
    self.piSingleton.practiceMode = false;
    [self.piSingleton save];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showMeButtonPressed:(id)sender {
}

- (IBAction)settingsButtonPressed:(id)sender {
}


-(void)setupButtons{
    self.testButton = [self styleButton:self.testButton];
    self.practiceButton = [self styleButton:self.practiceButton];
    self.showMeButton = [self styleButton:self.showMeButton];
    self.settingsButton = [self styleButton:self.settingsButton];
}

-(UIButton *)styleButton:(UIButton *)button{
    button.layer.cornerRadius = 0;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.clipsToBounds = YES;
    
    return button;
}
@end

//
//  TaskViewController.m
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *defaultDeadlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *defaultDifficultyTextField;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    self.defaultDifficultyTextField.placeholder = [NSString stringWithFormat:@"current default difficulty: %@, tap to reset", [ud objectForKey:@"defaultDifficulty"]];
    self.defaultDeadlineTextField.placeholder = [NSString stringWithFormat:@"current default deadline: %@, tap to reset", [ud objectForKey:@"defaultDeadline"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setDefaults:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.defaultDeadlineTextField.text forKey:@"defaultDeadline"];
    [ud setObject:self.defaultDifficultyTextField.text forKey:@"defaultDifficulty"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

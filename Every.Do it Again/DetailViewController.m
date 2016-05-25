//
//  DetailViewController.m
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *completionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    
    self.descriptionLabel.numberOfLines = 0;
    
    self.title = @"Details";
    self.titleLabel.text = self.ourTodo.title;
    self.descriptionLabel.text = self.ourTodo.theDescription;
    self.completionLabel.text = [NSString stringWithFormat:@"Completed: %@", self.ourTodo.isCompleted ? @"YES" : @"NO"];
    self.priorityLabel.text = [NSString stringWithFormat:@"Priority: %lld", self.ourTodo.priority];
    self.deadlineLabel.text = [NSString stringWithFormat:@"Deadline: %@", self.ourTodo.deadline];
    self.difficultyLabel.text = [NSString stringWithFormat:@"Difficulty: %@", self.ourTodo.difficulty];
    
}

@end

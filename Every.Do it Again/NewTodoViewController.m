//
//  DetailViewController.m
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "NewTodoViewController.h"
#import "Todo.h"

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewTodo:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
    newTodo.title = self.titleTextField.text;
    newTodo.theDescription = self.descriptionTextField.text;
    newTodo.priority = [self.priorityTextField.text intValue];
    newTodo.details = self.detailsTextField.text;
    newTodo.isCompleted = NO;
    newTodo.deadline = [ud objectForKey:@"defaultDeadline"];
    newTodo.difficulty = [ud objectForKey:@"defaultDifficulty"];
    [self.moc save:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

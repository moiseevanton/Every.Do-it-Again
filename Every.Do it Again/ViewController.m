//
//  ViewController.m
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Todo.h"
#import "CustomCell.h"
#import "NewTodoViewController.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fethcedController;
@property (strong, nonatomic) NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set this view contoller as the delegate and datasource for the table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // getting the managed object context
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    self.moc = appDel.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    self.fethcedController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.moc sectionNameKeyPath:nil cacheName:nil];
    
    // make this view controller the delegate of the fetched controller
    self.fethcedController.delegate = self;
    
    // perform the fetch
    [self.fethcedController performFetch:nil];
    
    // set title
    self.title = @"Todo list";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newTodo"]) {
        NewTodoViewController *ntvc = segue.destinationViewController;
        ntvc.moc = self.moc;
    }
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Todo *todo = [self.fethcedController objectAtIndexPath:indexPath];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.ourTodo = todo;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fethcedController fetchedObjects] count];
}

- (void)configureCell:(CustomCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Todo *todo = [self.fethcedController objectAtIndexPath:indexPath];
    cell.titleLabel.text = todo.title;
    cell.descriptionLabel.text = todo.theDescription;
    cell.priorityLabel.text = [NSString stringWithFormat:@"Priority: %lld", todo.priority];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Todo *todo;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        todo = [self.fethcedController objectAtIndexPath:indexPath];
        [self.moc deleteObject:todo];
        [self.moc save:nil];
    }
}

@end

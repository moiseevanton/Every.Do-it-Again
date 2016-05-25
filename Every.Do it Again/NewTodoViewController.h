//
//  DetailViewController.h
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NewTodoViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *moc;

@end

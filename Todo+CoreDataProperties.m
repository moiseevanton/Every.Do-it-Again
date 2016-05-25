//
//  Todo+CoreDataProperties.m
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

@dynamic title;
@dynamic theDescription;
@dynamic priority;
@dynamic isCompleted;
@dynamic details;
@dynamic deadline;
@dynamic difficulty;

@end

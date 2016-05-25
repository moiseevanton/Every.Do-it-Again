//
//  Todo+CoreDataProperties.h
//  Every.Do it Again
//
//  Created by Anton Moiseev on 2016-05-25.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *theDescription;
@property (nonatomic) int64_t priority;
@property (nonatomic) BOOL isCompleted;
@property (nullable, nonatomic, retain) NSString *details;

@end

NS_ASSUME_NONNULL_END

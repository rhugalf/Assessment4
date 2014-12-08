//
//  Person.h
//  Assessment4
//
//  Created by GLB-MXM0004 on 07/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dogs;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addDogsObject:(Dog *)value;
- (void)removeDogsObject:(Dog *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

+ (NSArray *)personsFromArray:(NSArray *)tempPersons withManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

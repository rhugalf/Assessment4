//
//  Person.m
//  Assessment4
//
//  Created by GLB-MXM0004 on 07/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "Person.h"
#import "Dog.h"


@implementation Person

@dynamic name;
@dynamic dogs;

+ (NSArray *)personsFromArray:(NSArray *)tempPersons withManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSMutableArray *persons = [NSMutableArray new];
    
    for (NSString *name in tempPersons)
    {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
        person.name = name;
        
        [persons addObject:person];
    }
    
    return persons;
}

@end

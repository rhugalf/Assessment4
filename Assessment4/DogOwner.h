//
//  DogOwner.h
//  Assessment4
//
//  Created by Hugo on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DogOwner : NSObject

@property NSArray *listPerson;

@property NSManagedObjectContext *managedObjectContext;

-(void)retrieveListOwnersWithCompletion:(void  (^)(NSArray*))complete;


@end

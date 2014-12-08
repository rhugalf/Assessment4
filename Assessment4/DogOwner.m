//
//  DogOwner.m
//  Assessment4
//
//  Created by Hugo on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogOwner.h"
#import "Person.h"

@implementation DogOwner

-(void)retrieveListOwnersWithCompletion:(void (^)(NSArray *))complete{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO]];
    
    NSError *error;
    self.listPerson = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!error) {
        if (!self.listPerson || self.listPerson.count==0 ) {
            [self retrieveDataJsonWithCompletion:^(NSArray *people) {
                NSArray *aux = people;
                self.listPerson = [Person personsFromArray:aux withManagedObjectContext:self.managedObjectContext];
                NSError *error;
                [self.managedObjectContext save:&error];
                if (error) {
                    NSLog(@"Erro info in save: %@, %@",error,error.userInfo);
                }
                
                complete(self.listPerson);
            }];
        }else{
            complete(self.listPerson);
        }
    }
}


-(void)retrieveDataJsonWithCompletion:(void (^)(NSArray *))complete{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%@", connectionError);
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        NSError *jsonError	 = nil;
        NSArray *dogowners = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
     
        complete(dogowners);
    }];
}


@end

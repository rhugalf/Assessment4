//
//  DogOwner.m
//  Assessment4
//
//  Created by Hugo on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogOwner.h"

@implementation DogOwner

-(instancetype)initWithString:(NSString *)value{
    self = [self init];
    
    if(self){
        self.name = value;
    }
    return self;
}
+(void)retrieveDogOwnersWithCompletion:(void (^)(NSArray *))complete{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%@", connectionError);
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        NSError *jsonError	 = nil;
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        NSMutableArray *dogowners = [NSMutableArray arrayWithCapacity:results.count];
        
        for (NSString *arg in results) {
            DogOwner *owner = [[DogOwner alloc] initWithString:arg ];
            [dogowners addObject:owner];
        }
        complete(dogowners);
    }];
}
@end

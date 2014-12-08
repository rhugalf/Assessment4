//
//  ColorUser.h
//  Assessment4
//
//  Created by GLB-MXM0004 on 08/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ColorUser : NSManagedObject

@property (nonatomic, retain) NSNumber * colorRValue;
@property (nonatomic, retain) NSNumber * colorGValue;
@property (nonatomic, retain) NSNumber * colorBValue;
@property (nonatomic, retain) NSNumber * colorAValue;

@end

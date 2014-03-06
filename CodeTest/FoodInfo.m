//
//  FoodInfo.m
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "FoodInfo.h"

@implementation FoodInfo


/* 
 Basic FoodInfo class: 
    attributes: fd_id   -   food id # in db
                name    -   human readable name
                grp_id  –   food group # in db
                group   -   human readable food group
 
 */

- (id)initWithFoodID:(NSNumber*)fd_id name:(NSString *)name grp_id:(NSNumber*)grp_id group:(NSString *)group {
    if ((self = [super init])) {
        self.fd_id = fd_id;
        self.name = name;
        self.grp_id = grp_id;
        self.group = group;
    }
    return self;
}

@end

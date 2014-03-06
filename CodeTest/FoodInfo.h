//
//  FoodInfo.h
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSNumber *fd_id;
@property (nonatomic, strong) NSNumber *grp_id;


- (id)initWithFoodID:(NSNumber*)fd_id name:(NSString *)name grp_id:(NSNumber*)grp_id group:(NSString *)group;

@end

//
//  FoodDatabase.h
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface FoodDatabase : NSObject {
    sqlite3 *_database;
}

+ (FoodDatabase*)database;
- (NSArray *)foodInfos;
- (NSArray *)foodGroups;
- (NSArray *)foodList:(NSNumber*)fd_grp_id;
- (NSArray *)foodDetails:(NSNumber*)fd_id;

@end

//
//  FoodDatabase.m
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "FoodDatabase.h"
#import "FoodInfo.h"

@implementation FoodDatabase

static FoodDatabase *_database;

// construct database
+ (FoodDatabase*)database {
    // is no data, create one
    if (_database == nil) {
        _database = [[FoodDatabase alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"cnf_food"
                                                             ofType:@"sqlite3"];
        
        // error handle
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        } else {
            NSLog(@"Opened Database");
        }
    }
    return self;
}

- (NSArray *)foodInfos {
    NSLog(@"Did Call: foodInfos");
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    // SUPER IMPORTANT GET THIS ONE RIGHT
    NSString *query = @"SELECT fd_id, f.a_fd_nme, fg.fd_grp_nme FROM food f LEFT JOIN food_groups fg ON f.fd_grp_id = fg.fd_grp_id";
    // will hold SQLite return statement
    sqlite3_stmt *statement;
    // call the API on '_database' with 'query', put into 'statement'
    int sqliteErrorCode = sqlite3_prepare_v2(_database, [query UTF8String], 1000, &statement, nil);
    NSLog(@"%i", sqliteErrorCode);
    NSLog(@"Error %s while preparing statement", sqlite3_errmsg(_database));
    if (sqliteErrorCode == SQLITE_OK) {
        NSLog(@"Entered Statement Calling Process");
        // iterate over all returned statements
        while (sqlite3_step(statement) == SQLITE_ROW) {
            /* example of sqlite return
             502105	TURKEY, BROILER, THIGH, MEAT AND SKIN, ROASTED	Poultry Products
             502106	TURKEY, BROILER, THIGH, MEAT ONLY, RAW	Poultry Products
             502107	TURKEY, BROILER, THIGH, MEAT ONLY, ROASTED	Poultry Products
             502108	TURKEY, ALL CLASSES, BACK, MEAT ONLY, ROASTED	Poultry Products
             502109	TURKEY, ALL CLASSES, BACK, MEAT ONLY, RAW	Poultry Products
             502110	SAUCE, HOLLANDAISE (BUTTER SAUCE)	Soups, Sauces and Gravies             */
            // Food_ID is column 0
            int fd_id = sqlite3_column_int(statement, 0);
            // FOOD_NAME is column 1
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            // FOOD_GROUP is column 2
            char *groupChars = (char *) sqlite3_column_text(statement, 2);
            // change UTF8 chars into Strings (that's what we work with)
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *group = [[NSString alloc] initWithUTF8String:groupChars];
            NSLog(@"Call Returned: %@ %@", name, group);
            // Make an object to store our Info. Initialize with #, name and group
            FoodInfo *info = [[FoodInfo alloc]
                                    initWithFoodID:fd_id name:name group:group];
            // append object to our Array of values
            [retval addObject:info];
        }
        // Reset query
        sqlite3_finalize(statement);
    }
    return retval;
    
}

@end

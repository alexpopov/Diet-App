//
//  AMAFoodViewController.h
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodInfo.h"

@interface AMAFoodViewController : UITableViewController

@property(nonatomic)int fd_grp_id;
@property(nonatomic, strong) NSArray *foods;
@property(nonatomic, strong) FoodInfo *info;

@end

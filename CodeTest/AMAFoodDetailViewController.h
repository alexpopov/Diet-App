//
//  AMAFoodDetailViewController.h
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodInfo.h"

@interface AMAFoodDetailViewController : UITableViewController

@property(strong, nonatomic) NSString *title;
@property(nonatomic, strong) FoodInfo *current;

@end

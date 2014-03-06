//
//  AMAFoodDetailViewController.m
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "AMAFoodDetailViewController.h"
#import "FoodDatabase.h"
#import "FoodInfo.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface AMAFoodDetailViewController ()

@property(nonatomic, strong) NSArray *headersArray;
@property(nonatomic, strong) NSArray *foodDetail;

@end

@implementation AMAFoodDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foodDetail = [[FoodDatabase database] foodDetails:self.current.fd_id];
    self.title = [self.current.name capitalizedString];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.foodDetail count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSArray *data = [self.foodDetail objectAtIndex:indexPath.row];
    if ([[data objectAtIndex:1]  isEqual: [NSNumber numberWithFloat:0]]) {
        return cell;
    }
    cell.textLabel.text = [[data objectAtIndex:0] capitalizedString];
    NSNumber *value =[data objectAtIndex:1];
    float flVal = [value floatValue];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%@", flVal, [data objectAtIndex:2]];
    cell.detailTextLabel.textColor = UIColorFromRGB(0xff6c00);
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", self.current.group ];
}

//- (void)fillHeadersArray {
//    NSLog(@"fillHeadersArray");
//    // NSArray *headers = @[@"Vitamins", @"Fats", @"Calories", @"Minerals"];
//    NSArray *headers = @[@"Proteins", @"Irons"];
//    self.headersArray = headers;
//    NSLog(@"headers size: %d", [headers count]);
//}

@end

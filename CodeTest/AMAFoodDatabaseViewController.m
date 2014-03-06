//
//  AMAFoodDatabaseViewController.m
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "AMAFoodDatabaseViewController.h"
#import "FoodDatabase.h"
#import "FoodInfo.h"

@interface AMAFoodDatabaseViewController ()

@property(nonatomic)int selected_fd_grp_id;
@property (nonatomic, strong) NSArray* foodGroup;

@end

@implementation AMAFoodDatabaseViewController

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
    self.foodGroup = [[FoodDatabase database] foodGroups];
    self.title = @"Food Groups";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of foodGroups in the section.
    return [self.foodGroup count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // info for cell
    FoodInfo *info = [self.foodGroup objectAtIndex:indexPath.row];
    //NSLog(@"fd_id: %@, name: %@, grp_id: %@, group: %@", info.fd_id, info.name, info.grp_id, info.group);
    // trim any excess white space
    cell.textLabel.text = [[info.group capitalizedString] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@""]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoodInfo *info = [self.foodGroup objectAtIndex:indexPath.row];
    // pass selected food to next ViewController
    AMAFoodViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"foodsView"];
    myController.info = info;
    //NSLog(@"Food info: %@, %@", info.group, info.name);
    [self.navigationController pushViewController: myController animated:YES];
}

@end

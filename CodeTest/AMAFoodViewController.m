//
//  AMAFoodViewController.m
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "AMAFoodViewController.h"
#import "AMAFoodDetailViewController.h"
#import "FoodDatabase.h"
#import "FoodInfo.h"

@interface AMAFoodViewController ()

@end

@implementation AMAFoodViewController

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
    self.foods = [[FoodDatabase database] foodList:self.info.grp_id];
    self.title = [[NSString stringWithFormat:@"%@", self.info.group ] capitalizedString];
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
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.foods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [[cell textLabel] setNumberOfLines:0]; // unlimited number of lines
    [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    [[cell textLabel] sizeToFit];
    
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    NSString *cellText = [info.name capitalizedString];
    cellText = [[self invertString:cellText] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    cell.textLabel.text = cellText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this method is called for each cell and returns height
//    NSStringDrawingContext *ctx = [NSStringDrawingContext new];
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    //NSLog(@"Food info: %@, %@, %@", info.fd_id, info.group, info.name);
//    NSString *aString = [[NSString alloc] initWithString:[info.name capitalizedString]];
    NSString *text = [[NSString alloc] initWithString:[info.name capitalizedString]];

//    UITextView *textView = [[UITextView alloc] init];
//    [textView setText:aString];
//    CGRect textRect = [textView.text boundingRectWithSize:self.view.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:ctx];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize: 14.0] forWidth:[tableView frame].size.width - 40.0 lineBreakMode:NSLineBreakByWordWrapping];
   
    // return either default height or height to fit the text
    return textSize.height < 44 ? 44 : textSize.height;
//    return textRect.size.height < 44 ? 44 : textRect.size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    
    AMAFoodDetailViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    myController.title = info.name ;
    myController.current = info;
    NSLog(@"Food info: %@, %@, %@",info.fd_id, info.group, info.name);

    [self.navigationController pushViewController: myController animated:YES];
}

- (NSString*)invertString:(NSString *)string {
    NSArray *stringArray = [[NSArray alloc] init];
    stringArray = [string componentsSeparatedByString:@","];
    NSArray* reversedArray = [[stringArray reverseObjectEnumerator] allObjects];
    NSString * result = [[reversedArray valueForKey:@"description"] componentsJoinedByString:@" "];
    return result;
}

@end

//
//  ProfileViewController.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 09.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwoLabelsCustomCell.h"
#import "APIClient.h"

@interface ProfileViewController ()

@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation ProfileViewController {
    NSArray *_listOfKeys;
    NSArray *_listOfTitles;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setTitle:@"Профайл"];
    
    /*
    address = "L.Svobody av.";
    cell = "+380675758599";
    deliveryAddress = "L.Svobody av.";
    deliveryRecipient = "  ";
    deliveryService = "";
    deliveryWarehouse = "";
    email = "frp.omnia@gmail.com";
    name = "Tatyana, Omnia";
    phone = "+380675758599";
     */
    
    _listOfKeys = @[@"name", @"email", @"cell", @"phone", @"address", @"deliveryAddress", @"deliveryRecipient", @"deliveryService", @"deliveryWarehouse"];
    _listOfTitles = @[@"ФИО:", @"Email:", @"Моб. телефон", @"Домашний телефон:", @"Адрес:", @"Адрес доставки:", @"ФИО получателя:", @"Сервис доставки:", @"Номер склада доставки:"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    __weak ProfileViewController *weakSelf = self;
    
    [[APIClient sharedClient] userProfileWithSuccess:^(NSDictionary *response) {
        Debug(@"Response: %@", response);
        weakSelf.userInfo = response;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        // TODO: show error
        [self showAlertViewWithError:error];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Debug(@"Count: %d", [[self.userInfo allKeys] count]);
    return [[self.userInfo allKeys] count] ? [[self.userInfo allKeys] count]: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProfileTableCell";
    TwoLabelsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.firstLabel.text = _listOfTitles[indexPath.row];
    cell.secondLabel.text = self.userInfo[_listOfKeys[indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

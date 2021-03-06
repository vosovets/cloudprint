//
//  BalanceViewController.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 09.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceTableViewCell.h"
#import "APIClient.h"

@implementation BalanceViewController {
    NSArray *_transactions;
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
    [self.navigationItem setTitle:@"Баланс"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[APIClient sharedClient] balanceWithSuccess:^(NSArray *response) {
        _transactions = response;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        // TODO: show error
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BalanceCell";
    BalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *transaction = _transactions[indexPath.row];
    // Configure the cell...
//    @{@"title": @"", @"date": @"05.10.2012 09:35", @"balance":@"-5000 грн.", @"comment": @"Отправка посылки"}];
    cell.titleLabel.text = transaction[@"title"];
    cell.timeLabel.text = transaction[@"date"];
    cell.amountMoneyLabel.text = transaction[@"balance"];
    cell.commentLabel.text = transaction[@"comment"];
    
    
    // apply color for money
    NSRange foundNegativeSymbol = [[transaction objectForKey:@"balance"] rangeOfString:@"-"];
    Debug(@"%@", NSStringFromRange(foundNegativeSymbol));
    
    if (NSEqualRanges(foundNegativeSymbol, NSMakeRange(NSNotFound, 0))) {
        cell.amountMoneyLabel.textColor = [UIColor greenColor];
    } else {
        cell.amountMoneyLabel.textColor = [UIColor redColor];
    }
    
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

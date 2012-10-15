//
//  OrderTableViewCell.h
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 15.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@end

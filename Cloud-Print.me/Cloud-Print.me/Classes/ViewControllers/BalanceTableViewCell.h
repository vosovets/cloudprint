//
//  BalanceTableViewCell.h
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 15.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end


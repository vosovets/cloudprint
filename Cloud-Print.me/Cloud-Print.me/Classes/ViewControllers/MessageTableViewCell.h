//
//  MessageTableViewCell.h
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 11.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *messageDescription;
@property (nonatomic, weak) IBOutlet UILabel *messageDate;

@end

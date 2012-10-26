//
//  UIViewController+Alerts.h
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 26.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message;
- (void)showAlertViewWithError:(NSError *)error;

@end

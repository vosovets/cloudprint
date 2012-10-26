//
//  UIViewController+Alerts.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 26.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "UIViewController+Alerts.h"
#import "APIClient.h"

@implementation UIViewController (Alerts)

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)showAlertViewWithError:(NSError *)error {
    
    NSString *title = nil;
    if (error.code ==  StatusCodeLogicError) {
        title = @"Ошибка";
    } else if (error.code == StatusCodeServerError) {
        // internet connection or server error
        title = @"Server error";
        // TODO:
        error = [NSError errorWithDomain:@"Server is not available. Check your internet connection or try to contact support." code:error.code userInfo:error.userInfo];
    } else {
        title = [NSString stringWithFormat:@"Error code: %d", error.code];
    }
    
    [self showAlertViewWithTitle:title
                         message:error.domain];
}


@end

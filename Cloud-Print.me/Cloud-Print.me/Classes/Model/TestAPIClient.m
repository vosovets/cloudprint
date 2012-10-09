//
//  TestAPIClient.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 09.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "TestAPIClient.h"

@implementation TestAPIClient

#pragma mark - Login & Logout

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
           withSuccess:(void (^)(NSDictionary *))successBlock
               failure:(void (^)(NSError *))failureBlock {
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(@{@"token": @"1421423-31432423-324324-13243241"});
    });
}

- (void)logoutWithSuccess:(void (^)(NSDictionary *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(@{});
    });
}

#pragma mark - Functionality

- (void)userProfileWithSuccess:(void (^)(NSDictionary *))successBlock
                       failure:(void (^)(NSError *))failureBlock {
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(@{@"username": @"Иван Иванович"});
    });
}

- (void)messagesWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock {
    
}

- (void)balanceWithSuccess:(void (^)(NSDictionary *))successBlock
                   failure:(void (^)(NSError *))failureBlock {
    
}

- (void)ordersWithSuccess:(void (^)(NSArray *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    
}

@end

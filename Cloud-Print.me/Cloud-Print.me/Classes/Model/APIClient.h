//
//  APIClient.h
//  Couponz
//
//  Created by Vadim Osovets on 10/01/12.
//  Copyright (c) 2012 V&V. All rights reserved.
//

#import "AFHTTPClient.h"

typedef enum StatusCodeError {
    StatusCodeServerError = 1001,
    StatusCodeLogicError = 1002,
    StatusCodeRequestFormatError = 1003,
    StatusCodeInconsistentError
} StatusCodeError;

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

// Token should be store in API client during lifecycle of application

#pragma mark - Login & Logout

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
           withSuccess:(void (^)(NSDictionary *))successBlock
               failure:(void (^)(NSError *))failureBlock;

- (void)logoutWithSuccess:(void (^)(NSDictionary *))successBlock
                  failure:(void (^)(NSError *))failureBlock;

#pragma mark - Functionality

- (void)userProfileWithSuccess:(void (^)(NSDictionary *))successBlock
                       failure:(void (^)(NSError *))failureBlock;

- (void)messagesWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock;

- (void)balanceWithSuccess:(void (^)(NSDictionary *))successBlock
                   failure:(void (^)(NSError *))failureBlock;

- (void)ordersWithSuccess:(void (^)(NSArray *))successBlock
                  failure:(void (^)(NSError *))failureBlock;

#pragma mark - Extra

- (BOOL)isLoggedIn;
- (NSString *)userEmail;

@end

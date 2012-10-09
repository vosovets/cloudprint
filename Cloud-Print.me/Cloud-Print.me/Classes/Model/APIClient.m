//
//  APIClient.m
//  Couponz
//
//  Created by Vadim Osovets on 9/01/12.
//  Copyright (c) 2012 V&V. All rights reserved.
//

#import "APIClient.h"

#import "AFJSONUtilities.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "TestAPIClient.h"

NSString * const kBaseURLString = @"http://www.cat-tie.ru";

static NSString *__sessionToken = nil;

@implementation APIClient

+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
//        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
// ONLY for testing purposes
        
        _sharedClient = [[TestAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];

    });

    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - Login & Logout

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
           withSuccess:(void (^)(NSDictionary *))successBlock
               failure:(void (^)(NSError *))failureBlock {
    
}

- (void)logoutWithSuccess:(void (^)(NSDictionary *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    
}

#pragma mark - Functionality

- (void)userProfileWithSuccess:(void (^)(NSDictionary *))successBlock
                       failure:(void (^)(NSError *))failureBlock {
    
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

#pragma mark - Template

- (void)sendToPath:(NSString *)path
          userData:(NSDictionary *)userData
           success:(void (^)(id))successBlock
           failure:(void (^)(NSError *))failureBlock
             check:(BOOL (^)(id))checkBlock {
    
    // define error
    __block NSError *error = nil;
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:userData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //    Debug(@"Finish with: %@, %d, %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding], [[operation response] statusCode], [[operation request] URL]);
            
        id obj = AFJSONDecode(responseObject, &error);
            
        Debug(@"\n\nRequest1: %@, %@", path, userData);
        Debug(@"\n\nRequest2: %@", request);
        Debug(@"Result: %@, %@", obj, responseObject);
            
        // pre-check
        if (checkBlock && !checkBlock(obj)) {
            NSError *anError = [[NSError alloc] initWithDomain:[obj valueForKey:@"ExceptionText"]
                                                          code:StatusCodeInconsistentError
                                                      userInfo:obj];
            failureBlock(anError);
            return;
        }
            
        successBlock(obj);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Debug(@"\n\nRequest: %@, %@", path, userData);
        Debug(@"ERROR: %@, %@", [error description], [error userInfo]);
        
        NSString *domain = error.domain;
        
        if ([domain isEqualToString:@"com.alamofire.networking.error"]) {
            domain = @"Internal server error";
        }
        
        NSError *anError = [[NSError alloc] initWithDomain:domain
                                                      code:StatusCodeServerError
                                                  userInfo:error.userInfo];
        
        failureBlock(anError);
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
    }];

    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark - Extra

- (BOOL)isLoggedIn {
    return __sessionToken ? YES : NO;
}

@end

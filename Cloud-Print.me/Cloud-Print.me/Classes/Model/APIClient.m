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

NSString * const kBaseURLString = @"http://cloud-print.me";

static NSString *__sessionToken = nil;
static NSString *__userEmail = nil;

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
    __userEmail = email;
    
    __block APIClient *weakSelf = self;
    
     [self sendToPath:@"login.php"
             userData:@{@"email": email, @"password": password}
              success:^(id response) {
                  if (![weakSelf storedCredentials]) {
                      [weakSelf saveCredentials:email password:password];
                  }
                  
                  successBlock(response);
              } failure:failureBlock check:nil];
}

- (void)logoutWithSuccess:(void (^)(NSDictionary *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    __userEmail = nil;
}

#pragma mark - Functionality

- (void)userProfileWithSuccess:(void (^)(NSDictionary *))successBlock
                       failure:(void (^)(NSError *))failureBlock {
    
    [self sendToPath:@"profile.php"
            userData:nil
             success:successBlock
             failure:failureBlock
               check:nil];
}

- (void)messagesWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock {
    
}

- (void)balanceWithSuccess:(void (^)(NSArray *))successBlock
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
    
    // TODO: add token where it is needed
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:userData];
    
    if (__sessionToken) {
        [params setValue:__sessionToken forKey:@"token"];
    }
    
    // define error
    __block NSError *error = nil;
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"api/%@", path] parameters:params];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //    Debug(@"Finish with: %@, %d, %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding], [[operation response] statusCode], [[operation request] URL]);
            
        id obj = AFJSONDecode(responseObject, &error);
            
        Debug(@"\n\nRequest1: %@, %@", path, userData);
        Debug(@"\n\nRequest2: %@", request);
        Debug(@"Result: %@, %@", obj, responseObject);
        
        // general check
        
        if ([obj[@"status"] isEqualToString:@"err"]) {
            NSError *anError = [[NSError alloc] initWithDomain:obj[@"message"]
                                                          code:StatusCodeLogicError
                                                      userInfo:obj];
            failureBlock(anError);
            return;
        }
            
        // pre-check
        if (checkBlock && !checkBlock(obj)) {
            NSError *anError = [[NSError alloc] initWithDomain:[obj valueForKey:@"ExceptionText"]
                                                          code:StatusCodeInconsistentError
                                                      userInfo:obj];
            failureBlock(anError);
            return;
        }
        
        // save token for next request
        __sessionToken = (obj[@"token"] && ![obj[@"token"] isEqualToString:@""]) ? obj[@"token"] : nil;
            
        successBlock(obj[@"response"]);
        
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

- (NSString *)userEmail {
    return __userEmail;
}

#pragma mark - Credentials

- (NSDictionary *)storedCredentials {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userCredentials"];
}

- (void)saveCredentials:(NSString *)email password:(NSString *)password {
    NSUserDefaults *userDefs = [NSUserDefaults standardUserDefaults];
    
    [userDefs setObject:@{@"email": email, @"password": password} forKey:@"userCredentials"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [userDefs synchronize];
    });
}

- (void)cleanCredentials {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userCredentials"];
}

@end

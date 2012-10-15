//
//  TestAPIClient.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 09.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "TestAPIClient.h"

static NSString *__userEmail = nil;

@implementation TestAPIClient

#pragma mark - Login & Logout

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
           withSuccess:(void (^)(NSDictionary *))successBlock
               failure:(void (^)(NSError *))failureBlock {
    __userEmail = email;
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(@{@"token": @"1421423-31432423-324324-13243241"});
    });
}

- (void)logoutWithSuccess:(void (^)(NSDictionary *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(@{});
    });
}

#pragma mark - Functionality

- (void)userProfileWithSuccess:(void (^)(NSDictionary *))successBlock
                       failure:(void (^)(NSError *))failureBlock {
    
    NSDictionary *response = @{@"userInfo":
    @[@{@"Имя": @"Tatyana, Omnia"},
    @{@"Телефон": @" +380675758599"},
    @{@"Мобильный телефон": @"+38-067-575-85-99"},
    @{@"E-mail": @"frp.omnia@gmail.com"},
    @{@"Страна": @"Украина"},
    @{@"Регион": @"Харьковская обл."},
    @{@"Город": @"Харьков"},
    @{@"Адрес": @""},
    @{@"Адрес доставки": @""},
    @{@"Служба доставки": @""},
    @{@"Адрес склада доставки, номер склада": @""},
    @{@"Получатель": @""}]};
    
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(response);
    });
}

- (void)messagesWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock {
    
    NSArray *response = @[
    @{@"description": @"Уведомление о посылке", @"date": @"05.10.2012 09:35"},
    @{@"description": @"Выставление счетов для оплаты по безналичному расчету ", @"date": @"02.10.2012 11:42"},
    @{@"description": @"Бонус 1% по программе лояльности CloudPRINT Club ", @"date": @"	01.10.2012 07:32"}];
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(response);
    });
}

- (void)balanceWithSuccess:(void (^)(NSArray *))successBlock
                   failure:(void (^)(NSError *))failureBlock {
    NSArray *response = @[
    @{@"title": @"Корректировка баланса", @"date": @"05.10.2012 09:35", @"balance":@"-5000 грн.", @"comment": @"Отправка посылки"},
    @{@"title": @"Покупка посылки", @"date": @"05.10.2012 10:35", @"balance":@"5000 грн.", @"comment": @"Посылка"}];
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(response);
    });
}

- (void)ordersWithSuccess:(void (^)(NSArray *))successBlock
                  failure:(void (^)(NSError *))failureBlock {
    NSArray *response = @[
    @{@"orderId": @"Заказ №2200", @"date": @"05.10.2012 09:35", @"money":@"500 грн.", @"files": @"File 1, File 2, File 3",
    @"orderStatus": @"", @"mockupStatus": @"", @"deliveryStatus": @"", @"notes": @""},
    @{@"orderId": @"Заказ №2201", @"date": @"05.09.2012 09:35", @"money":@"100 грн.", @"files": @"File 1, File 2, File 3",
    @"orderStatus": @"", @"mockupStatus": @"", @"deliveryStatus": @"", @"notes": @""},
    @{@"orderId": @"Заказ №2202", @"date": @"05.08.2012 09:35", @"money":@"300 грн.", @"files": @"File 1, File 2, File 3",
    @"orderStatus": @"", @"mockupStatus": @"", @"deliveryStatus": @"", @"notes": @""}];
    
    CGFloat delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        successBlock(response);
    });

}

- (BOOL)isLoggedIn {

    return __userEmail ? YES : NO;
}

- (NSString *)userEmail {
    return __userEmail;
}

@end

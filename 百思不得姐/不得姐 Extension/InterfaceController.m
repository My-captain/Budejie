//
//  InterfaceController.m
//  不得姐 Extension
//
//  Created by Mr.Robot on 2017/10/20.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "InterfaceController.h"
#import "AFNetworking.h"

@interface InterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    /*
     
     NSObject *handsomeMan= [[NSObject alloc] init];
     rouGeGe.husband = handsomeMan;
     handsomeMan.GGLength = 80cm;
     handsomeMan.name = Mr.Robot;
     
     */
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
    }];
    
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

@end




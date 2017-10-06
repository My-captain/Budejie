//
//  MRRecommendCategory.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendCategory.h"
#import <MJExtension.h>

@implementation MRRecommendCategory
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)recommendUsers{
    if (!_recommendUsers) {
        _recommendUsers = [NSMutableArray array];
    }
    return _recommendUsers;
}

@end

//
//  MRRecommendCategory.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//  推荐关注左边的数据模型

#import <Foundation/Foundation.h>

@interface MRRecommendCategory : NSObject

//id
@property (nonatomic, assign) NSInteger ID;
//总数
@property (nonatomic, assign) NSInteger count;
//名字
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray *recommendUsers;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;

@end

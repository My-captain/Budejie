//
//  MRRecommendUser.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/3.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRecommendUser : NSObject
//头像
@property (nonatomic, copy) NSString *header;
//粉丝数
@property (nonatomic, assign) NSInteger fans_count;
//昵称
@property (nonatomic, copy) NSString *screen_name;

@end

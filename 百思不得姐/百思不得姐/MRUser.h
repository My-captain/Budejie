//
//  MRUser.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/7.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRUser : NSObject
/* 用户名 */
@property (nonatomic, copy) NSString *username;
/* 性别 */
@property (nonatomic, copy) NSString *sex;
/* 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end

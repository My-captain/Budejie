//
//  NSDate+MRExtension.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/27.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MRExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from;
//是否为今年
- (BOOL)isThisYear;
//是否为今年
- (BOOL)isToday;
//是否为今年
- (BOOL)isYesterday;
@end

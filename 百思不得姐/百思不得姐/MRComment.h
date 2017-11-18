//
//  MRComment.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/7.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MRUser;
@interface MRComment : NSObject
@property (nonatomic, copy) NSString *ID;
/* 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/* 音频文件路径 */
@property (nonatomic, copy) NSString *voiceuri;
/* 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/* 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/* 用户 */
@property (nonatomic, strong) MRUser *user;
@end

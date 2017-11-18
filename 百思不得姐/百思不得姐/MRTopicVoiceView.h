//
//  MRTopicVoiceView.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/6.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRTopic;

@interface MRTopicVoiceView : UIView
+ (instancetype)voiceView;
/* 帖子数据 */
@property (nonatomic, strong) MRTopic *topic;
@end

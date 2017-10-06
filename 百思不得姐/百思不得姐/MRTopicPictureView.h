//
//  MRTopicPictureView.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRTopic;
@interface MRTopicPictureView : UIView
+ (instancetype)pictureView;
/* 帖子模型 */
@property (nonatomic, strong) MRTopic *topic;
@end

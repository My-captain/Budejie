//
//  MRTopicVoiceView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/6.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopicVoiceView.h"
#import "MRTopic.h"
#import "MRShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface MRTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *voiceLength;

@end

@implementation MRTopicVoiceView
+ (instancetype)voiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture{
    MRShowPictureViewController *showPicture = [[MRShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(MRTopic *)topic{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playCount.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    //播放时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceLength.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end













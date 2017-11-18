//
//  MRTopicVideoView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/7.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopicVideoView.h"
#import "MRTopic.h"
#import "MRShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface MRTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@end
@implementation MRTopicVideoView

+ (instancetype)videoView{
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
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end

//
//  MRTopicPictureView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopicPictureView.h"
#import "MRTopic.h"
#import "MRShowPictureViewController.h"
#import "MRProgressView.h"
#import <UIImageView+WebCache.h>

@interface MRTopicPictureView()
/* 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/* gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/* 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/* 进度条控件 */
@property (weak, nonatomic) IBOutlet MRProgressView *progressView;


@end

@implementation MRTopicPictureView

+ (instancetype)pictureView{
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
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
        
        [self.imageView setNeedsDisplay];
    }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //调整大图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
    } else {
        self.seeBigButton.hidden = YES;
    }
    
}

@end












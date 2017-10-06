//
//  MRShowPictureViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/2.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRShowPictureViewController.h"
#import "MRTopic.h"
#import "MRProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface MRShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MRProgressView *progressView;
@end

@implementation MRShowPictureViewController

- (void)viewDidLoad {
    
    // 获得屏幕尺寸
    CGFloat screenH = MRScreenH;
    CGFloat screenW = MRScreenW;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [self.scrollView addSubview:imageView];
    
    // 设置显示图片尺寸
    CGFloat pictureW = MRScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > MRScreenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *url) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.imageView = imageView;
    
    [super viewDidLoad];
}

- (IBAction)back:(id)sender{
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载完毕"];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
// 保存成功的回调函数
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showSuccessWithStatus:error.localizedFailureReason];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"已保存到相册"];
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

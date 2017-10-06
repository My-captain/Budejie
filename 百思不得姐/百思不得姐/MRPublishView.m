//
//  MRPublishView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/4.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRPublishView.h"
#import "MRVerticalButton.h"
#import <POP.h>


// Animation动画间隔
static CGFloat const MRAnimationDelay = 0.08;
static CGFloat const MRAnimationSpringBounciness = 14;
static CGFloat const MRAnimationSpringSpeed = 8;

@interface MRPublishView ()
@end

@implementation MRPublishView

+ (instancetype)publishView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

static UIWindow *window_;
+ (void)show{
    // 创建窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    MRPublishView *publishView = [MRPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /*
    // 增加背景毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, MRScreenW, MRScreenH);
    [self addSubview:effectview];
    */
    
    self.userInteractionEnabled = NO;
    
    // 中间的6个控件
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonMarginY = 20;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (MRScreenH - 2 * buttonH - buttonMarginY) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (MRScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < 6; i++) {
        MRVerticalButton *button = [[MRVerticalButton alloc] init];
        [self addSubview:button];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X \ Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + ((row == 0)?0:row*buttonH+buttonMarginY);
        CGFloat buttonBeginY = buttonEndY - MRScreenH;
        
        // 添加动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        animation.springBounciness = MRAnimationSpringBounciness;
        animation.springSpeed = MRAnimationSpringSpeed;
        animation.beginTime = CACurrentMediaTime() + MRAnimationDelay * i;//设置按钮错开时间
        [button pop_addAnimation:animation forKey:nil];
    }
    // 添加标语
    CGFloat centerEndY = MRScreenH * 0.2;
    CGFloat centerX = MRScreenW * 0.5;
    CGFloat centerBeginY = centerEndY - MRScreenH;
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.centerY = centerBeginY;
    [self addSubview:sloganView];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    animation.beginTime = CACurrentMediaTime() + images.count * MRAnimationDelay;
    animation.springBounciness = MRAnimationSpringBounciness;
    animation.springSpeed = MRAnimationSpringSpeed;
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished){
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:animation forKey:nil];
}

- (void)buttonClick:(UIButton *)button{
    [self cancelWithCompletionBlock:^(){
        if (button.tag == 0) {
            MRLog(@"发视频");
        }
    }];
}

- (IBAction)cancel:(id)sender {
    [self cancelWithCompletionBlock:nil];
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock{
    self.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + MRScreenH;
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + (i - beginIndex) * MRAnimationDelay;
        [subview pop_addAnimation:animation forKey:nil];
        if (i == self.subviews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                window_ = nil;
                !completionBlock ? : completionBlock();
            }];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletionBlock:nil];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end

//
//  MRTabBar.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/10.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTabBar.h"
#import "MRPublishView.h"

@interface MRTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation MRTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //更换TabBar背景图
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //设置发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick{
    [MRPublishView show];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //先设置发布按钮的frame
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //再设置其他四个按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        
        //计算frame的X值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}

@end












//
//  UIBarButtonItem+MRExtension.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/27.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "UIBarButtonItem+MRExtension.h"

@implementation UIBarButtonItem (MRExtension)

+ (instancetype)itemWithImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end

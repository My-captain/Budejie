//
//  MRTopWindow.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/18.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopWindow.h"

@implementation MRTopWindow

static UIWindow *window_;

+ (void)initialize{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, MRScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superView {
    for (UIScrollView *subview in superView.subviews) {
        
        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];
        CGRect winBounds = [UIApplication sharedApplication].keyWindow.bounds;
        
        BOOL isShowOnWindow = subview.window == [UIApplication sharedApplication].keyWindow && !subview.isHidden && subview.alpha > 0.01 && CGRectIntersectsRect(newFrame, winBounds);
        
        if ([subview isKindOfClass:[UIScrollView class]] && isShowOnWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

+ (void)show {
    window_.hidden = NO;
}
@end

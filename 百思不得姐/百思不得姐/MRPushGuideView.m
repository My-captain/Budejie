//
//  MRPushGuideView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/24.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRPushGuideView.h"

@implementation MRPushGuideView

+ (instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show{
    /**
     * 第一次打开这个版本时显示
     */
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //显示窗口
        MRPushGuideView *guideView = [MRPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end

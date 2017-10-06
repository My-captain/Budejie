//
//  UIBarButtonItem+MRExtension.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/27.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MRExtension)

+ (instancetype)itemWithImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end

//
//  MRProgressView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/2.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRProgressView.h"

@implementation MRProgressView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end

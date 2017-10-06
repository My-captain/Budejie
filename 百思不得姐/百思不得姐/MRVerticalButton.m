//
//  MRVerticalButton.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/21.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRVerticalButton.h"


@implementation MRVerticalButton

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
}

@end

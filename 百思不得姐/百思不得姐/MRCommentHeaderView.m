//
//  MRCommentHeaderView.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/12.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRCommentHeaderView.h"
@interface MRCommentHeaderView()
/* 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end
@implementation MRCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"header";
    MRCommentHeaderView *header = [tableView dequeueReusableCellWithIdentifier:ID];
    if (header == nil) {
        header = [[MRCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MRGlobalBg;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = MRRGBColor(67, 67, 67);
        label.width = 200;
        label.x = MRTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = self.title;
}

@end

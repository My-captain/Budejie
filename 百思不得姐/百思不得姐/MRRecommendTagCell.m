//
//  MRRecommendTagCell.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/13.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendTagCell.h"
#import "MRRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface MRRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation MRRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(MRRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number/10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 3;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

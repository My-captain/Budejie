//
//  MRRecommendCategoryCell.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendCategoryCell.h"
#import "MRRecommendCategory.h"

@interface MRRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation MRRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = MRRGBColor(244, 244, 244);
    self.textLabel.textColor = MRRGBColor(78, 78, 78);
}

- (void)setCategory:(MRRecommendCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

//每次选中/取消选中都会调用该方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? MRRGBColor(219, 21, 26) : MRRGBColor(78, 78, 78) ;
}

@end

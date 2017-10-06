//
//  MRRecommendUserCell.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/2.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendUserCell.h"
#import "MRRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface MRRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation MRRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setRecommendUser:(MRRecommendUser *)recommendUser{
    _recommendUser = recommendUser;
    
    self.screenNameLabel.text = recommendUser.screen_name;
    
    NSString *fansCount = nil;
    if (recommendUser.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",recommendUser.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@".1f万人关注",recommendUser.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:recommendUser.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

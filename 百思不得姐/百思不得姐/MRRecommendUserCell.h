//
//  MRRecommendUserCell.h
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/2.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRRecommendUser;

@interface MRRecommendUserCell : UITableViewCell
//用户模型
@property (nonatomic, strong) MRRecommendUser *recommendUser;
@end

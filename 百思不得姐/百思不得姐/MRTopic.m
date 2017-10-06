//
//  MRTopic.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/26.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopic.h"

@interface MRTopic()
@end

@implementation MRTopic
{
@private
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

- (NSString *)create_time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [formatter dateFromString:_create_time];
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *components = [[NSDate date] deltaFrom:create];
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", components.hour];
            } else if (components.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", components.minute];
            } else {
                return @"刚刚";
            }
        } else if (create.isYesterday) {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    } else {
        return _create_time;
    }
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * MRTopicCellMargin - 20, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = MRTopicCellTextY + textH + MRTopicCellMargin;
        
        // 根据段子的类型计算cell的高度
        if (self.type == MRTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            // 判断是否显示'点击查看全图'
            if (pictureH > MRTopicCellPictureMaxH) {
                pictureH = MRTopicCellPictureBreakH;
                //说明这是一个大图
                self.bigPicture = YES;
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = MRTopicCellMargin;
            CGFloat pictureY = MRTopicCellTextY + textH + MRTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + MRTopicCellMargin;
        }
        _cellHeight += MRTopicCellBottomBarH + MRTopicCellMargin;
    }
    return _cellHeight;
}
@end












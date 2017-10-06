//
//  MRTopicCell.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/26.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopicCell.h"
#import "MRTopic.h"
#import "MRTopicPictureView.h"
#import <UIImageView+WebCache.h>

@interface MRTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪大v */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 **/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/* 图片帖子中间的内容 */
@property (nonatomic, weak) MRTopicPictureView *pictureView;

@end

@implementation MRTopicCell

- (MRTopicPictureView *)pictureView{
    if (!_pictureView) {
        MRTopicPictureView *pictureView = [MRTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backgroundView;
}

/**
 * 根据网络加载的topic对cell进行设置
 */
- (void)setTopic:(MRTopic *)topic{
    //cell内部本身存储了topic模型,每个cell用一个topic模型
    _topic = topic;
    
    self.sinaVView.hidden = !topic.isSina_v;
    
    //设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    
    //设置时间
    self.createTimeLabel.text = topic.create_time;
    
    //设置按钮文字
    [self setButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //设置帖子文字内容
    self.contentLabel.text = topic.text;
    
    // 根据帖子类型添加对应的内容到cell中间
    if (topic.type == MRTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }
}

// 设置按钮text的文字
- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 0 && count < 1000) {
        placeholder = [NSString stringWithFormat:@" %zd", count];
    } else if(count > 1000) {
        placeholder = [NSString stringWithFormat:@" %.1fk", count / 1000.0];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

// frame:以父view为参考
- (void)setFrame:(CGRect)frame{
    frame.origin.x = MRTopicCellMargin;
    frame.size.width -= 2 * MRTopicCellMargin;
    frame.size.height -= MRTopicCellMargin;
    frame.origin.y += MRTopicCellMargin;
    [super setFrame:frame];
}




@end





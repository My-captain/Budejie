//
//  MRCommentCell.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/12.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRCommentCell.h"
#import "MRComment.h"
#import "MRUser.h"
#import <UIImageView+WebCache.h>

@interface MRCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation MRCommentCell

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)setComment:(MRComment *)comment{
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [UIImage imageNamed:([comment.user.sex isEqualToString:MRUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon")];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if ([self.comment.voiceuri isEqualToString:@""]) {
        self.voiceButton.hidden = YES;
    } else {
        self.voiceButton.hidden = NO;
        self.contentLabel.hidden = YES;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", self.comment.voicetime] forState:UIControlStateNormal];
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", self.comment.voicetime] forState:UIControlStateHighlighted];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = MRTopicCellMargin;
    frame.size.width -= 2 * MRTopicCellMargin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.voiceButton.imageEdgeInsets = (UIEdgeInsets){
        .left = 45
    };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

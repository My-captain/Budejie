
#import <UIKit/UIKit.h>

typedef enum {
    MRTopicTypeAll = 1,
    MRTopicTypePicture = 10,
    MRTopicTypeWord = 29,
    MRTopicTypeVoice = 31,
    MRTopicTypeVideo = 41
}MRTopicType;

UIKIT_EXTERN CGFloat const MRTitlesViewH;
UIKIT_EXTERN CGFloat const MRTitlesViewY;

/* 精华 - cell-间距 */
UIKIT_EXTERN CGFloat const MRTopicCellMargin;
/* 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const MRTopicCellTextY;
/* 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const MRTopicCellBottomBarH;
/* 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const MRTopicCellPictureMaxH;
/* 精华-cell-图片帖子超出最大高度后的强制size */
UIKIT_EXTERN CGFloat const MRTopicCellPictureBreakH;

/* MRUser模型-性别属性值 */
UIKIT_EXTERN NSString * const MRUserSexMale;
UIKIT_EXTERN NSString * const MRUserSexFemale;

// 精华-cell-最热评论 四个字的高度
UIKIT_EXTERN CGFloat const MRTopicCellTopCmtTitleH;








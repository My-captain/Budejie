//
//  MREssenceViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/10.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MREssenceViewController.h"
#import "MRRecommendTagsViewController.h"
#import "MRTopicViewController.h"

@interface MREssenceViewController () <UIScrollViewDelegate>
//标签底部的指示器
@property (nonatomic, weak) UIView *indicatorView;
//当前选中的按钮
@property (nonatomic, weak) UIButton *selectedButton;
//顶部标签栏
@property (nonatomic, weak) UIView *titlesView;
//底部的内容View
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation MREssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //设置内容view的子控制器
    [self setupChildViewControllers];
    //设置顶部标签栏
    [self setupTitlesView];
    //设置内容的View
    [self setupContentView];
}

/**
 * 初始化子控制器
 */
- (void)setupChildViewControllers{
    MRTopicViewController *allVC = [[MRTopicViewController alloc] init];
    allVC.title = @"全部";
    allVC.type = MRTopicTypeAll;
    [self addChildViewController:allVC];
    MRTopicViewController *wordVC = [[MRTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = MRTopicTypeWord;
    [self addChildViewController:wordVC];
    MRTopicViewController *videoVC = [[MRTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = MRTopicTypeVideo;
    [self addChildViewController:videoVC];
    MRTopicViewController *voiceVC = [[MRTopicViewController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = MRTopicTypeVoice;
    [self addChildViewController:voiceVC];
    MRTopicViewController *pictureVC = [[MRTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type = MRTopicTypePicture;
    [self addChildViewController:pictureVC];
}

//设置顶部标签栏
- (void)setupTitlesView{
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = MRTitlesViewH;
    titlesView.y = MRTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //按钮底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    //设置顶部标签栏的时候就设置底部的红色指示器
    self.indicatorView = indicatorView;
    
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedButton.enabled = YES;
        button.enabled = NO;
        self.selectedButton = button;
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

//设置内容View
- (void)setupContentView{
    //关闭自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

//设置导航栏
- (void)setupNav{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //『百思不得姐』左侧的菜单按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(menuClick)];
    
    //设置背景色
    self.view.backgroundColor = MRGlobalBg;
}

- (void) menuClick{
    MRRecommendTagsViewController *tagsViewController = [[MRRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UIViewController *viewController = self.childViewControllers[index];
    viewController.view.x = scrollView.contentOffset.x;
#warning 秘制bug
    viewController.view.y = -1;
    viewController.view.height = scrollView.height;
    [scrollView addSubview:viewController.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
@end








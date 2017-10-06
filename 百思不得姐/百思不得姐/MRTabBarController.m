//
//  MRTabBarController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/9.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTabBarController.h"
#import "MRMeViewController.h"
#import "MREssenceViewController.h"
#import "MRfriendTrendsViewController.h"
#import "MRNewViewController.h"
#import "MRTabBar.h"
#import "MRNavigationController.h"

@interface MRTabBarController ()


@end

@implementation MRTabBarController

+ (void)initialize{
    //通过appearance统一设置tabBar的文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addChildFooterViewController:[[MREssenceViewController alloc] init] withTitle:@"精华" withImage:@"tabBar_essence_icon" withClickImage:@"tabBar_essence_click_icon"];
    [self addChildFooterViewController:[[MRNewViewController alloc] init] withTitle:@"新帖" withImage:@"tabBar_new_icon" withClickImage:@"tabBar_new_click_icon"];
    [self addChildFooterViewController:[[MRfriendTrendsViewController alloc] init] withTitle:@"关注" withImage:@"tabBar_friendTrends_icon" withClickImage:@"tabBar_friendTrends_click_icon"];
    [self addChildFooterViewController:[[MRMeViewController alloc] init] withTitle:@"我" withImage:@"tabBar_me_icon" withClickImage:@"tabBar_me_click_icon"];
    
    //更换TabBar
    [self setValue:[[MRTabBar alloc] init] forKeyPath:@"tabBar"];
    
}

//添加子控制器方法
- (void)addChildFooterViewController:(UIViewController *)footerTabBarController withTitle:(NSString *)title withImage:(NSString *)imageName withClickImage:(NSString *)clickImageName
{
    footerTabBarController.navigationItem.title = title;
    footerTabBarController.tabBarItem.title = title;
    footerTabBarController.tabBarItem.image = [UIImage imageNamed:imageName];
    footerTabBarController.tabBarItem.selectedImage = [UIImage imageNamed:clickImageName];
    
    //包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    MRNavigationController *navgation = [[MRNavigationController alloc] initWithRootViewController:footerTabBarController];
    [self addChildViewController:navgation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

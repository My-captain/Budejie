//
//  MRMeViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/10.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRMeViewController.h"

@interface MRMeViewController ()

@end

@implementation MRMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"炒鸡无敌大帅比";
    //导航栏右侧的菜单按钮
    
    UIBarButtonItem *settingButtonItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *nightModeButtonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingButtonItem,
                                                nightModeButtonItem
                                                ];
    //设置背景色
    self.view.backgroundColor = MRGlobalBg;
}

//设置按钮
- (void) settingClick{
    MRLogFunc;
}

//切换为夜间模式
- (void) nightModeClick{
    MRLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

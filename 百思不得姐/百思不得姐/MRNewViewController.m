//
//  MRNewViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/10.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRNewViewController.h"

@interface MRNewViewController ()

@end

@implementation MRNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //『百思不得姐』左侧的菜单按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(menuClick)];
    //设置背景色
    self.view.backgroundColor = MRGlobalBg;
}

- (void) menuClick{
    MRLog(@"%sAll is well!", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

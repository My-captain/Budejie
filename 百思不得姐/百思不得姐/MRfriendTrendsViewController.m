//
//  MRfriendTrendsViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/10.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRfriendTrendsViewController.h"
#import "MRRecommendViewController.h"
#import "MRLoginRegisterViewController.h"

@interface MRfriendTrendsViewController ()

@end

@implementation MRfriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    //导航栏左侧的菜单按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    //设置背景色
    self.view.backgroundColor = MRGlobalBg;
}

- (void) friendsClick{
    MRRecommendViewController *recommendViewController = [[MRRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginRegister:(id)sender {
    
    MRLoginRegisterViewController *loginRegister = [[MRLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
    
}


@end

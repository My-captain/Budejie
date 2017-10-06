//
//  MRNavigationController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/29.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRNavigationController.h"

@interface MRNavigationController ()

@end

@implementation MRNavigationController

+ (void)initialize{

    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
//        //第一种设置按钮内容左对齐
//        button.size = CGSizeMake(70, 30);
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //第二种设置按钮内容左对齐
        [button sizeToFit];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backToLastController) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backToLastController{
    [self popViewControllerAnimated:YES];
}



@end









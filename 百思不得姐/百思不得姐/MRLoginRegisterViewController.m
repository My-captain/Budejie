//
//  MRLoginRegisterViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/21.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRLoginRegisterViewController.h"

@interface MRLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation MRLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        [self.registerButton setTitle:@"已有账号?" forState: UIControlStateNormal];
    } else {
        self.loginViewLeftMargin.constant = 0;
        [self.registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//控制当前状态栏为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

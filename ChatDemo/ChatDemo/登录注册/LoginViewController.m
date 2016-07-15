//
//  LoginViewController.m
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import "LoginViewController.h"
#import "EMClient.h"
#import "HomeViewController.h"
@interface LoginViewController ()<EMClientDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWdTF;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerkeyboardAction:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMError *error = [[EMClient sharedClient] registerWithUsername:_userNameTF.text password:_passWdTF.text];
        if (error==nil) {
            NSLog(@"注册成功");
        }
    });
    
    
    
}

- (IBAction)loginAction:(id)sender {
    
//    已经让程序自动登录 则不需要再次登录
    if([EMClient sharedClient].options.isAutoLogin)
    {
        return;
    }
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:_userNameTF.text password:_passWdTF.text];
    if (!error) {
        NSLog(@"登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        HomeViewController *vc = [HomeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (IBAction)registerkeyboardAction:(id)sender
{
    
    [self.userNameTF resignFirstResponder];
    [self.passWdTF resignFirstResponder];
}


- (void)didAutoLoginWithError:(EMError *)aError
{
    if (aError == nil) {
//        自动登录成功
        HomeViewController *vc = [HomeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end

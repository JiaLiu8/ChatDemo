//
//  HomeViewController.m
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import "HomeViewController.h"
#import "SingleChatViewController.h"
@interface HomeViewController ()
@property (nonatomic, strong) UIButton *singleChat;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
#pragma mark - 配置界面
-(void)configUI
{
    [self.view addSubview:self.singleChat];
}
#pragma mark - getter
-(UIButton*)singleChat
{
    if (!_singleChat) {
        _singleChat = [UIButton buttonWithType:UIButtonTypeCustom];
        [_singleChat setTitle:@"单聊" forState:UIControlStateNormal];
        _singleChat.frame = CGRectMake(100, 100, 100, 30);
        [_singleChat addTarget:self action:@selector(singleChatAction:) forControlEvents:UIControlEventTouchUpInside];
        _singleChat.backgroundColor = [UIColor greenColor];
    }
    return _singleChat;
}

-(void)singleChatAction:(id)sender
{
    SingleChatViewController *vc = [SingleChatViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

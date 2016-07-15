//
//  SingleChatViewController.m
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import "SingleChatViewController.h"
#import "EMClient.h"
#import "LJCommentView.h"
@interface SingleChatViewController ()<UITableViewDelegate,UITableViewDataSource,LJCommentViewDelegate>
@property (strong, nonatomic) UITableView *tb;
@property (strong, nonatomic) LJCommentView *commentView;
@end

@implementation SingleChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self createChat];
}
#pragma mark - 配置界面
-(void)configView
{
    [self.view addSubview:self.tb];
    [self.view addSubview:self.commentView];
}
#pragma mark - 创建聊天
-(void)createChat
{
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"8001" type:EMConversationTypeChat createIfNotExist:YES];
}
#pragma mark - tableview 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    return cell;
}
#pragma mark - LJCommentView代理
-(void)sendAction:(id)sender
{
    
}
-(void)keyboardWillShow:(BOOL)isShow
{
    if (isShow)//显示键盘
    {
        CGRect frame = self.commentView.frame;
        frame.origin.y = Screen_Height-[LJCommentView getKeyBoardHeight]-46;
        self.commentView.frame = frame;
    }
    else      //隐藏键盘
    {
        CGRect frame = self.commentView.frame;
        frame.size.height = 46;
        frame.origin.y = Screen_Height-46;
        self.commentView.frame = frame;
    }
}
#pragma mark - getter
-(UITableView*)tb
{
    if (!_tb) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-46-64) style:UITableViewStylePlain];
        _tb.delegate = self;
        _tb.dataSource = self;
    }
    return _tb;
}
-(LJCommentView*)commentView
{
    if (!_commentView) {
        _commentView = [[LJCommentView alloc] init];
        _commentView.delegate = self;
    }
    return _commentView;
}
@end

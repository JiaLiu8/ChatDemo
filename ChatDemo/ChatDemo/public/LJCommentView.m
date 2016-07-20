//
//  LJCommentView.m
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import "LJCommentView.h"
#define ContainerViewHeight 46
@interface LJCommentView()<UITextViewDelegate>
{
    CGFloat maxHeight;
    
}
@property (strong, nonatomic) UITextView *tv;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@end
static CGFloat keyBoardHeight;
@implementation LJCommentView
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configView];
        [self addObserver];
    }
    return self;
}
#pragma mark - 监听通知
-(void)addObserver
{
//    will SHow
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardIsShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardIsShow:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.tv addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark - 私有方法
-(void)keyBoardIsShow:(id)object
{
    keyBoardHeight = [[[object userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if ([[object name] isEqualToString:@"UIKeyboardWillHideNotification"])      //hidden
    {
        [self.maskView removeFromSuperview];
        if ([_delegate respondsToSelector:@selector(keyboardWillShow:)])
        {
            [_delegate keyboardWillShow:NO];
        }
    }
    else //show
    {
        [self.superview insertSubview:self.maskView belowSubview:self];
        if ([_delegate respondsToSelector:@selector(keyboardWillShow:)])
        {
            [_delegate keyboardWillShow:YES];
        }
    }
}
-(void)hiddenKeyBoard
{
    [self textFieldBeActive:NO];
}
#pragma mark - 公共方法
-(void)textFieldBeActive:(BOOL)isActive
{
    if (isActive)
    {
        [self.tv becomeFirstResponder];
    }
    else
    {
        [self.tv resignFirstResponder];
    }
}
+(CGFloat)getKeyBoardHeight
{
    return keyBoardHeight;
}
#pragma mark - 配置界面
-(void)configView
{
    maxHeight = 40;
    self.frame = CGRectMake(0, Screen_Height-ContainerViewHeight, Screen_Width, ContainerViewHeight);
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.btn];
    [self.containerView addSubview:self.tv];
    self.containerView.backgroundColor = [UIColor redColor];
}
#pragma mark - 按钮操作
-(void)btnClick:(id)sender
{
    if ([_delegate respondsToSelector:@selector(sendAction:)]) {
        [_delegate sendAction:sender];
    }
}
#pragma mark - kvo监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y-((self.tv.frame.size.height+10)-frame.size.height);
        frame.size.height = self.tv.frame.size.height+10;
        self.frame = frame;
        self.containerView.frame = self.bounds;
    }
}
#pragma mark - uitextView代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}



- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = ceilf([self.tv sizeThatFits:self.tv.frame.size].height);
    if (((height>self.tv.frame.size.height) && (height<=maxHeight))||(height<self.tv.frame.size.height))
    {
        CGRect frame = self.tv.frame;
        frame.size.height = height<36?36:height;
        [UIView animateWithDuration:0.1 animations:^{
            self.tv.frame = frame;
        }];
    }
    if(height<maxHeight)
    {
        self.tv.scrollEnabled = NO;
    }
    else
    {
        self.tv.scrollEnabled = YES;
    }
}

#pragma mark - setter
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
}
-(void)setTextViewFont:(CGFloat)textViewFont
{
    _textViewFont = textViewFont;
//    根据字体算出最大高度
    self.tv.font = [UIFont systemFontOfSize:textViewFont];
    self.tv.text = @"x \n s \n sda";
    maxHeight = ceilf([self.tv sizeThatFits:CGSizeMake(self.tv.frame.size.width, MAXFLOAT)].height);
    self.tv.text = @"";
    
}
#pragma mark - getter
-(UITextView*)tv
{
    if (!_tv) {
        _tv = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-30-50, ContainerViewHeight-10)];
        _tv.delegate = self;
        self.textViewFont = 15.0f;
        _tv.layer.borderColor = [UIColor redColor].CGColor;
        _tv.layer.borderWidth = 0.5;
    }
    return _tv;
}

-(UIView*)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ContainerViewHeight)];
    }
    return _containerView;
}

-(UIButton*)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.frame = CGRectMake(CGRectGetMaxX(self.tv.frame)+10, 5, 50, ContainerViewHeight-10);
        [_btn setTitle:@"发送" forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 5;
        _btn.layer.borderColor = [UIColor greenColor].CGColor;
        _btn.layer.borderWidth = 1;
    }
    return _btn;
}
-(UILabel*)placeholderLabel
{
    if (!_placeholderLabel)
    {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.tv.frame.size.height/2.0+10, 200, 20)];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.text = @"";
    }
    return _placeholderLabel;
}

-(UIView*)maskView
{
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.02];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
        [_maskView addGestureRecognizer:tap];
    
    }
    return _maskView;
}

-(NSString*)textViewText
{
    return self.tv.text;
}

#pragma mark - 销毁
-(void)dealloc
{
    NSLog(@"%s",__func__);
    [self.tv removeObserver:self forKeyPath:@"frame"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

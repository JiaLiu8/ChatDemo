//
//  LJCommentView.h
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LJCommentViewDelegate<NSObject>
@optional
-(void)sendAction:(id)sender;
-(void)keyboardWillShow:(BOOL)isShow;
@end
@interface LJCommentView : UIView
@property (assign, nonatomic) id<LJCommentViewDelegate>delegate;
@property (copy, nonatomic) NSString *placeholder;    //默认文字
@property (assign, nonatomic) CGFloat textViewFont;

-(void)textFieldBeActive:(BOOL)isActive;

@end

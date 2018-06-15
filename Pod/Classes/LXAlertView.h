//
//  LXAlertView.h
//  LXAlertView
//
//  Created by zlx on 2018/3/28.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 使用方法：
 LXAlertView *alertView = [LXAlertView lxAlertViewWithTitle:[@"提示" fontSize:15.3 color:DMainTextColor] message:[@"您输入的推荐码不存在，是否继续注册" fontSize:15.3 color:DMainTextColor] preferredStyle:LXAlertViewStyleAlert];
 [alertView addAction:[@"重新填写" fontSize:15.3 color:DMainTextColor]];
 [alertView addAction:[@"继续注册" fontSize:15.3 color:DThemeColor]];
 alertView.actionsblock = ^(NSInteger index) {
 NSLog(@"%li",(long)index);
 };
 [self presentViewController:alertView animated:NO completion:nil];
 */

typedef NS_ENUM(NSInteger, LXAlertViewStyle){
    LXAlertViewStyleAlert,
    LXAlertViewStyleActionSheet
};
//block
typedef void(^LXAlertViewBlock)(NSInteger index);

@interface LXAlertView : UIViewController
/**
 init
 */
+ (id)lxAlertViewWithTitle:(NSAttributedString *)title message:(NSAttributedString *)message preferredStyle:(LXAlertViewStyle)preferredStyle;
//add action
- (void)addAction:(NSAttributedString *)action;
//action block
@property(nonatomic, copy) LXAlertViewBlock actionsblock;
//Alert or ActionSheet
@property(nonatomic, assign) LXAlertViewStyle preferredStyle;
//title
@property(nonatomic, strong) NSAttributedString *attributedTitle;
//message
@property(nonatomic, strong) NSAttributedString *attributedMessage;
@end

@interface NSString (LXAlertView)
- (NSAttributedString *)fontSize:(CGFloat)fontSize color:(UIColor *)color;
- (NSAttributedString *)boldFontSize:(CGFloat)fontSize color:(UIColor *)color;
@end

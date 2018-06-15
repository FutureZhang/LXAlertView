//
//  ViewController.m
//  LXAlertView
//
//  Created by 张莉祥 on 2018/6/5.
//  Copyright © 2018年 lx. All rights reserved.
//

#import "ViewController.h"
#import "LXAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LXAlertView *alertView = [LXAlertView lxAlertViewWithTitle:nil message:nil preferredStyle:LXAlertViewStyleActionSheet];
    [alertView addAction:[@"相机" fontSize:16.0 color:[UIColor blueColor]]];
    [alertView addAction:[@"相册" fontSize:16.0 color:[UIColor orangeColor]]];
    [alertView addAction:[@"取消" fontSize:15.0 color:[UIColor redColor]]];
    alertView.actionsblock = ^(NSInteger index) {
        NSLog(@"%li",(long)index);
    };
    [self presentViewController:alertView animated:NO completion:nil];
    
    
//    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"123456" message:@"qwqwqwqwqwqwqw" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [ac addAction:submit];
//    [ac addAction:cancel];
//
//    [self presentViewController:ac animated:YES completion:nil];
    
}

@end

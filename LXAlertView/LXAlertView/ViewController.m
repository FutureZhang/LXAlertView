//
//  ViewController.m
//  LXAlertView
//
//  Created by 张莉祥 on 2018/6/5.
//  Copyright © 2018年 lx. All rights reserved.
//

#import "ViewController.h"
#import "LXAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LXAlertController *alertView = [LXAlertController LXAlertViewWithTitle:nil message:nil preferredStyle:LXAlertControllerStyleActionSheet];
    LXAlertAction *action = [LXAlertAction actionWithTitle:[@"取消" fontSize:16.0 color:[UIColor orangeColor]] style:LXAlertActionStyleDefault handler:^(LXAlertAction *action) {
        NSLog(@"%@",action.Title);
    }];
    [alertView addAction:action];
    LXAlertAction *action2 = [LXAlertAction actionWithTitle:[@"确定" fontSize:16.0 color:[UIColor brownColor]] style:LXAlertActionStyleDefault handler:^(LXAlertAction *action) {
        NSLog(@"%@",action.Title);
    }];
    [alertView addAction:action2];
    LXAlertAction *action3 = [LXAlertAction actionWithTitle:[@"其他" fontSize:16.0 color:[UIColor brownColor]] style:LXAlertActionStyleDefault handler:^(LXAlertAction *action) {
        NSLog(@"%@",action.Title);
    }];
    [alertView addAction:action3];

    [self presentViewController:alertView animated:NO completion:nil];
}

@end

//
//  LXAlertController.h
//  LXAlertController
//
//  Created by zlx on 2018/3/1.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXAlertAction;

typedef NS_ENUM(NSInteger, LXAlertActionStyle){
    LXAlertActionStyleDefault,
    LXAlertActionStyleCancel
};

typedef NS_ENUM(NSInteger, LXAlertControllerStyle){
    LXAlertControllerStyleAlert,
    LXAlertControllerStyleActionSheet
};

typedef void(^LXActionHandler)(LXAlertAction *action);

#pragma mark --------------- LXAlertAction ---------------

@interface LXAlertAction : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
@property(nonatomic, strong) NSAttributedString *Title;
@property(nonatomic, assign) LXAlertActionStyle style;
@property(nonatomic,   copy) LXActionHandler handler;
+ (instancetype)actionWithTitle:(NSAttributedString *)title style:(LXAlertActionStyle)style handler:(LXActionHandler)handler;
@end

#pragma mark --------------- LXAlertController ---------------

@interface LXAlertController : UIViewController
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)LXAlertViewWithTitle:(NSAttributedString *)title message:(NSAttributedString *)message preferredStyle:(LXAlertControllerStyle)preferredStyle;
@property(nonatomic, strong) NSAttributedString *Title;
@property(nonatomic, strong) NSAttributedString *message;
@property(nonatomic, assign) LXAlertControllerStyle preferredStyle;
- (void)addAction:(LXAlertAction *)action;
@end

#pragma mark --------------- NSString+LXAlertController ---------------

@interface NSString (LXAlertController)
- (NSAttributedString *)fontSize:(CGFloat)fontSize color:(UIColor *)color;
- (NSAttributedString *)boldFontSize:(CGFloat)fontSize color:(UIColor *)color;
@end

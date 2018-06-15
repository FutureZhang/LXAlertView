//
//  LXAlertViewCell.h
//  LXAlertView
//
//  Created by zlx on 2018/3/28.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark---------------LXAlertViewTitleCell---------------
@interface LXAlertViewTitleCell : UICollectionViewCell
//标题
@property (strong, nonatomic) UILabel *titleLabel;
//标题点击按钮（未来可能使用）
@property (strong, nonatomic) UIButton *titleAction;
/**cell的标识*/
+ (NSString *)getCellId;
@end

#pragma mark---------------LXAlertViewMessageCell---------------
@interface LXAlertViewMessageCell : UICollectionViewCell
//cell上面的灰色分割线
@property (strong, nonatomic) UILabel *topLine;
//内容
@property (strong, nonatomic) UILabel *messageLabel;
//提示内容点击按钮（未来可能使用）
@property (strong, nonatomic) UIButton *messageAction;
/**cell的标识*/
+ (NSString *)getCellId;
@end

#pragma mark---------------LXAlertViewActionCell---------------
@interface LXAlertViewActionCell : UICollectionViewCell
//cell上面的灰色分割线
@property (strong, nonatomic) UILabel *topLine;
//cell右面的灰色分割线
@property (strong, nonatomic) UILabel *rightLine;
//按钮
@property (strong, nonatomic) UIButton *actionButton;
/**cell的标识*/
+ (NSString *)getCellId;
@end


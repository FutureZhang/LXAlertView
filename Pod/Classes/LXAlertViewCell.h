//
//  LXAlertViewCell.h
//  LXAlertController
//
//  Created by zlx on 2018/3/1.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark---------------LXAlertViewTitleCell---------------
@interface LXAlertViewTitleCell : UICollectionViewCell
//标题
@property (strong, nonatomic) UILabel *titleLabel;
//button（未来可能使用）
@property (strong, nonatomic) UIButton *button;
/**cell的标识*/
+ (NSString *)getCellId;
@end

#pragma mark---------------LXAlertViewMessageCell---------------
@interface LXAlertViewMessageCell : UICollectionViewCell
//cell上面的灰色分割线
@property (strong, nonatomic) UILabel *topLine;
//内容
@property (strong, nonatomic) UILabel *messageLabel;
//button（未来可能使用）
@property (strong, nonatomic) UIButton *button;
/**cell的标识*/
+ (NSString *)getCellId;
@end

#pragma mark---------------LXAlertViewActionCell---------------
@interface LXAlertViewActionCell : UICollectionViewCell
//cell上面的灰色分割线
@property (strong, nonatomic) UILabel *topLine;
//cell右面的灰色分割线
@property (strong, nonatomic) UILabel *rightLine;
//button
@property (strong, nonatomic) UIButton *actionButton;
/**cell的标识*/
+ (NSString *)getCellId;
@end


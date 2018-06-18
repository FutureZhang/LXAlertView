//
//  LXAlertViewCell.m
//  LXAlertController
//
//  Created by zlx on 2018/3/1.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import "LXAlertViewCell.h"

#define KBlackColor51 [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
#define KGrayLineColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define KGrayBgColor250 [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]

#pragma mark---------------LXAlertViewTitleCell---------------
@implementation LXAlertViewTitleCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);;
        [self addSubview:self.button];
    }
    return self;
}
/**cell的标识*/
+ (NSString *)getCellId{
    return NSStringFromClass(self);
}
@end

#pragma mark---------------LXAlertViewMessageCell---------------
@implementation LXAlertViewMessageCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.messageLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);;
        [self addSubview:self.button];
    }
    return self;
}
/**cell的标识*/
+ (NSString *)getCellId{
    return NSStringFromClass(self);
}
@end

#pragma mark---------------LXAlertViewActionCell---------------
@implementation LXAlertViewActionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = KGrayBgColor250;
        self.selectedBackgroundView = bgView;
        
        CGRect actionLabelFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.actionButton.frame = actionLabelFrame;
        self.actionButton.backgroundColor = [UIColor clearColor];
        [self addSubview:self.actionButton];
        
        self.topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.actionButton.frame.size.width, 0.7)];
        self.topLine.backgroundColor = KGrayLineColor;
        [self addSubview:self.topLine];
        
        self.rightLine = [[UILabel alloc] initWithFrame:CGRectMake(self.actionButton.frame.size.width-0.7, 0, 0.7, self.actionButton.frame.size.height)];
        self.rightLine.backgroundColor = KGrayLineColor;
        [self addSubview:self.rightLine];
    }
    return self;
}
/**cell的标识*/
+ (NSString *)getCellId{
    return NSStringFromClass(self);
}
@end


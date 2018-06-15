//
//  LXAlertViewCell.m
//  LXAlertView
//
//  Created by zlx on 2018/3/28.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import "LXAlertViewCell.h"

static CGFloat const KMargin10 = 10;
static CGFloat const KLine0_7 = 0.7;
#define KSystemFont15 [UIFont systemFontOfSize:15.3]
#define KBlackColor51 [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
#define KGrayLineColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define KGrayBgColor250 [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]

#pragma mark---------------LXAlertViewTitleCell---------------
@implementation LXAlertViewTitleCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGRect labelFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = KSystemFont15;
        self.titleLabel.textColor = KBlackColor51;
        [self addSubview:self.titleLabel];
        
        CGRect titleActionFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.titleAction = [UIButton buttonWithType:UIButtonTypeSystem];
        self.titleAction.frame = titleActionFrame;
        [self addSubview:self.titleAction];
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
        self.topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, KLine0_7)];
        self.topLine.backgroundColor = KGrayLineColor;
        [self addSubview:self.topLine];
        
        CGRect labelFrame = CGRectMake(KMargin10, KLine0_7, frame.size.width-KMargin10*2, frame.size.height - KLine0_7);
        self.messageLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = KSystemFont15;
        self.messageLabel.textColor = KBlackColor51;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.messageLabel];
        
        CGRect messageActionFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.messageAction = [UIButton buttonWithType:UIButtonTypeSystem];
        self.messageAction.frame = messageActionFrame;
        [self addSubview:self.messageAction];
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
        self.actionButton.titleLabel.font = KSystemFont15;
        [self addSubview:self.actionButton];
        
        self.topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.actionButton.frame.size.width, KLine0_7)];
        self.topLine.backgroundColor = KGrayLineColor;
        [self addSubview:self.topLine];
        
        self.rightLine = [[UILabel alloc] initWithFrame:CGRectMake(self.actionButton.frame.size.width-KLine0_7, 0, KLine0_7, self.actionButton.frame.size.height)];
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


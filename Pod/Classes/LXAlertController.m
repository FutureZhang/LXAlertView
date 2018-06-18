//
//  LXAlertController.m
//  LXAlertController
//
//  Created by zlx on 2018/3/1.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import "LXAlertController.h"
#import "LXAlertViewCell.h"

static CGFloat const KMargin12 = 12;
static CGFloat const KMargin20 = 20;
static CGFloat const LXHeight44 = 44;
static CGFloat const LXHeight50 = 50;

static NSInteger const LXCancelActionTag = 99999999;

#define LXSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define LXSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LXGrayBgColor244 [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]

#pragma mark --------------- LXAlertAction ---------------

@implementation LXAlertAction
+ (instancetype)actionWithTitle:(NSAttributedString *)title style:(LXAlertActionStyle)style handler:(LXActionHandler)handler{
    LXAlertAction *action = [[self alloc] init];
    action.Title = title;
    action.style = style;
    action.handler = handler;
    return action;
}
@end

#pragma mark --------------- LXAlertController ---------------

@interface LXAlertController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, assign) CGFloat collectionViewWidth;
@property(nonatomic, assign) CGFloat collectionViewHeight;
@property(nonatomic, assign) CGFloat titleHeight;
@property(nonatomic, assign) CGFloat titleCellHeight;
@property(nonatomic, assign) CGFloat messageHeight;
@property(nonatomic, assign) CGFloat messageCellHeight;
@property(nonatomic, assign) CGFloat actionHeight;
//button数组
@property(nonatomic, strong) NSMutableArray<LXAlertAction *> *actions;
//取消button
@property(nonatomic, strong) LXAlertAction *cancelAction;
@end

@implementation LXAlertController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加从底部弹出动画效果
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _collectionView.transform = CGAffineTransformMakeTranslation(0, _collectionViewHeight/2);
        [UIView animateWithDuration:0.2 animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            self.collectionView.transform = CGAffineTransformMakeTranslation(0, -1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.collectionView.transform = CGAffineTransformMakeTranslation(0, 0);
            }completion:^(BOOL finish){
            }];
        }];
    }else{
        //添加缩放动画效果
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _collectionView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.2 animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            self.collectionView.transform = CGAffineTransformMakeScale(0.999, 0.999);
        }completion:^(BOOL finish){
            [UIView animateWithDuration:0.5 animations:^{
                self.collectionView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }completion:^(BOOL finish){
            }];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_collectionViewHeight == 0) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

/**
 初始化
 */
+ (instancetype)LXAlertViewWithTitle:(NSAttributedString *)title message:(NSAttributedString *)message preferredStyle:(LXAlertControllerStyle)preferredStyle{
    LXAlertController *alertView = [[self alloc] init];
    alertView.Title = title;
    alertView.message = message;
    alertView.preferredStyle = preferredStyle;
    return alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        _actionHeight = _actions.count==0?0:LXHeight50;
        _collectionViewHeight = _actionHeight*_actions.count;
        if (_cancelAction) {
            _collectionViewHeight += (_actionHeight + 8);
        }
         _collectionViewWidth = LXSCREEN_WIDTH;
    }else{
        _actionHeight = _actions.count==0?0:LXHeight44;
        _collectionViewHeight = _actions.count==2?_actionHeight:_actionHeight*_actions.count;
        _collectionViewWidth = ceilf(LXSCREEN_WIDTH*275/375);
    }
    
    _titleHeight = [self calculateAttributedStringHeight:_Title width:(_collectionViewWidth - KMargin12*2)];
    
    _messageHeight = [self calculateAttributedStringHeight:_message width:(_collectionViewWidth - KMargin12*2)];
    
    if (_titleHeight > 0&&_messageHeight == 0) {
        _collectionViewHeight += (_titleHeight + KMargin20*2);
        _titleCellHeight = _titleHeight + KMargin20*2;
    }else if (_messageHeight > 0&&_titleHeight == 0) {
        _collectionViewHeight += (_messageHeight + KMargin20*2);
        _messageCellHeight = _messageHeight + KMargin20*2;
    }else if (_messageHeight > 0&&_titleHeight > 0) {
        _collectionViewHeight += (KMargin20 + _titleHeight + KMargin12 + _messageHeight + KMargin20);
        _titleCellHeight = KMargin20 + _titleHeight;
        _messageCellHeight = KMargin12 + _messageHeight + KMargin20;
    }
    //点击空白处dissMissView
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty)];
        [self.view addGestureRecognizer:tap];
    }
    //init
    [self initCollectionView];
}

/**
 添加LXAlertAction
 */
- (void)addAction:(LXAlertAction *)action{
    if (_actions == nil) {
        _actions = @[].mutableCopy;
    }
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        if (action.style == LXAlertActionStyleCancel&&_cancelAction == nil) {
            _cancelAction = action;
        }else{
            [_actions addObject:action];
        }
    }else{
        [_actions addObject:action];
    }
}

#pragma mark --------------------Event------------------------
/**
 点击空白处
 */
- (void)clickEmpty{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 点击button
 */
- (void)clickActionButton:(UIButton *)sender{
    if (sender.tag == LXCancelActionTag) {
        _cancelAction.handler(_cancelAction);
    }else{
        LXAlertAction *action = _actions[sender.tag];
        action.handler(action);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark --------------------Delegate---------------------
/**
 collectionView section数
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        return 4;
    }else{
        return 3;
    }
}
/**
 collectionView 每个section的item数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _Title.length==0?0:1;
    }
    if (section == 1) {
        return _message.length==0?0:1;
    };
    if (section == 2) {
        return _actions.count;
    }
    return _cancelAction?1:0;
}
/**
 UICollectionView显示的内容
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //标题
    if (indexPath.section == 0) {
        LXAlertViewTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewTitleCell getCellId] forIndexPath:indexPath];
        CGRect titleFrame = CGRectMake(KMargin12, KMargin20, _collectionViewWidth - KMargin12*2, _titleHeight);
        cell.titleLabel.frame = titleFrame;
        cell.titleLabel.attributedText = _Title;
        return cell;
    }
    //内容
    if (indexPath.section == 1) {
        LXAlertViewMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewMessageCell getCellId] forIndexPath:indexPath];
        CGRect messageFrame;
        if (_titleHeight == 0) {
            messageFrame = CGRectMake(KMargin12, KMargin20, _collectionViewWidth - KMargin12*2, _messageHeight);
        }else{
            messageFrame = CGRectMake(KMargin12, KMargin12, _collectionViewWidth - KMargin12*2, _messageHeight);
        }
        cell.messageLabel.frame = messageFrame;
        cell.messageLabel.attributedText = _message;
        return cell;
    }
    //button
    LXAlertViewActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewActionCell getCellId] forIndexPath:indexPath];
    
    if (indexPath.section == 3 && _cancelAction) {
        //取消button
        [cell.actionButton setAttributedTitle:_cancelAction.Title forState:UIControlStateNormal];
        cell.actionButton.tag = LXCancelActionTag;
    }else{
        //普通button
        LXAlertAction *action = _actions[indexPath.item];
        [cell.actionButton setAttributedTitle:action.Title forState:UIControlStateNormal];
        cell.actionButton.tag = indexPath.item;
    }
    [cell.actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark ---------------UICollectionViewDelegateFlowLayout---------------
/**
 collectionView每个item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        if (indexPath.section == 0) {
            return CGSizeMake(_collectionViewWidth, _titleCellHeight);
        }
        if (indexPath.section == 1) {
            return CGSizeMake(_collectionViewWidth, _messageCellHeight);
        }
        return CGSizeMake(_collectionViewWidth, _actionHeight);
        
    }else{
        if (indexPath.section == 0) {
            return CGSizeMake(_collectionViewWidth, _titleCellHeight);
        }
        if (indexPath.section == 1) {
            return CGSizeMake(_collectionViewWidth, _messageCellHeight);
        }
        if (_actions.count == 2) {
            return CGSizeMake(floor(_collectionViewWidth/2), _actionHeight);
        }
        return CGSizeMake(_collectionViewWidth, _actionHeight);
    }
}
/**
 collectionView 每个section上左下右的间距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 3 && _cancelAction) {
        return UIEdgeInsetsMake(8, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --------------------UI---------------------------
/**
 初始化collectionView
 */
-(void)initCollectionView{
    CGRect frame;
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        frame = CGRectMake(0, (LXSCREEN_HEIGHT-_collectionViewHeight), _collectionViewWidth, _collectionViewHeight);
    }else{
        frame = CGRectMake((LXSCREEN_WIDTH-_collectionViewWidth)/2, (LXSCREEN_HEIGHT-_collectionViewHeight)/2-30, _collectionViewWidth, _collectionViewHeight);
    }
    //初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    if (_preferredStyle == LXAlertControllerStyleActionSheet) {
        _collectionView.backgroundColor = [UIColor clearColor];
    }else{
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    if (_preferredStyle == LXAlertControllerStyleAlert) {
        _collectionView.layer.masksToBounds = YES;
        _collectionView.layer.cornerRadius = 8;
    }
    //titlt
    [_collectionView registerClass:[LXAlertViewTitleCell class] forCellWithReuseIdentifier:[LXAlertViewTitleCell getCellId]];
    //message
    [_collectionView registerClass:[LXAlertViewMessageCell class] forCellWithReuseIdentifier:[LXAlertViewMessageCell getCellId]];
    //action
    [_collectionView registerClass:[LXAlertViewActionCell class] forCellWithReuseIdentifier:[LXAlertViewActionCell getCellId]];
}
#pragma mark ----------------Func-------------------------
- (CGFloat)calculateAttributedStringHeight:(NSAttributedString *)string width:(CGFloat)width{
    CGSize textSize = [string.string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[string attributesAtIndex:1 effectiveRange:NULL] context:nil].size;
    CGFloat height = ceil(textSize.height);
    return height;
}
@end

#pragma mark --------------- NSString+LXAlertController ---------------

@implementation NSString (LXAlertController)
- (NSAttributedString *)fontSize:(CGFloat)fontSize color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName: color}];
}
- (NSAttributedString *)boldFontSize:(CGFloat)fontSize color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize],NSForegroundColorAttributeName: color}];
}
@end

//
//  LXAlertView.m
//  LXAlertView
//
//  Created by zlx on 2018/3/28.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import "LXAlertView.h"
#import "LXAlertViewCell.h"

static CGFloat const KHeight5 = 5;
static CGFloat const KHeight44 = 44;
static CGFloat const KHeight50 = 50;
static CGFloat const KHeightMessage = 90;

#define KSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KGrayBgColor244 [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]

@interface LXAlertView ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, assign) CGFloat collectionViewWidth;
@property(nonatomic, assign) CGFloat collectionViewHeight;
@property(nonatomic, assign) CGFloat titleHeight;
@property(nonatomic, assign) CGFloat messageHeight;
@property(nonatomic, assign) CGFloat actionHeight;
//可点击按钮数组
@property(nonatomic, strong) NSMutableArray<NSAttributedString *> *actions;
@end

@implementation LXAlertView

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加从底部弹出动画效果
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.collectionView.transform = CGAffineTransformMakeTranslation(0, self.collectionViewHeight/2);
        [UIView animateWithDuration:0.2 animations:^{
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
        self.collectionView.transform = CGAffineTransformMakeScale(1.2, 1.2);
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
    if (self.collectionViewHeight == 0) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

+ (id)lxAlertViewWithTitle:(NSAttributedString *)title message:(NSAttributedString *)message preferredStyle:(LXAlertViewStyle)preferredStyle{
    LXAlertView *alertView = [[self alloc] init];
    alertView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    alertView.attributedTitle = title;
    alertView.attributedMessage = message;
    alertView.preferredStyle = preferredStyle;
    return alertView;
}

/**
 添加可点击按钮
 */
- (void)addAction:(NSAttributedString *)action{
    if (self.actions == nil) {
        self.actions = @[].mutableCopy;
    }
    [self.actions addObject:action];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        self.actionHeight = KHeight50;
        self.collectionViewWidth = KSCREEN_WIDTH;
        self.collectionViewHeight = self.actionHeight*self.actions.count+KHeight5;
    }else{
        self.titleHeight = self.attributedTitle.length==0?0.1:KHeight44;
        self.messageHeight = self.attributedMessage.length==0?0.1:KHeightMessage;
        self.actionHeight = self.actions.count==0?0.1:KHeight44;
        self.collectionViewWidth = ceilf(KSCREEN_WIDTH*275/375);
        self.collectionViewHeight = self.titleHeight+self.messageHeight+(self.actions.count==2?self.actionHeight:self.actionHeight*self.actions.count);
    }
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    //点击空白处dissMissView
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty)];
    [self.view addGestureRecognizer:tap];
    //init
    [self initCollectionView];
}
#pragma mark --------------------Event------------------------
/**
 点击空白处
 */
- (void)clickEmpty{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 点击按钮
 */
- (void)clickActionButton:(UIButton *)sender{
    if (self.actionsblock) {
        self.actionsblock(sender.tag);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark --------------------Delegate---------------------
/**
 collectionView section数
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        return self.actions.count;
    }else{
        return 3;
    }
}
/**
 collectionView 每个section的item数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        return 1;
    }else{
        if (section == 0) return 1;
        if (section == 1) return 1;
        return self.actions.count;
    }
}
/**
 UICollectionView显示的内容
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //LXAlertViewStyleActionSheet
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        LXAlertViewActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewActionCell getCellId] forIndexPath:indexPath];
        cell.topLine.backgroundColor = [UIColor clearColor];
        cell.rightLine.backgroundColor = [UIColor clearColor];
        cell.actionButton.backgroundColor = KGrayBgColor244;
        [cell.actionButton setAttributedTitle:self.actions[indexPath.section] forState:UIControlStateNormal];
        cell.actionButton.tag = indexPath.section;
        [cell.actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        //LXAlertViewStyleAlert
        //标题
        if (indexPath.section == 0) {
            LXAlertViewTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewTitleCell getCellId] forIndexPath:indexPath];
            cell.titleLabel.attributedText = self.attributedTitle;
            return cell;
        }
        //内容
        if (indexPath.section == 1) {
            LXAlertViewMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewMessageCell getCellId] forIndexPath:indexPath];
            cell.messageLabel.attributedText = self.attributedMessage;
            return cell;
        }
        //按钮
        LXAlertViewActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LXAlertViewActionCell getCellId] forIndexPath:indexPath];
        [cell.actionButton setAttributedTitle:self.actions[indexPath.item] forState:UIControlStateNormal];
        cell.actionButton.tag = indexPath.item;
        [cell.actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
/**
 点击每个item的代理方法
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark ---------------UICollectionViewDelegateFlowLayout---------------
/**
 collectionView每个item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        return CGSizeMake(self.collectionViewWidth,self.actionHeight);
        
    }else{
        if (indexPath.section == 0) {
            return CGSizeMake(self.collectionViewWidth,self.titleHeight);
        }
        if (indexPath.section == 1) {
            return CGSizeMake(self.collectionViewWidth,self.messageHeight);
        }
        if (self.actions.count == 2) {
            return CGSizeMake(floor(self.collectionViewWidth/2),self.actionHeight);
        }
        return CGSizeMake(self.collectionViewWidth,self.actionHeight);
    }
}
/**
 collectionView 每个section上左下右的间距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == self.actions.count - 1) {
        return UIEdgeInsetsMake(KHeight5, 0, 0, 0);
    }
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0.7, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
#pragma mark --------------------UI---------------------------
/**
 初始化collectionView
 */
-(void)initCollectionView{
    CGRect frame;
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        frame = CGRectMake(0, (KSCREEN_HEIGHT-self.collectionViewHeight), self.collectionViewWidth, self.collectionViewHeight);
    }else{
        frame = CGRectMake((KSCREEN_WIDTH-self.collectionViewWidth)/2, (KSCREEN_HEIGHT-self.collectionViewHeight)/2-30, self.collectionViewWidth, self.collectionViewHeight);
    }
    //初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    if (self.preferredStyle == LXAlertViewStyleActionSheet) {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }else{
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    if (self.preferredStyle == LXAlertViewStyleAlert) {
        self.collectionView.layer.masksToBounds = YES;
        self.collectionView.layer.cornerRadius = 8;
    }
    //titlt
    [self.collectionView registerClass:[LXAlertViewTitleCell class] forCellWithReuseIdentifier:[LXAlertViewTitleCell getCellId]];
    //message
    [self.collectionView registerClass:[LXAlertViewMessageCell class] forCellWithReuseIdentifier:[LXAlertViewMessageCell getCellId]];
    //action
    [self.collectionView registerClass:[LXAlertViewActionCell class] forCellWithReuseIdentifier:[LXAlertViewActionCell getCellId]];
}

#pragma mark --------------------Func-------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

@implementation NSString (LXAlertView)
- (NSAttributedString *)fontSize:(CGFloat)fontSize color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName: color}];
}
- (NSAttributedString *)boldFontSize:(CGFloat)fontSize color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize],NSForegroundColorAttributeName: color}];
}
@end

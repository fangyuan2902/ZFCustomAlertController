//
//  ZFCustomAlertController.m
//  ZFCustomAlertController
//
//  Created by mac on 2019/1/30.
//  Copyright © 2019年 k. All rights reserved.
//

#import "ZFCustomAlertController.h"
#import "Masonry.h"

@interface ZFCustomAlertController () <ZFAlertDelegate>

@property(nonatomic ,strong) UILabel * titleLab;
@property(nonatomic ,strong) UILabel * contentLab;
@property(nonatomic ,strong) UIView * backView;
@property(nonatomic ,strong) NSMutableArray * actionArray;

@end

@implementation ZFCustomAlertController

+ (instancetype)alertWithTitle:(NSString *)title andContent:(NSString *)content {
    return [[ZFCustomAlertController alloc] initWithTitle:title andContent:content];
}

- (instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content {
    self = [super init];
    if(self){
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _alertTitle = title;
        _alertContent = content;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if(self){
        self.contentColor = [UIColor blackColor];
        self.titleColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *backImageView = [[UIView alloc] init];
    backImageView.backgroundColor = [UIColor blackColor];
    backImageView.alpha = 0.5;
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [backImageView addGestureRecognizer:tap];
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@(280));
    }];
    
    if (self.alertTitle.length) {
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.numberOfLines = 0;
        self.titleLab.text = self.alertTitle;
        self.titleLab.font = [UIFont systemFontOfSize:18];
        self.titleLab.textColor = self.titleColor;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(10);
            make.right.equalTo(self.backView.mas_right).offset(-10);
            make.top.equalTo(self.backView.mas_top).offset(20);
        }];
    }
    
    if (self.alertContent.length) {
        self.contentLab = [[UILabel alloc] init];
        self.contentLab.numberOfLines = 0;
        self.contentLab.text = self.alertContent;
        self.contentLab.font = [UIFont systemFontOfSize:16];
        self.contentLab.textColor = self.contentColor;
        self.contentLab.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(20);
            make.right.equalTo(self.backView.mas_right).offset(-20);
            if (self.alertTitle.length) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(15);
            } else {
                make.top.equalTo(self.backView.mas_top).offset(20);
            }
        }];
    }
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        if (self.alertContent.length) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(15);
        } else if (self.alertTitle.length) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(15);
        }
        make.height.equalTo(@1);
    }];
    
    for (ZFAlertViewItem * btn in self.actionArray) {
        [self.backView addSubview:btn];
    }
    
    [self.actionArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [self.actionArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom);
        make.top.equalTo(line.mas_bottom).offset(15);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-15);
    }];
    
    UIView * line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.backView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.bottom.equalTo(self.backView.mas_bottom).offset(0);
        make.width.equalTo(@1);
    }];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLab.textColor = titleColor;
    
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    self.contentLab.textColor = contentColor;
}

- (NSMutableArray *)actionArray {
    if(_actionArray == nil){
        _actionArray = [[NSMutableArray alloc] init];
    }
    return _actionArray;
}

- (void)addAction:(ZFAlertAction *)action {
    ZFAlertViewItem * item = [[ZFAlertViewItem alloc] init];
    item.text = action.title;
    item.textColor = action.titleColor;
    item.handle = action.handle;
    item.delegate = self;
    [self.actionArray addObject:item];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap {
    if (self.dismissTapBackground) {
        [self clickItem];
    }
}

- (void)clickItem {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dealloc {
    NSLog(@"shifang");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


#pragma mark ============弹窗Action============
@implementation ZFAlertAction

+ (instancetype)actionWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor action:(ZFAlertActionBlock)handel {
    return [[ZFAlertAction alloc] initWithTitle:title andTitleColor:titleColor action:handel];
}

- (instancetype)initWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor action:(ZFAlertActionBlock)handel {
    self = [super init];
    if(self){
        _title = title;
        _titleColor = titleColor;
        _handle = handel;
    }
    return self;
}

@end

#pragma mark ============弹窗Item============
@implementation ZFAlertViewItem

- (instancetype)init {
    self = [super init];
    if(self){
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)]];
    }
    return self;
}

- (void)clickAction {
    [self.delegate clickItem];
    if(self.handle){
        self.handle();
    }
}

@end


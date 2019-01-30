//
//  ZFCustomAlertController.h
//  ZFCustomAlertController
//
//  Created by mac on 2019/1/30.
//  Copyright © 2019年 ZF. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 通用弹窗控制器
 */
@class ZFAlertAction,ZFAlertViewItem;


@interface ZFCustomAlertController : UIViewController

@property (nonatomic ,copy) NSString *alertTitle;
@property (nonatomic ,copy) NSString *alertContent;
@property (nonatomic ,strong) UIColor *titleColor;
@property (nonatomic ,strong) UIColor *contentColor;
@property (nonatomic ,assign) BOOL dismissTapBackground;

+ (instancetype)alertWithTitle:(NSString *)title andContent:(NSString *)content;

- (void)addAction:(ZFAlertAction *)action;

@end


typedef void(^ZFAlertActionBlock)(void);

/**
 弹窗事件
 */
@interface ZFAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor action:(ZFAlertActionBlock) handel;

@property (nonatomic ,copy ,readonly)  NSString * title;
@property (nonatomic ,strong ,readonly) UIColor * titleColor;
@property (nonatomic ,copy) ZFAlertActionBlock handle;

@end


@protocol ZFAlertDelegate

- (void)clickItem;

@end

/**
 弹窗Item
 */
@interface ZFAlertViewItem : UILabel

@property (nonatomic ,copy) ZFAlertActionBlock handle;

@property (nonatomic ,weak) id<ZFAlertDelegate> delegate;

@end

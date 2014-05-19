//
//  MyViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFlatButton.h"
@interface MyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *headBackgroundImageView;//头像周围的背景
#pragma mark - 头像 名称
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//用户名
@property (weak, nonatomic) IBOutlet UILabel *userType;//用户类型--比如：你是尊贵的土豪

@property (weak, nonatomic) IBOutlet PBFlatButton *registerBtn;//注册
@property (weak, nonatomic) IBOutlet PBFlatButton *loginBtn;//登录
@property (weak, nonatomic) IBOutlet PBFlatButton *systemSetBtn;//系统设置
@property (weak, nonatomic) IBOutlet PBFlatButton *userSetBtn;//账号管理

#pragma mark -账号余额--充值
@property (strong, nonatomic) IBOutlet UIView *userAccount;//充值view
@property (weak, nonatomic) IBOutlet UILabel *reChangLb;//充值

@property (weak, nonatomic) IBOutlet UILabel *userAcountLb;//账号余额
@property (weak, nonatomic) IBOutlet UILabel *fbMoneyLb;//余额数
@property (weak, nonatomic) IBOutlet UILabel *biLb;//币


@property (weak, nonatomic) IBOutlet PBFlatButton *userMoneyBt;//资金记录

//
@property (weak, nonatomic) IBOutlet PBFlatButton * aboutUse;

#pragma mark - 点击事件
- (IBAction)clickAccountImage:(UITapGestureRecognizer *)sender;


@end

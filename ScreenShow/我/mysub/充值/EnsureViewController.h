//
//  EnsureViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "AlixLibService.h"
#import "AlixPayOrder.h"

@interface EnsureViewController : BaseViewController

@property (nonatomic,strong) AlixPayOrder *payOrder;

@property (weak, nonatomic) IBOutlet UILabel *userAccountLb;
@property (weak, nonatomic) IBOutlet UILabel *AcountFbLb;
@property (weak, nonatomic) IBOutlet UILabel *AccountMoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *AccountPayTypeLb;

@property (nonatomic, weak) IBOutlet UILabel * rechargeAccount;
@property (nonatomic, weak) IBOutlet UILabel * Fmoney;
@property (nonatomic, weak) IBOutlet UILabel * moneyLabel;
@property (nonatomic, weak) IBOutlet UILabel * rechargeTypeLabel;

@property (nonatomic,weak) IBOutlet UIButton * sureBtn;

- (IBAction)payButtonClicked:(UIButton *)sender;

@end

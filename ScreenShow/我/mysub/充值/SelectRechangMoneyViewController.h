//
//  SelectRechangMoneyViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboBoxView.h"
#import "AlixPayOrder.h"


@interface SelectRechangMoneyViewController : BaseViewController<ComboxDelegate>
@property (nonatomic,copy) NSString *payType;
@property (weak, nonatomic) IBOutlet UILabel *balanceLb;
@property (weak, nonatomic) IBOutlet UILabel *UserLb;
@property (weak, nonatomic) IBOutlet ComboBoxView *comboxList;
@property (weak, nonatomic) IBOutlet UITextField *otherMoney;
@property (nonatomic, weak) IBOutlet UILabel * userAccount;
@property (nonatomic, weak) IBOutlet UILabel * balance;
@property (nonatomic, weak) IBOutlet UIButton * nextBtn;
@property (nonatomic, weak) IBOutlet UILabel * tipsLabel;
@end

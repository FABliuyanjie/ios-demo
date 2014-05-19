//
//  RechargeSucceedViewController.m
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-4.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "RechargeSucceedViewController.h"

@interface RechargeSucceedViewController ()

@end

@implementation RechargeSucceedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addRechargeInfo
{
//    充值账号
    UILabel * rechargeAccount = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 100, 30)];
    rechargeAccount.text = @"充值账号：";
    rechargeAccount.font = [UIFont systemFontOfSize:16.0f];
    rechargeAccount.backgroundColor = [UIColor clearColor];
    CGSize size = [rechargeAccount.text  sizeAutoFitIOS7WithFont:rechargeAccount.font];
    rechargeAccount.frame = CGRectMake(30, 30, size.width, size.height);
    [self.view addSubview:rechargeAccount];
    
    UILabel * accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rechargeAccount.frame), rechargeAccount.frame.origin.y, SCREEN_WIDTH - size.width - 30, size.height)];
    accountLabel.text = self.accountText;
    accountLabel.font = [UIFont systemFontOfSize:16.0f];
    accountLabel.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    accountLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:accountLabel];
    
//    F币
    UILabel * Fmoney = [[UILabel alloc] init];
    Fmoney.font = [UIFont systemFontOfSize:16.0f];
    Fmoney.backgroundColor = [UIColor clearColor];
    Fmoney.text = @"充值F币：";

    CGSize size1 = [Fmoney.text  sizeAutoFitIOS7WithFont:Fmoney.font];
    Fmoney.frame = CGRectMake(30, CGRectGetMaxY(rechargeAccount.frame) + 30, size1.width, size1.height);
    [self.view addSubview:Fmoney];
    
    
    UILabel * FmoneyLabel = [[UILabel alloc] init];
    FmoneyLabel.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    FmoneyLabel.font = [UIFont systemFontOfSize:16.0f];
    FmoneyLabel.text = @"100币";
    FmoneyLabel.font = [UIFont systemFontOfSize:16.0f];
    CGSize size11 =  [FmoneyLabel.text  sizeAutoFitIOS7WithFont:FmoneyLabel.font];
    FmoneyLabel.frame = CGRectMake(CGRectGetMaxX(Fmoney.frame), Fmoney.frame.origin.y, size11.width, size11.height);
//    FmoneyLabel.text = [NSString stringWithFormat:@"%@币",self.FmoneyText];
    [self.view addSubview:FmoneyLabel];
    
//    充值金额
    UILabel * moneyLabel = [[UILabel alloc] init];
    moneyLabel.font = [UIFont systemFontOfSize:16.0f];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.text = @"充值金额：";
    CGSize size2 =  [moneyLabel.text  sizeAutoFitIOS7WithFont:moneyLabel.font];
    moneyLabel.frame = CGRectMake(30, CGRectGetMaxY(Fmoney.frame) + 30, size2.width, size2.height);
    [self.view addSubview:moneyLabel];
    
    UILabel * money = [[UILabel alloc] init];
//                       WithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), moneyLabel.frame.origin.y, 30, moneyLabel.frame.size.height)];
    money.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    money.text = self.moneyText;
    CGSize size21 =  [money.text  sizeAutoFitIOS7WithFont:money.font];
    money.frame = CGRectMake(CGRectGetMaxX(moneyLabel.frame), moneyLabel.frame.origin.y, size21.width, size21.height);
    money.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:money];
    
    UILabel * RMB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(money.frame), moneyLabel.frame.origin.y, 100, size2.height)];
    RMB.text = @"元 人民币";
    RMB.backgroundColor = [UIColor clearColor];
    RMB.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:RMB];
    
//    充值方式
    UILabel * rechargeTypeLabel = [[UILabel alloc] init];
    rechargeTypeLabel.font = [UIFont systemFontOfSize:16.0f];
    rechargeTypeLabel.backgroundColor = [UIColor clearColor];
    rechargeTypeLabel.text = [NSString stringWithFormat:@"充值方式：%@",self.rechargeTypeText];
    CGSize size3 = [rechargeTypeLabel.text sizeAutoFitIOS7WithFont:rechargeTypeLabel.font];
    rechargeTypeLabel.frame = CGRectMake(30, CGRectGetMaxY(moneyLabel.frame) + 30, size3.width, size3.height);
    [self.view addSubview:rechargeTypeLabel];
    
    UILabel * tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"已经把F币充到您的账户上了，感谢您的使用";
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    CGSize size4 = [tipsLabel.text sizeAutoFitIOS7WithFont:tipsLabel.font];
    tipsLabel.frame = CGRectMake(30, CGRectGetMaxY(rechargeTypeLabel.frame) + 30, size4.width, size4.height);
    tipsLabel.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    [self.view addSubview:tipsLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRechargeInfo];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

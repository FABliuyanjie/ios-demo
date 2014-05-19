//
//  EnsureViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "EnsureViewController.h"
#import "AlipayHelper.h"
#import "RechargeSucceedViewController.h"

@interface EnsureViewController ()

@end

@implementation EnsureViewController


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
//    self.rechargeAccount = [[UILabel alloc] init];
    self.rechargeAccount.frame = CGRectMake(30, 30, 100, 30);
    self.rechargeAccount.text = @"充值账号：";
    self.rechargeAccount.font = [UIFont systemFontOfSize:16.0f];
    self.rechargeAccount.backgroundColor = [UIColor clearColor];
    CGSize size = [self.rechargeAccount.text  sizeAutoFitIOS7WithFont:self.rechargeAccount.font];
    self.rechargeAccount.frame = CGRectMake(30, 30, size.width, size.height);
//    [self.view addSubview:self.rechargeAccount];
    
    self.userAccountLb.frame =  CGRectMake(CGRectGetMaxX(self.rechargeAccount.frame), self.rechargeAccount.frame.origin.y, SCREEN_WIDTH - size.width - 30, size.height);
    self.userAccountLb.text = [User shareUser].manName;

    self.userAccountLb.font = [UIFont systemFontOfSize:16.0f];
    self.userAccountLb.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    
    //    F币
    self.Fmoney.font = [UIFont systemFontOfSize:16.0f];
    self.Fmoney.backgroundColor = [UIColor clearColor];
    self.Fmoney.text = @"充值F币：";
    
    CGSize size1 = [self.Fmoney.text  sizeAutoFitIOS7WithFont:self.Fmoney.font];
    self.Fmoney.frame = CGRectMake(30, CGRectGetMaxY(self.rechargeAccount.frame) + 30, size1.width, size1.height);
    
    
    self.AcountFbLb.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    self.AcountFbLb.font = [UIFont systemFontOfSize:16.0f];
    self.AcountFbLb.text = [NSString stringWithFormat:@"%@",self.payOrder.productName];
    self.AcountFbLb.font = [UIFont systemFontOfSize:16.0f];
    CGSize size11 =  [self.AcountFbLb.text  sizeAutoFitIOS7WithFont:self.AcountFbLb.font];
    self.AcountFbLb.frame = CGRectMake(CGRectGetMaxX(self.Fmoney.frame), self.Fmoney.frame.origin.y, size11.width, size11.height);

    
    //    充值金额
    self.moneyLabel.font = [UIFont systemFontOfSize:16.0f];
    self.moneyLabel.backgroundColor = [UIColor clearColor];
    self.moneyLabel.text = @"充值金额：";
    CGSize size2 =  [self.moneyLabel.text  sizeAutoFitIOS7WithFont:self.moneyLabel.font];
    self.moneyLabel.frame = CGRectMake(30, CGRectGetMaxY(self.Fmoney.frame) + 30, size2.width, size2.height);

    self.AccountMoneyLb.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    self.AccountMoneyLb.text = [NSString stringWithFormat:@"%@",self.payOrder.amount];
    CGSize size21 =  [self.AccountMoneyLb.text  sizeAutoFitIOS7WithFont:self.AccountMoneyLb.font];
    self.AccountMoneyLb.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), self.moneyLabel.frame.origin.y, size21.width + 10, size21.height);
    self.AccountMoneyLb.font = [UIFont systemFontOfSize:16.0f];
    
    UILabel * RMB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AccountMoneyLb.frame), self.moneyLabel.frame.origin.y, 100, size2.height)];
    RMB.text = @"元 人民币";
    RMB.backgroundColor = [UIColor clearColor];
    RMB.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:RMB];
    
    //    充值方式
    self.rechargeTypeLabel.font = [UIFont systemFontOfSize:16.0f];
    self.rechargeTypeLabel.backgroundColor = [UIColor clearColor];
    self.rechargeTypeLabel.text = @"充值方式：";

    CGSize size3 = [self.rechargeTypeLabel.text sizeAutoFitIOS7WithFont:self.rechargeTypeLabel.font];
    self.rechargeTypeLabel.frame = CGRectMake(30, CGRectGetMaxY(self.moneyLabel.frame) + 30, size3.width, size3.height);
    
    self.AccountPayTypeLb.text = [NSString stringWithFormat:@"%@",self.payOrder.paymentType];
    self.AccountPayTypeLb.frame = CGRectMake(CGRectGetMaxX(self.rechargeTypeLabel.frame), self.rechargeTypeLabel.frame.origin.y, 150, size3.height);
    self.AccountPayTypeLb.font = [UIFont systemFontOfSize:16.0f];
    
    self.sureBtn.frame = CGRectMake(10, CGRectGetMaxY(self.AccountPayTypeLb.frame) + 65, SCREEN_WIDTH - 20, 40);
    self.sureBtn.backgroundColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    self.sureBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"支付宝充值";
    
    [self addRechargeInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payButtonClicked:(UIButton *)sender
{
    //TODO:支付
    [AlipayHelper payOrder:_payOrder inView:self.view paySuccess:^{
        SendNoti(kReflushUserInfo);
    
        RechargeSucceedViewController * rechargeSucceed = [[RechargeSucceedViewController alloc] init];
        rechargeSucceed.accountText = [User shareUser].manName;
        rechargeSucceed.FmoneyText = self.payOrder.productName;
        rechargeSucceed.rechargeTypeText = self.payOrder.paymentType;
        rechargeSucceed.moneyText = self.payOrder.amount;
        [self.navigationController pushViewController:rechargeSucceed animated:YES];
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
    } payFailure:^{
        //TODO:Debug
        SendNoti(kReflushUserInfo);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
@end

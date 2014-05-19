//
//  SelectRechangMoneyViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SelectRechangMoneyViewController.h"
#import "EnsureViewController.h"


@interface SelectRechangMoneyViewController ()
{
    NSInteger _type; //
    AlixPayOrder *_payOrder;
    NSDictionary *_orders;
    
    NSString *_amount;
}
@end

@implementation SelectRechangMoneyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择充值金额";
    [self initUI];

    _amount = @"0.01";
}

-(void)initUI
{
    self.userAccount.font = [UIFont systemFontOfSize:18.0f];
    CGSize size1 = [self.userAccount.text sizeAutoFitIOS7WithFont:self.userAccount.font];
    self.userAccount.frame = CGRectMake(30, 30, size1.width, size1.height);
    
    self.UserLb.text = [User shareUser].manName;
    self.UserLb.frame = CGRectMake(CGRectGetMaxX(self.userAccount.frame), self.userAccount.frame.origin.y, 150, size1.height);
    self.UserLb.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    self.UserLb.font = [UIFont systemFontOfSize:18.0f];
    
    self.balance.font = [UIFont systemFontOfSize:18.0f];
    CGSize size2 = [self.balance.text sizeAutoFitIOS7WithFont:self.balance.font];
    self.balance.frame = CGRectMake(30, CGRectGetMaxY(self.userAccount.frame) + 30, size2.width, size2.height);
    
    self.balanceLb.frame = CGRectMake(CGRectGetMaxX(self.balance.frame), self.balance.frame.origin.y, 150, size2.height);
    self.balanceLb.text = [NSString stringWithFormat:@"%ld",(long)[User shareUser].accountFB];
    self.balanceLb.textColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    self.balanceLb.font = [UIFont systemFontOfSize:18.0f];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.balance.frame) + 20, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:189 / 255.0f green:198 / 255.0f blue:205 / 255.0f alpha:1];
    [self.view addSubview:lineView];
    
    self.tipsLabel.frame = CGRectMake(30, CGRectGetMaxY(lineView.frame) + 20, SCREEN_WIDTH - 30, 30);
    self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
    
    NSArray *combinData = [self getCombinData];
    self.comboxList.frame = CGRectMake(30, CGRectGetMaxY(self.tipsLabel.frame) + 5, self.comboxList.frame.size.width, self.comboxList.frame.size.height);
    self.comboxList.delegate = self;
    self.comboxList.comboBoxDatasource = combinData;
    self.comboxList.backgroundColor = [UIColor whiteColor];
    [self.comboxList setContent:combinData[0]];
    
    self.otherMoney.frame=  CGRectMake(30, CGRectGetMaxY(self.tipsLabel.frame) + 40, self.comboxList.frame.size.width, 25);
    
    self.otherMoney.layer.borderColor = [UIColor blackColor].CGColor;
    self.otherMoney.layer.borderWidth = 1.0f;
    self.otherMoney.hidden = YES;
    
    self.nextBtn.frame = CGRectMake(10, CGRectGetMaxY(self.comboxList.frame) + 100, SCREEN_WIDTH - 20, 40);
    self.nextBtn.titleLabel.textColor = [UIColor whiteColor];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    self.nextBtn.backgroundColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    [self.nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
}


//TODO:到网络上获取商品信息
-(NSArray*)getCombinData
{
    //TODO:从服务器获取商品信息
    NSArray *combineData = @[@"冲一分钱兑换1币",@"冲5元兑换500币",@"冲10元兑换100币",@"冲50元兑换5000币",@"冲100元兑换10000币",@"冲200元兑换20000币",@"冲500元兑换50000币",@"冲1000元兑换100000币",@"冲2000元兑换200000币",@"冲5000元兑换500000币",@"其他金额"];
    NSArray *moneyData = @[@"0.01",@"5",@"10",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000",@"other"];
    _orders = [NSDictionary dictionaryWithObjects:moneyData forKeys:combineData];
    
    return combineData;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EnsurePaySegue"]) {
        EnsureViewController *evc = segue.destinationViewController;
        evc.payOrder = _payOrder;
        
        //TODO:
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"EnsurePaySegue"]) {
        if (_comboxList.isSelectedLastObject==YES && _otherMoney.text.length==0) {
            [TSMessage showNotificationWithTitle:@"请输入充值金额" type:TSMessageNotificationTypeError];
            return NO;
        }
        if (_payOrder==nil) {
            _payOrder = [[AlixPayOrder alloc]init];
        }
         NSString *key =[self.comboxList.comboBoxDatasource objectAtIndex:_type];
        if ([key isEqualToString:@"其他金额"]) {
            _payOrder.amount = self.otherMoney.text;
        }
        else
            _payOrder.amount = _orders[key];
        _payOrder.productName = key;
        _payOrder.paymentType = self.payType;
        return YES;
    }
    return YES;
}



#pragma mark - CombineBox Delegate
-(void)comboxCellDidSelected:(ComboBoxView*)combox atIndex:(NSIndexPath*)index;
{
    _type = index.row;
    NSString *key =[combox.comboBoxDatasource objectAtIndex:_type];
    if ([key isEqualToString:@"其他金额"]) {
        self.otherMoney.hidden = NO;
        [self.view bringSubviewToFront:self.otherMoney];
    }else{
        _amount = [_orders objectForKey:key];
        self.otherMoney.hidden = YES;
    }
}

-(void)comboxCellWillSelected
{
    self.otherMoney.hidden = YES;
}

@end

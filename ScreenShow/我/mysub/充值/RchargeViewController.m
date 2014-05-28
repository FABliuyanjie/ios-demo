//
//  RchargeViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "RchargeViewController.h"
#import "SelectRechangMoneyViewController.h"
@interface RchargeViewController ()

@end

@implementation RchargeViewController

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
    self.title = @"充值";
    self.alipayPayBtn.backgroundColor =
    self.phonePayBtn.backgroundColor =
    self.rechargeableCardPayBtn.backgroundColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    
    self.alipayPayBtn.titleLabel.textColor =
    self.phonePayBtn.titleLabel.textColor =
    self.rechargeableCardPayBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.alipayPayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.phonePayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.rechargeableCardPayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

    // Do any additional setup after loading the view.
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
    if ([segue.identifier isEqualToString:@"alipaySegue"]) {
        SelectRechangMoneyViewController *srmvc =segue.destinationViewController;
        srmvc.payType = @"支付宝支付";
    }
    if ([segue.identifier isEqualToString:@"mobilePaySegue"]) {
        SelectRechangMoneyViewController *srmvc =segue.destinationViewController;
        srmvc.payType = @"手机支付";
    }

    [super prepareForSegue:segue sender:sender];
    NSLog(@"adskfjk");
    NSLog(@"adskfjk");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden=YES;
}
//-(IBAction)alipayBtnClick:(id)sender
//{
//    
//}
//
//-(IBAction)phonePayBtnClick:(id)sender
//{
//    
//}
//
//-(IBAction)rechargeableCardPayBtnClick:(id)sender
//{
//    
//}


@end

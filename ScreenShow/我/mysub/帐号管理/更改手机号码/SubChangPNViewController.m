//
//  SubChangPNViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-2.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SubChangPNViewController.h"

@interface SubChangPNViewController ()

@end

@implementation SubChangPNViewController
@synthesize mPhoneNum;
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
    self.notification.text = [NSString stringWithFormat:@"%@",mPhoneNum];
    self.title = @"确认手机号";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reSendVerifyCode:(UIButton *)sender {
    [TOOL sendVerifyCodeToPhone:self.mPhoneNum type:kCodeTypeChangNum completionHandler:^(bool status, NSString*info){
        [[iToast makeText:info]show];
    }];
        
        
}

- (IBAction)EnVerifyCode:(id)sender {
    __block SubChangPNViewController *weaKSelf = self;
    [TOOL changePhoneNumber:self.mPhoneNum withVerifyCode:self.verifyCode completionHandler:^(bool status, NSString *info){
        [[iToast makeText:info]show];
        if (status) {
            [weaKSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

-(void)popViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

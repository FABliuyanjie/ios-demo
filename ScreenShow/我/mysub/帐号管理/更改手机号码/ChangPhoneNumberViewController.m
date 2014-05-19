//
//  ChangPhoneNumberViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-2.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ChangPhoneNumberViewController.h"
#import "SubChangPNViewController.h"
@interface ChangPhoneNumberViewController ()

@end

@implementation ChangPhoneNumberViewController

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
    self.currentPN.text = [NSString stringWithFormat:@"%@",[User shareUser].manPhone];
    self.title = @"输入手机号";
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
    if ([segue.identifier isEqualToString:@"EnsurePhoneNumSegue"]) {
        SubChangPNViewController *subPN = segue.destinationViewController;
        subPN.notification.text = self.mPNTf.text;
        subPN.mPhoneNum = self.mPNTf.text;
    }

}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
        if ([self checkPhoneNum]==YES) {
            
            [MBProgressHUD show:@"验证码发送中..." icon:nil view:self.view];
            
            [TOOL sendVerifyCodeToPhone:self.mPNTf.text];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            return YES;
        }
   
    return NO;;
}



-(BOOL)checkPhoneNum
{
    if (self.mPNTf.text.length!=11 && ![self.mPNTf.text intValue]) {
        [TSMessage showNotificationWithTitle:@"请输入正确的手机号码" type:TSMessageNotificationTypeError];
        return NO;
    }
    return YES;
}
@end

//
//  ChangEmailViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ChangEmailViewController.h"
#import "SubChangEmailViewController.h"
@interface ChangEmailViewController ()

@end

@implementation ChangEmailViewController

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
    self.currentEmail.text = [NSString stringWithFormat:@"%@",[User shareUser].manEmail];
    self.title = @"更换邮箱";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EnsureEmailSegue"]) {
        SubChangEmailViewController *subPN = segue.destinationViewController;
        subPN.email = self.mEmail.text;
       
    }
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"EnsureEmailSegue"]) {
        if ([self.mEmail.text rangeOfString:@"@"].length!=1) {
            [TSMessage showNotificationWithTitle:@"请输入正确的邮箱地址" type:TSMessageNotificationTypeError];
            return NO;
        }
        
        [MBProgressHUD show:@"验证码发送中..." icon:nil view:self.view];
        
        [TOOL sendVerifyCodeToEmail:self.mEmail.text];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        return YES;
    }
    return YES;
}





@end

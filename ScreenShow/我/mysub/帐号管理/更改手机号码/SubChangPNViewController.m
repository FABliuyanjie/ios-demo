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
    if( [TOOL sendVerifyCodeToPhoneForChangePhoneNum:self.mPhoneNum]){
        [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
    }
    else{
        [MBProgressHUD showError:@"发送失败" toView:self.view];
        
        NSLog(@"dsssssssss");
    };
    
}

- (IBAction)EnVerifyCode:(id)sender {
    NSDictionary * dict = [TOOL changePhoneNumber:self.mPhoneNum withVerifyCode:self.verifyCodeTextField.text];
//    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    int status = [dict[@"status"]intValue];
    //MARK:DEBUG
    if (status == 1) {
        if ([dict[@"data"] intValue] == 1) {
            [MBProgressHUD showError:[dict objectForKey:@"info"] toView:self.view];
            [User reflushUserInfoWithBlocSuccess:^(NSString *info) {
                [MBProgressHUD showError:[dict objectForKey:@"info"] toView:self.view];

                SendNoti(kReflushUserInfo);
                [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];

            } failure:^(NSString *info) {
                NSLog(@"asdfjkaskjdfkjaksj");
                NSLog(@"asdfjkaskjdfkjaksj");
                NSLog(@"asdfjkaskjdfkjaksj");
                 NSLog(@"asdfjkaskjdfkjaksj");
                
            }];
        }
        else
        {
            [MBProgressHUD showError:[dict objectForKey:@"info"] toView:self.view];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];
        }
        
    }else{
        [MBProgressHUD showSuccess:@"修改失败" toView:self.view];
        [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];
    }
    
}

-(void)popViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

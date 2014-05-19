//
//  SubChangEmailViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SubChangEmailViewController.h"

@interface SubChangEmailViewController ()

@end

@implementation SubChangEmailViewController

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
    self.notification.text = self.email;
   
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


- (IBAction)reSentVerifyEmail:(id)sender {
    UIButton *bt =  (UIButton*)sender;
    bt.enabled = NO;
    [bt setBackgroundColor:[UIColor grayColor]];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(until60s:) userInfo:bt repeats:NO];
    [TOOL sendVerifyCodeToEmail:self.email];
}

-(void)until60s:(id)info
{
    UIButton *bt = info;
    bt.enabled = NO;
    [bt setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)returnBtn:(UIButton *)sender {
    SendNoti(kReflushUserInfo);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
@end

//
//  FindPassWordViewController.m
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "UIButton+CountDown.h"
@interface FindPassWordViewController ()
{
    BOOL _timerStarted;
    NSDate* _startTime;
     NSDate*  _endTime;
}
@property (nonatomic, copy)     NSTimer * timer;
@end

@implementation FindPassWordViewController

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
    self.title = @"找回密码";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)phoneNumBtnClick:(id)sender
{
    self.popUpBox = [[PopUpBox alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400)];
    [self.popUpBox setUpTextFieldWithTop:75];
    self.popUpBox.upTextField.placeholder = @"请输入手机号";
    self.popUpBox.upTextField.hidden = NO;
    self.popUpBox.upTextField.delegate = self;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getTime) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
    
    
    
    [self.popUpBox setUpButtonWithTop:self.popUpBox.upTextField.bottom + 35];
    [self.popUpBox.upButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.popUpBox.upButton.hidden = NO;
    
    __block UIButton *weakupBtn = self.popUpBox.upButton;
    __block NSTimer *weakTimer = _timer;
    __block NSDate *weakStartTime = _startTime;
    __block FindPassWordViewController *weakSelf = self;
    self.popUpBox.upBtnClickBlock = ^(NSString * string){
        if (string.length != 11 || string == nil) {
            NSLog(@"请输入手机号");
        }
        else
        {
            [TOOL sendVerifyCodeToEmail:string completionHandler:^(bool status, NSString *info) {
                [[iToast makeText:info]show];
                if (status) {//发送验证码成功
                    weakupBtn.enabled = NO;
                    weakStartTime = [NSDate date];
                    [weakTimer setFireDate:[NSDate distantPast]];
                }else{
                    [weakupBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                }
                
            }];
            NSLog(@"获取验证码");
        }
    };
    
    [self.popUpBox setDownTextFieldWithTop:self.popUpBox.upButton.bottom + 60];
    self.popUpBox.downTextField.placeholder = @"请输入验证码";
    self.popUpBox.downTextField.hidden = NO;
    self.popUpBox.downTextField.delegate = self;
    [self.popUpBox setDownButtonWithTop:self.popUpBox.downTextField.bottom + 50];
    [self.view addSubview:self.popUpBox];
    
    [self.popUpBox.downButton setTitle:@"下一步" forState:UIControlStateNormal];
    self.popUpBox.downButton.hidden = NO;
    
    self.popUpBox.downClickBlock = ^(NSString * upString, NSString *downStr, id pop){
      
        NSLog(@"下一步");
        
//        [(PopUpBox *)pop closeBtnClick];
        
        [weakSelf addEnsurePasswordView];
        
    };
    
    [self.view bringSubviewToFront:self.popUpBox];
    
    self.popUpBox.closeClickBlock = ^(id pop){
        
        [(PopUpBox *)pop removeFromSuperview];
    };
}

-(void)getTime
{
    NSTimeInterval stayTime = [_startTime timeIntervalSinceNow]/1000;
    if (stayTime < 60) {
        NSString * time = [NSString stringWithFormat:@"%f秒重新获取",60 - stayTime];
        [self.popUpBox.upButton setTitle:time  forState:UIControlStateDisabled];
    }else{
        self.popUpBox.upButton.enabled = YES;
        [self.popUpBox.upButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

//确认
-(void)addEnsurePasswordView
{
    if (self.popUpBox == nil) {
        self.popUpBox  = [[PopUpBox alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400)];
        [self.view addSubview:self.popUpBox];
        [self.view bringSubviewToFront:self.popUpBox];
    }
    
    self.popUpBox.upButton.hidden = YES;
    
    [self.popUpBox setUpTextFieldWithTop:75];
    self.popUpBox.upTextField.placeholder = @"请输入密码";
    self.popUpBox.upTextField.hidden = NO;
    
    [self.popUpBox setDownTextFieldWithTop:self.popUpBox.upTextField.bottom + 30];
    self.popUpBox.downTextField.placeholder = @"请再次输入密码";
    self.popUpBox.downTextField.hidden = NO;
    
    [self.popUpBox setDownButtonWithTop:self.popUpBox.downTextField.bottom + 50];
    
    [self.popUpBox.downButton setTitle:@"确认" forState:UIControlStateNormal];
    self.popUpBox.downButton.hidden = NO;
    
    NSLog(@"self.popUpBox.downButton.frame = %@", NSStringFromCGRect(self.popUpBox.downButton.frame));
    __block FindPassWordViewController *weakSelf = self;
    self.popUpBox.downClickBlock = ^(NSString * upString, NSString * downString, id pop){
        
        NSLog(@"确认");
        [weakSelf upDateFindSucceedView];
        
    };
    
    self.popUpBox.closeClickBlock = ^(id pop){
        
        [(PopUpBox *)pop removeFromSuperview];
    };

}

//修改成功
-(void)upDateFindSucceedView
{
    if (self.popUpBox == nil) {
        self.popUpBox  = [[PopUpBox alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400)];
        [self.view addSubview:self.popUpBox];
        [self.view bringSubviewToFront:self.popUpBox];
    }
    
    self.popUpBox.upButton.hidden = YES;
    self.popUpBox.upTextField.hidden = YES;
    self.popUpBox.downTextField.hidden = YES;
    self.popUpBox.downButton.hidden = NO;

    [self.popUpBox setDownButtonWithTop:185];
    
    self.popUpBox.tipsLabel.hidden = NO;
    self.popUpBox.tipsLabel.text = @"密码已被成功修改";
    self.popUpBox.tipsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    [self.popUpBox.downButton setTitle:@"返回" forState:UIControlStateNormal];
    __weak FindPassWordViewController *weakSelf = self;
    self.popUpBox.downClickBlock = ^(NSString * upString, NSString * downString, id pop){
        
        NSLog(@"返回");
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
        
    };
    
    
    self.popUpBox.closeClickBlock = ^(id pop){
        
        [(PopUpBox *)pop removeFromSuperview];
    };

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.popUpBox.downTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            self.popUpBox.frame = CGRectMake(self.popUpBox.frame.origin.x, -20, self.popUpBox.width , self.popUpBox.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.popUpBox.frame = CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400);

    } completion:^(BOOL finished) {
        
    }];
}

-(IBAction)emailBtnClick:(id)sender
{
    
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

@end

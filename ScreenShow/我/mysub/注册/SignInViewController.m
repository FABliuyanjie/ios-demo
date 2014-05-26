//
//  SignInViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SignInViewController.h"

#import "User.h"
#import "APService.h"

@interface SignInViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
//@property (nonatomic,strong) SubSignTableViewController *subSignViewController;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIButton *VerifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField * useNameTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

- (IBAction)sendVerifyCode:(UIButton *)sender;



- (IBAction)signIn:(UIButton *)sender;

@end

@implementation SignInViewController

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

    self.title = @"注册";
    self.scrollView.contentSize = CGSizeMake(320, 470);
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField== _phoneNumTF && range.location>=11) {
        return NO;
    }
    if (textField== _verifyTF && range.location>=6) {
        return NO;
    }
    if (textField== _nameTF && range.location>=12) {
        return NO;
    }
    if (textField== _pwdTF && range.location>=20) {
        return NO;
    }
    
    
    return YES;
    
}


- (IBAction)signIn:(UIButton *)sender
{
    __block SignInViewController * weakSelf = self;
    [User registerUser:_phoneNumTF.text verify:_verifyTF.text password:_pwdTF.text nickeName:_nameTF.text userName:_useNameTF.text success:^(NSString *info) {
        NSLog(@"注册成功：%@", info);
        LOGIN;
        [User saveUserInfo];
        [[iToast makeText:@"注册成功"]show];
        if(weakSelf.isFromMyViewController==YES){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        [APService setAlias:[NSString stringWithFormat:@"%ld",(long)[User shareUser].manID]callbackSelector:nil object:nil];
        SendNoti(kLogInSuccess);
    } failure:^(NSString *info){
        NSLog(@"注册失败：%@", info);

        LOGOUT;
        [[iToast makeText:@"注册失败"]show];
    }];
}

//检测textField的值
-(BOOL)checkValue
{
    _phoneNum = _phoneNumTF.text;
    _verifyCode = _verifyTF.text;
    _name = _nameTF.text;
    _pwd = _pwdTF.text;
    _userName = self.useNameTF.text;
    
    
    if (_phoneNum.length!=11 || !_phoneNum.integerValue) {
        _externInfo = @"电话号码不对";
        _checkOK = NO;
    }else if (_verifyCode.length!=6 || !_verifyCode.integerValue) {
        _externInfo = @"验证码不对";
        _checkOK = NO;
    }else if (_name.length<4 || _name.length>12) {
        _externInfo = @"昵称不对";
        _checkOK = NO;
    }else if (_pwd.length<6 || _pwd.length>20) {
        _externInfo = @"密码不对";
        _checkOK = NO;
    }else{
        _externInfo = @"请稍等.....";
        _checkOK = YES;
    }
    [[iToast makeText:_externInfo]show];
    return _checkOK;
}




- (IBAction)tap:(id)sender {
    [self.view endEditing:YES];
    [UIView animateWithDuration:1 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (IBAction)sendVerifyCode:(UIButton *)sender {
    _phoneNum = _phoneNumTF.text;
    [TOOL sendVerifyCodeToPhone:_phoneNum type:@"register" completionHandler:^(BOOL status, NSString *info){
     
        [[iToast makeText:info]show];
        
    }];
    
}
@end

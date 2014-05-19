//
//  SubSignTableViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-26.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SubSignTableViewController.h"

@interface SubSignTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIButton *VerifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField * userNameTF;

- (IBAction)sendVerifyCode:(UIButton *)sender;


@end

@implementation SubSignTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _checkOK = NO;
    _externInfo = @"所有内容不能为空";
    
    self.tableView.layer.cornerRadius = 5;
    self.tableView.layer.borderWidth = 0.2;
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self checkValue];
   
        
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _userNameTF || textField == _pwdTF) {
        [UIView animateWithDuration:1 animations:^{
//            .contentOffset = CGPointMake(0, -100);
        }];
    }
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
//检测textField的值
-(BOOL)checkValue
{
    _phoneNum = _phoneNumTF.text;
    _verifyCode = _verifyTF.text;
    _name = _nameTF.text;
    _pwd = _pwdTF.text;
 
    
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
    
    return _checkOK;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)sendVerifyCode:(UIButton *)sender {
    if ([TOOL sendVerifyCodeToPhone:_phoneNum]) {
        //TODO:发送验证码后
    }else{
        //TODO:发送验证码失败
    }
    
    
}
@end

//
//  SubLogInViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-1.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SubLogInViewController.h"

@interface SubLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@end

@implementation SubLogInViewController

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //TODO:Debug
    self.phoneNumTF.text=@"18774671340";
    self.pwdTF.text = @"123456";
    [self checkValue];
    
    
    self.tableView.layer.borderWidth=0;
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
       if (textField== _pwdTF && range.location>=20) {
        return NO;
    }
    
    
    return YES;
    
}
//检测textField的值
-(BOOL)checkValue
{
    _phoneNum = _phoneNumTF.text;
    _pwd = _pwdTF.text;
    
    
    
    if (_phoneNum.length!=11 || !_phoneNum.integerValue) {
        _externInfo = @"电话号码不对";
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

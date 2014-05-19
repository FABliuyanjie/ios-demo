//
//  LogInViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "LogInViewController.h"
#import "SubLogInViewController.h"
#import "User.h"
#import "APService.h"
@interface LogInViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) SubLogInViewController *subLogInViewController;
@end

@implementation LogInViewController

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
    self.title = @"登录";
    self.scrollView.contentSize = CGSizeMake(320, 620);
    self.headImageBackView.layer.cornerRadius = 60;
    self.headImageBackView.layer.borderColor = [UIColor blackColor].CGColor;
    self.headImageBackView.layer.borderWidth = 2;
    
//    self.headImage.layer.cornerRadius = ;
    
    
    //FIXME: 调试
    self.userNameTf.text = @"18774671340";
    self.passwdTf.text = @"123456";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
  
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue:%@",segue.identifier);
    if ([segue.identifier  isEqual:@"SubLogInViewController"]) {
        _subLogInViewController = segue.destinationViewController;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)logIn:(UIButton *)sender {
    if ([self chechTextField]) {
        __weak LogInViewController * weakSelf = self;
        [User logIn:self.userNameTf.text passWord:self.passwdTf.text success:^(NSString *info) {
            
            LOGIN;
            [User saveUserInfo];
            [[iToast makeText:@"登录成功"] show];
            if(self.isFromMyViewController==YES){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                
                [self.navigationController popViewControllerAnimated:YES];
            }
         
            [APService setAlias:[NSString stringWithFormat:@"%ld",(long)[User shareUser].manID]callbackSelector:nil object:nil];
            SendNoti(kLogInSuccess);
        } failure:^(NSString *info){
            LOGOUT;
            [[iToast makeText:@"登录失败"] show];
        }];
        
    }
    
}
-(BOOL)chechTextField
{
//    NSString*  _phoneNum = self.userNameTf.text;
    NSString*   _pwd = self.passwdTf.text;
    BOOL _checkOK = YES;
    NSString *_externInfo = nil;
    
//    if (_phoneNum.length!=11 || !_phoneNum.integerValue) {
//        _externInfo = @"电话号码不对";
//        _checkOK = NO;
//    }else
    if (_pwd.length<6 || _pwd.length>20) {
        _externInfo = @"密码不对";
        _checkOK = NO;
    }else{
        _externInfo = @"请稍等.....";
        _checkOK = YES;
    }
    [[iToast makeText:_externInfo] show];
    return _checkOK;
    
}
- (IBAction)tap:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)thridPartLoginClicked:(UIButton *)sender {
    NSInteger tag = sender.tag;
    NSNumber *loginType = [NSNumber numberWithInteger:tag];
    
    
    
    
    
}



@end

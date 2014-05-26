//
//  LogInViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "LogInViewController.h"

#import "User.h"
#import "APService.h"
#import "UMSocial.h"
@interface LogInViewController ()<UIScrollViewDelegate>

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
    self.headImageBackView.layer.borderWidth = 4;
    
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



/**
 *  点击登录，普通登录
 *
 *  @param sender 登录按钮
 */
- (IBAction)logIn:(UIButton *)sender {
    if ([self chechTextField]) {
        __weak LogInViewController * weakSelf = self;
        [User logIn:self.userNameTf.text passWord:self.passwdTf.text success:^(NSString *info) {
            [weakSelf handleLoginSuccess];
        } failure:^(NSString *info){
            [weakSelf handleLoginFailure];
        }];
        
    }
    
}

/**
 *  登录成功后的操作
 *
 *  @return nil
 */
-(void)handleLoginSuccess
{
    [TOOL logIn];
//    [User saveUserInfo];
    [[iToast makeText:@"登录成功"] show];
    if(self.isFromMyViewController==YES){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [APService setAlias:[NSString stringWithFormat:@"%ld",(long)[User shareUser].manID]callbackSelector:nil object:nil];
    SendNoti(kLogInSuccess);

}

/**
 *  第一次第三方登录必须绑定一个账号
 */
-(void)handleBindAccount
{
    
}

/**
 *  登录失败
 */
-(void)handleLoginFailure
{
    [TOOL logOut];
    [[iToast makeText:@"登录失败"]show];
    
}

/**
 *  输入框架检测
 *
 *  @return 是否符合要求
 */
-(BOOL)chechTextField
{
//    NSString*  _phoneNum = self.userNameTf.text;
    NSString*   _pwd = self.passwdTf.text;
    BOOL _checkOK = YES;
    NSString *_externInfo = nil;
    
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

/**
 *  收键盘
 *
 *  @param sender nil
 */
- (IBAction)tap:(id)sender {
    [self.view endEditing:YES];
}

/**
 *  第三方登录
 *  通过判断Button的tag，来进行选定平台的登录,tag在storyboard中设置
 *  @param sender button，
 */
- (IBAction)thridPartLoginClicked:(UIButton *)sender {
    NSInteger tag = sender.tag-100;

    //选择平台
    NSString *platformName = nil;
    NSString *pfname = nil;
    switch (tag) {
        case 0:
            platformName = UMShareToRenren;
            pfname = @"renren";
            break;
        case 1:
            platformName = UMShareToQzone ;
            pfname = @"qzone";
            break;
        case 2:
            platformName = UMShareToSina;
            pfname = @"sina";
            break;
        case 3:
            platformName = UMShareToWechatTimeline;
            pfname = @"wechat";
            break;
            default:
            platformName = UMShareToQQ;
    }
   __weak LogInViewController * weakSelf = self;
    //唤起授权页
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        NSLog(@"response is %@",response);
        //取得给定平台的username和usid
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *respose){
            NSDictionary *dict = respose.data[@"accounts"][pfname];
            NSLog(@"%@:%@",pfname,dict);
    
            NSString *username = dict[@"username"];
            NSString *usid = dict[@"usid"];

            if(dict==nil) {
                [self handleLoginFailure];
            }
            //判断是否绑定过
            //发起第三方平台的登录
            [User loginWithUMbyOpenid:usid openName:username type:pfname success:^(BOOL flag) {
                if (flag) {//以前登录过，直接登录成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //TODO: 在主线程跳转,绑定操作
                        [weakSelf handleLoginSuccess];
                    });

                }else{//第一次登录，绑定账号或者新注册一个
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //TODO: 在主线程跳转,绑定操作
                        [weakSelf handleBindAccount];
                   
                    });
                }
            }];
            
            
        }];
    });
}



@end

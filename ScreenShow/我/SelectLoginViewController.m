//
//  SelectLoginViewController.m
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-22.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SelectLoginViewController.h"
#import "APService.h"
@interface SelectLoginViewController ()

@end

@implementation SelectLoginViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NoAccountLogin:(UIButton *)sender {
    self.popUpBox = [[PopUpBox alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 75, self.popUpBox.width - 30, 60)];
    label.text = @"为了提供更好的服务";
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textColor = [UIColor whiteColor];
    CGSize size = [label.text sizeAutoFitIOS7WithFont:label.font];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, self.popUpBox.width - 30, size.height);
    [self.popUpBox addSubview:label];
    
    UILabel * downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom, self.popUpBox.width - 30, 60)];
    downLabel.text = @"请完善资料哦";
    downLabel.numberOfLines = 1;
    downLabel.textAlignment = NSTextAlignmentCenter;
    downLabel.backgroundColor = [UIColor clearColor];
    downLabel.font = [UIFont systemFontOfSize:18.0f];
    downLabel.textColor = [UIColor whiteColor];
    CGSize size0 = [label.text sizeAutoFitIOS7WithFont:downLabel.font];
    label.frame = CGRectMake(downLabel.frame.origin.x, downLabel.frame.origin.y, self.popUpBox.width - 30, size0.height);
    [self.popUpBox addSubview:downLabel];
    
    [self.popUpBox setUpTextFieldWithTop:downLabel.bottom + 10];
    self.popUpBox.upTextField.placeholder = @"请输入用户名";
    self.popUpBox.upTextField.text = self.userName;
    self.popUpBox.upTextField.hidden = NO;
    self.popUpBox.upTextField.delegate = self;
    
    self.popUpBox.upButton.hidden = YES;
    
    self.popUpBox.downTextField.hidden = NO;
    [self.popUpBox setDownTextFieldWithTop:self.popUpBox.upTextField.bottom + 60];
    self.popUpBox.downTextField.placeholder = @"请输入密码";
    self.popUpBox.downTextField.hidden = NO;
    self.popUpBox.downTextField.secureTextEntry = YES;
    self.popUpBox.downTextField.delegate = self;
    
    self.popUpBox.tipsLabel.textColor = [UIColor yellowColor];
    self.popUpBox.tipsLabel.text = @"您可根据洗好修改提取到的用户昵称";
    self.popUpBox.tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    self.popUpBox.tipsLabel.hidden = NO;
    CGSize size2 = [self.popUpBox.tipsLabel.text sizeAutoFitIOS7WithFont:self.popUpBox.tipsLabel.font];
    self.popUpBox.tipsLabel.frame = CGRectMake(15, self.popUpBox.upTextField.bottom + 5, size2.width, size2.height);
    

    [self.popUpBox setDownButtonWithTop:self.popUpBox.downTextField.bottom + 50];
    [self.view addSubview:self.popUpBox];
    
    [self.popUpBox.downButton setTitle:@"确认登录" forState:UIControlStateNormal];
    self.popUpBox.downButton.hidden = NO;
    __weak SelectLoginViewController *weakSelf = self;
    self.popUpBox.downClickBlock = ^(NSString * upString, NSString *downStr, id pop){
        
        [User loginWithUMbyOpenid:weakSelf.openID openName:weakSelf.userName myName:weakSelf.popUpBox.upTextField.text pwd:weakSelf.popUpBox.downTextField.text thirdType:weakSelf.typeName type:@"1" success:^(BOOL flag) {
            
            if (flag) {
                [weakSelf handleLoginSuccess];
            }else{
                [weakSelf handleLoginFailure];
            }
        }];
        NSLog(@"登录");
        
    };
    
    [self.view bringSubviewToFront:self.popUpBox];
    
    self.popUpBox.closeClickBlock = ^(id pop){
        
        [(PopUpBox *)pop removeFromSuperview];
    };

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
    [User shareUser].photoUrl = self.headPhotoUrl;
    [User shareUser].nickName = self.userName;
    [APService setAlias:[NSString stringWithFormat:@"%ld",(long)[User shareUser].manID]callbackSelector:nil object:nil];
    SendNoti(kLogInSuccess);
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/**
 *  登录失败
 */
-(void)handleLoginFailure
{
    [TOOL logOut];
    [[iToast makeText:@"登录失败"]show];
    
}
- (IBAction)haveAccountLogin:(UIButton *)sender {
    
    self.popUpBox = [[PopUpBox alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280) / 2.0f, (SCREEN_HEIGHT - 64 - 400) / 2.0f, 280, 400)];
    [self.popUpBox setUpTextFieldWithTop:75];
    self.popUpBox.upTextField.placeholder = @"请输入用户名";
    self.popUpBox.upTextField.hidden = NO;
    self.popUpBox.upTextField.delegate = self;
    
    self.popUpBox.upButton.hidden = YES;
    
    [self.popUpBox setDownTextFieldWithTop:self.popUpBox.upTextField.bottom + 40];
    self.popUpBox.downTextField.placeholder = @"请输入密码";
    self.popUpBox.downTextField.hidden = NO;
    self.popUpBox.downTextField.secureTextEntry = YES;
    self.popUpBox.downTextField.delegate = self;
    [self.popUpBox setDownButtonWithTop:self.popUpBox.downTextField.bottom + 50];
    [self.view addSubview:self.popUpBox];
    
    [self.popUpBox.downButton setTitle:@"登录" forState:UIControlStateNormal];
    self.popUpBox.downButton.hidden = NO;
    __weak SelectLoginViewController *weakSelf = self;
    self.popUpBox.downClickBlock = ^(NSString * upString, NSString *downStr, id pop){
        
        [User loginWithUMbyOpenid:weakSelf.openID openName:weakSelf.userName myName:weakSelf.popUpBox.upTextField.text pwd:weakSelf.popUpBox.downTextField.text thirdType:weakSelf.typeName type:@"2" success:^(BOOL flag) {
            
            if (flag) {
                [weakSelf handleLoginSuccess];
            }else{
                [weakSelf handleLoginFailure];
                [[iToast makeText:@"绑定失败"]show];
            }
        }];
        NSLog(@"登录");

        
    };
    
    [self.view bringSubviewToFront:self.popUpBox];
    
    self.popUpBox.closeClickBlock = ^(id pop){
        
        [(PopUpBox *)pop removeFromSuperview];
    };

}
@end

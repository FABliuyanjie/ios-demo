//
//  SignInViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic,copy,readonly) NSString *phoneNum;//电话号码
@property (nonatomic,copy,readonly) NSString *verifyCode;//验证码
@property (nonatomic,copy,readonly) NSString *name;//昵称
@property (nonatomic,copy,readonly) NSString *pwd;//密码
@property (nonatomic,copy,readonly) NSString * userName; //用户名

@property (nonatomic,assign,readonly) BOOL checkOK;
@property (nonatomic,copy,readonly) NSString *externInfo;
//TextFild
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,assign) BOOL isFromMyViewController;
@end

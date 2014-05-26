//
//  TOOL.h
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseMan;
#define kConfigFileName @"SystemConfig"

#define MAINBROADCASTONLine     @"mainBroadcastOnline"
#define AUTOLOGIN              @"autologin"
#define PRIVATEMESSAGE          @"privateMessage"
#define RECEIVEMESSAGESOUND     @"receiveMessageSound"
#define RECEIVEMESSAGESHAKE     @"receiveMessageShake"
#define SHAKEANDCHANGE          @"shakeAndChange"
#define AUTODELETECACHE         @"autoDeleteCache"
typedef void(^handler)(bool ,NSString*);

@interface TOOL : NSObject

//登录检查
+(BOOL)isLogin;
+(void)logOut;
+(void)logIn;

//发送验证码
+(void)sendVerifyCodeToPhone:(NSString*)phoneNum type:(NSString*)type completionHandler:handler;
//修改手机号码
+(void)changePhoneNumber:(NSString *)newPhoneNum withVerifyCode:(NSString *)verifyCode  completionHandler:handler;
//修改邮箱
+ (void)changEmailAddress:(NSString*)user_email completionHandler:handler;
//通过邮箱找回密码
+(void)sendVerifyCodeToEmail:(NSString*)email completionHandler:handler;
//通过手机验证码找回密码
+(void)changPwdByPhone:(NSString*)phone Verify:(NSString*)code password:(NSString*)pwd completionHandler:handler;
//修改用户头像
+(void)uploadUserPhoto:(UIImage*)image completionHandler:(void (^)(bool status, NSString *info))handler;


//系统设置
+ (BOOL)soundWhenReceiveMessage;
+ (BOOL)sharkWhenReceiveMessage;
+ (BOOL)handOverByShake;
+ (bool)autoDeleteCache30Day;
+ (void)clearCacheWithBlock:(void (^)())block;

//登录对话框
+(void)showLoginViewControllerForm:(UIViewController*)vc Push:(BOOL)push;

//分享
+(void)shareAllButtonClickHandler:(UIViewController *)vc WithInfo:(NSDictionary*)info;

//第三方登录
+(void)logInWithThirdPart:(id)actionNum,...;



@end

//
//  TOOL.h
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@class BaseMan;
#define kConfigFileName @"SystemConfig"

#define MAINBROADCASTONLine     @"mainBroadcastOnline"
#define AUTOLOGIN              @"autologin"
#define PRIVATEMESSAGE          @"privateMessage"
#define RECEIVEMESSAGESOUND     @"receiveMessageSound"
#define RECEIVEMESSAGESHAKE     @"receiveMessageShake"
#define SHAKEANDCHANGE          @"shakeAndChange"
#define AUTODELETECACHE         @"autoDeleteCache"


@interface TOOL : NSObject

//登录检查
+(BOOL)isLogin;
+(void)logOut;
+(void)logIn;

//发送验证码
+(BOOL)sendVerifyCodeToPhone:(NSString*)phoneNum;
+(BOOL)sendVerifyCodeToEmail:(NSString*)email;

//修改用户头像
+(void)uploadUserPhoto:(NSString*)userInfo photo:(UIImage*)image complete:(void(^)(bool success))block;


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
+(void)logInWithShareSDK:(ShareType)type result:(void (^)(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)) blok;


@end

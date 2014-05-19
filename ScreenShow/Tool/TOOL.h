//
//  TOOL.h
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseMan;

@interface TOOL : NSObject

//登录检查
+(BOOL)isLogin;
+(void)logOut;
+(void)logIn;
//发送验证码
+(BOOL)sendVerifyCode;

@end

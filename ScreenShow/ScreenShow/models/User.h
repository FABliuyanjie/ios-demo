//
//  User.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-28.
//  Copyright (c) 2014年 lee. All rights reserved.
//
#import "BaseMan.h"

@interface User : BaseMan<NSCoding,NSCopying>
@property (nonatomic,copy) NSString *token;
@property (nonatomic,strong) UIImage *photo;
@property (nonatomic,assign)BOOL isMotion;

//归档操作
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;


-(instancetype)initWithDict:(NSDictionary*)dict;
-(BOOL)setKeyWithDict:(NSDictionary*)dict;
-(void)saveUserInfo;

+(User*)readUserInfo;
+(instancetype)shareUser;


//登录 block
//登录 普通
+(void)logInUser:(NSString*)userName
        passWord:(NSString*)pwd
completionHandler:(void (^)(bool status, NSString *info))handler;

//注册 普通
+(void)registerUser:(NSString*)phone_num
             verify:(NSString*)code
           password:(NSString*)pwd
          nickeName:(NSString*)name
           userName:(NSString *)userName
  completionHandler:(void (^)(bool status, NSString *info))handler;

//第三方登录--第一次登录，注册新号
+ (void)loginWithUMAndRegisterByOpenid:(NSString*)openid
                              openName:(NSString*)name
                                myName:(NSString*)username
                                   pwd:(NSString*)passWord
                             thirdType:(NSString*)type
                     completionHandler:(void (^)(bool status, NSString *info))handler;

//第三方登录--第一次登录，绑定原来的账号
+ (void)loginWithUMAndBindByOpenid:(NSString*)openid
                              openName:(NSString*)name
                                myName:(NSString*)username
                                   pwd:(NSString*)passWord
                             thirdType:(NSString*)type
                     completionHandler:(void (^)(bool status, NSString *info))handler;

//第三方登录--不是第一次，直接登录
+(void)loginWithUMbyOpenid:(NSString *)openid
                  openName:(NSString *)name
                 thirdType:(NSString*)type
         completionHandler:(void (^)(bool status, NSString *info))handler;

//解除绑定
+(void)unbindThirdAccountWithThirdType:(NSString*)type
                     completionHandler:(void (^)(bool status, NSString *info))handler;

//绑定
+(void)bindThirdAccountByOpenid:(NSString*)openid
                       openName:(NSString*)name
                      thirdType:(NSString*)type
              completionHandler:(void (^)(bool status, NSString *info))handler;
//刷新用户数据
+(void )reflushUserInfoCompletionHandler:(void (^)(bool status, NSString *info))handler;

//通用处理用户数据
+(void)refreshUserInfo:(NSString*)urlStr
           parameter:(NSDictionary*)dictr
   completionHandler:(void (^)(bool status, NSString *info))handler;

@end

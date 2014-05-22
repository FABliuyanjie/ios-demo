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

+(instancetype)shareUser;
-(instancetype)initWithDict:(NSDictionary*)dict;
-(BOOL)setKeyWithDict:(NSDictionary*)dict;

+(User*)readUserInfo;
+(void)saveUserInfo;

+(void )reflushUserInfoWithBlocSuccess:(void (^)(NSString *info))success
                               failure:(void (^)(NSString *info))failure;

//登录 block
//登录 普通
+(void)logIn:(NSString*)userName passWord:(NSString*)pwd
     success:(void (^)(NSString *info))success
     failure:(void (^)(NSString *info))failure;

//注册 普通
+(void)registerUser:(NSString*)phone_num verify:(NSString*)code password:(NSString*)pwd nickeName:(NSString*)name userName:(NSString *)userName
            success:(void (^)(NSString *info))success
            failure:(void (^)(NSString *info))failure;

//第三方登录--如果第一次登陆，需要添加用户名和密码
+(void)loginWithUMbyOpenid:(NSString*)openid openName:(NSString*)name myName:(NSString*)username pwd:(NSString*)passWord type:(NSString*)type success:(void(^)(BOOL flag))success;

//第三方登录--如果不是第一次，就直接登录
+(void)loginWithUMbyOpenid:(NSString *)openid openName:(NSString *)name type:(NSString *)type success:(void (^)(BOOL))success;

//处理用户信息的请求
+(void)flushUserInfo:(NSString*)urlStr parameter:(NSDictionary*)dictr success:(void (^)(NSString* info))success failure:(void (^)(NSString *info))failure;


@end

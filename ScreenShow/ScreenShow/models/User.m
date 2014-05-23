//
//  User.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-28.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "User.h"
#import "APService.h"
#import "iToast.h"
@implementation User

#pragma mark - Coding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.manID forKey:@"user_id"];
    [aCoder encodeObject:self.manName forKey:@"user_name"];
    [aCoder encodeObject:self.nickName forKey:@"nick_name"];
    [aCoder encodeInt:self.manType forKey:@"user_type"];
    [aCoder encodeObject:self.photoUrl forKey:@"user_img"];
    [aCoder encodeInt:self.retainRed forKey:@"retainRed"];
    [aCoder encodeDouble:self.accountMoney forKey:@"money"];
    [aCoder encodeInt:self.accountFB forKey:@"integral"];
    [aCoder encodeInt:self.userLevel forKey:@"v_exp" ];
    [aCoder encodeObject:self.manPhone forKey:@"user_phone"];
    [aCoder encodeObject:self.manEmail forKey:@"user_email"];
    [aCoder encodeObject:self.mxJmImg forKey:@"mx_jm_img"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeBool:self.isMotion forKey:@"isMotion"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [User shareUser];
    if (self) {
        self.manID = [aDecoder decodeIntegerForKey:@"user_id"];
        self.manName = [aDecoder decodeObjectForKey:@"user_name"];
        self.nickName = [aDecoder decodeObjectForKey:@"nick_name"];
        self.manType = [aDecoder decodeIntegerForKey:@"user_type"];
        self.photoUrl =[aDecoder decodeObjectForKey:@"user_img"];
        self.retainRed = [aDecoder decodeIntegerForKey:@"retainRed"];
        self.accountMoney = [aDecoder decodeDoubleForKey:@"money"];
        self.accountFB = [aDecoder decodeIntegerForKey:@"integral"];
        self.userLevel = [aDecoder decodeIntegerForKey:@"v_exp"];
        self.manPhone = [aDecoder decodeObjectForKey:@"user_phone"];
        self.manEmail =[aDecoder decodeObjectForKey:@"user_email"];
        self.mxJmImg = [aDecoder decodeObjectForKey:@"mx_jm_img"];
        self.photo = [aDecoder decodeObjectForKey:@"photo"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.isMotion = [aDecoder decodeBoolForKey:@"isMotion"];
    }
    return self;
}

#pragma mark - Coping  protocol
- (id)copyWithZone:(NSZone *)zone;
{
    User *user = [[[self class] allocWithZone:zone] init];
    user.manID = self.manID;
    user.manName = self.manName;
    user.nickName = self.nickName;
    user.photoUrl = self.photoUrl;
    user.manType = self.manType;
    user.retainRed = self.retainRed;
    user.accountMoney = self.accountMoney;
    user.accountFB = self.accountFB;
    user.userLevel = self.userLevel;
    user.manPhone = self.manPhone;
    user.manEmail = self.manEmail;
    user.mxJmImg = self.mxJmImg;
    user.photo = self.photo;
    user.token = self.token;
    user.isMotion=self.isMotion;
    return user;
}

#pragma mark - Init

+(instancetype)shareUser
{
    
    static User *obj = nil;
    if (!obj) {
        obj = [[User alloc]init];
    }
    return obj;
    
}
-(instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        [self setKeyWithDict:dict];
    }
    return self;
}
-(BOOL)setKeyWithDict:(NSDictionary*)dict
{
    if(dict && [dict isKindOfClass:[NSDictionary class]]){
        self.token = dict[@"token"];
        self.manID = [dict[@"user_id"] intValue];
        self.manName = dict[@"user_name"];
        self.nickName = dict[@"nick_name"];
        self.manType = [dict[@"user_type"]intValue];
        self.photoUrl = dict[@"user_img"];
        self.retainRed = [dict[@"retainRed"]intValue];//TODO:红包数
        self.accountMoney = [dict[@"money"] doubleValue];
        self.accountFB = [dict[@"intergral"]intValue];//TODO:F币
        self.userLevel = [dict[@"v_exp"]intValue];
        self.manPhone = dict[@"user_phone"];
        self.manEmail = dict[@"user_email"];
        self.mxJmImg = dict[@"mx_jm_img"];
        self.isMotion=NO;
        return YES;
    }else{
        ERROR(@"User parser Error!");
    }
    return NO;
}

#pragma mark - Save and Read User Info

+(void)saveUserInfo
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"history.dat"];
    User *user = [User shareUser];
    if (user) {
        [NSKeyedArchiver archiveRootObject:user toFile:filename];
    }else {
        //删除归档文件
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager isDeletableFileAtPath:filename]) {
            [defaultManager removeItemAtPath:filename error:nil];
        }
    }
}
+(User*)readUserInfo
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"history.dat"];
    
    User *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    return user;
}

#pragma mark - Login and Register

+(void)logIn:(NSString*)userName passWord:(NSString*)pwd
     success:(void (^)(NSString *info))success
     failure:(void (^)(NSString *info))failure;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_name=%@&pwd=%@",PORT_USERINFO,userName,pwd];
    return [self flushUserInfo:urlStr parameter:nil success:success failure:failure];
}



//注册 普通
+(void)registerUser:(NSString*)phone_num verify:(NSString*)code password:(NSString*)pwd nickeName:(NSString*)name userName:(NSString *)userName
            success:(void (^)(NSString *info))success
            failure:(void (^)(NSString *info))failure;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_name=%@&phone=%@&verify=%@&pwd=%@&name=%@&type=register",PORT_REGISTERNORMAL, userName,phone_num,code,pwd,name];
    
    NSLog(@"注册requestAddress = %@", urlStr);
    
    return [self flushUserInfo:urlStr parameter:nil success:success failure:failure];
    
}

//更新用户信息
+(void )reflushUserInfoWithBlocSuccess:(void (^)(NSString *info))success
                failure:(void (^)(NSString *info))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",PORT_ACCOUNT,[User shareUser].token];
    return [self flushUserInfo:urlStr parameter:nil success:success failure:failure];

}

//MARK:第三方登录---1
+(void)loginWithUMbyOpenid:(NSString*)openid openName:(NSString*)name myName:(NSString*)username pwd:(NSString*)passWord thirdType:(NSString*)thirdType type:(NSString*)type success:(void(^)(BOOL flag))success;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&username=%@&pwd=%@&thirdtype=%@&type=%@",PORT_BINDQQ,openid,name,username,passWord,thirdType,type];
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"status"]boolValue];
        if (status) {
//            NSString *info = responseObject[@"info"];
            NSDictionary *dict = responseObject[@"data"];
            User *man = [User shareUser];
            if ([man setKeyWithDict:dict]) {
                [User saveUserInfo];
                success(status);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ERROR(@"error:%@",error);
    }];

}

//MARK:第三方登录---2
/**
 *  进行第三方登录，数据层，处理所有的数据操作
 *
 *  @param openid  从第三方平台获取的usid
 *  @param name    从第三方平台获取的username
 *  @param type    登录的类型，1 为第三方登录或者注册 2为绑定 3 为解绑
 *  @param success 成功后的UI操作
 */
+(void)loginWithUMbyOpenid:(NSString *)openid openName:(NSString *)name type:(NSString *)type success:(void (^)(BOOL))success
{
    NSString *codeName = [name stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&thirdtype=%@",PORT_USERINFOTHIRD,openid,codeName,type];
   
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //TODO: 判断是否要绑定用户名
        
        BOOL isRegistered= [responseObject[@"status"] boolValue];
        
         // 如果注册过了，要解析数据，刷新本地的用户信息，设置状态为已经登录
        
        if (isRegistered) {
            NSLog(@"registered!,%s",__FUNCTION__);
        }
        success(isRegistered);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //TODO: 网络故障
    }];
}


+(void)flushUserInfo:(NSString*)urlStr parameter:(NSDictionary*)dictr success:(void (^)(NSString* info))success failure:(void (^)(NSString *info))failure
{
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:dictr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int status = [[responseObject objectForKey:@"status"]intValue];
        NSString *info = responseObject[@"info"];
        NSDictionary *dict =[responseObject objectForKey:@"data"];
        
        NSLog(@"获取用户信息：%@", dict);
        
        if (status==1) {
            User *man = [User shareUser];
            if ([man setKeyWithDict:dict]) {
                [User saveUserInfo];
                if (success) {
                     success(info);
                
                }
               
            }else{
                ERROR(@"error:%@",info);
                if (failure) {
                   failure(@"服务器错误");
                }

                
            }
        }else{
            NSLog(@"获取用户信息：%@", dict);

            ERROR(@"error:%@",info);
            if (failure) {
                 failure(info);
            }

           
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ERROR(@"error:%@",error);
        NSLog(@"获取用户信息：%@", error.userInfo);

        NSString *errorStr = @"网络连接失败";
        if (failure) {
             failure(errorStr);
        }
       
    }];
    
}



@end

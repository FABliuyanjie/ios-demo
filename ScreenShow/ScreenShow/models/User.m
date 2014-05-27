//
//  User.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-28.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "User.h"
#import "APService.h"
#import "TOOL.h"
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
    self = [super init];
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
        obj = [[self class]readUserInfo];
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

-(void)saveUserInfo
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"history.dat"];
    [NSKeyedArchiver archiveRootObject:self toFile:filename];

}
+(User*)readUserInfo
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"history.dat"];
    
   User *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
 
    return user;
}

#pragma mark - Login and Register

+(void)logInUser:(NSString*)userName
        passWord:(NSString*)pwd
completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_name=%@&pwd=%@",PORT_USERINFO,userName,pwd];
    return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];
}



//注册 普通
+(void)registerUser:(NSString*)phone_num
             verify:(NSString*)code
           password:(NSString*)pwd
          nickeName:(NSString*)name
           userName:(NSString *)userName
  completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_name=%@&phone=%@&verify=%@&pwd=%@&name=%@&type=register",PORT_REGISTERNORMAL, userName,phone_num,code,pwd,name];
    return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];
    
}

//更新用户信息
+(void )reflushUserInfoCompletionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",PORT_ACCOUNT,[User shareUser].token];
    return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];

}

//第三方登录--第一次登录，需要注册新号
+ (void)loginWithUMAndRegisterByOpenid:(NSString*)openid
                              openName:(NSString*)name
                                myName:(NSString*)username
                                   pwd:(NSString*)passWord
                             thirdType:(NSString*)type
                     completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&username=%@&pwd=%@&type=%@&thirdtype=%@",PORT_ThirdBind,openid,name,username,passWord,@"1",type];
    return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];
}

//第三方登录--第一次登录，绑定原来的账号
+ (void)loginWithUMAndBindByOpenid:(NSString*)openid
                          openName:(NSString*)name
                            myName:(NSString*)username
                               pwd:(NSString*)passWord
                         thirdType:(NSString*)type
                 completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&username=%@&pwd=%@&type=%@&thirdtype=%@",PORT_ThirdBind,openid,name,username,passWord,@"2",type];
    return [self refreshUserInfo:urlStr parameter:nil completionHandler:^(bool status,NSString *info){
        if (status && [info isEqualToString:@"绑定成功"]) {
            return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];
        }else{
            handler(status,info);
        }
    }];
}

//第三方登录--不是第一次，直接登录
+(void)loginWithUMbyOpenid:(NSString *)openid
                  openName:(NSString *)name
                 thirdType:(NSString*)type
         completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&thirdtype=%@",PORT_ThirdLogin,openid,name,type];
     return [self refreshUserInfo:urlStr parameter:nil completionHandler:handler];
}

//通用处理用户数据
+(void)refreshUserInfo:(NSString*)urlStr
             parameter:(NSDictionary*)dictr
     completionHandler:(void (^)(bool status, NSString *info))handler;
{
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:dictr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        bool status = [[responseObject objectForKey:@"status"]boolValue];
        NSString *info = responseObject[@"info"];
        NSDictionary *dict =[responseObject objectForKey:@"data"];
        if (status) {
            [[User shareUser]setKeyWithDict:dict];
        }
        handler(status,info);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO,@"网络故障");
    }];
    
}

//---已经登录之后的
//解除绑定
+(void)unbindThirdAccountWithThirdType:(NSString*)type
                     completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *token = [User shareUser].token;
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&token=%@&thirdtype=%@&type=%@",PORT_ThirdBind,@"",token,type,@"3"];
    return [self bindHandler:urlStr completionHandler:handler];
    
}
//绑定
+(void)bindThirdAccountByOpenid:(NSString*)openid
                       openName:(NSString*)name
                      thirdType:(NSString*)type
              completionHandler:(void (^)(bool status, NSString *info))handler;
{
    NSString *token = [User shareUser].token;
    NSString *urlStr = [NSString stringWithFormat:@"%@?openid=%@&name=%@&thirdtype=%@&token=%@&type=%@",PORT_ThirdBind,openid,name,type,token,@"2"];
    return [self bindHandler:urlStr completionHandler:handler];
    
}
//通用处理
+(void)bindHandler:(NSString*)urlStr completionHandler:(void (^)(bool status, NSString *info))handler;
{
    [TOOL handleResureInfoWithString:urlStr completionHandler:handler];
}

@end

//
//  TOOL.m
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#define TABLE_CELL_ID @"tableCell"

#define ACTION_SHEET_GET_USER_INFO 200
#define ACTION_SHEET_FOLLOW_USER 201
#define ACTION_SHEET_GET_OTHER_USER_INFO 202
#define ACTION_SHEET_GET_ACCESS_TOKEN 203
#define ACTION_SHEET_PRINT_COPY 306

#define LEFT_PADDING 10.0
#define RIGHT_PADDING 10.0
#define HORIZONTAL_GAP 10.0
#define VERTICAL_GAP 10.0



#import "TOOL.h"
#define FILE_NAME @"userInfo.dat"
#import "SDImageCache.h"
#import "AFNetworking.h"
#import "LogInViewController.h"

@implementation TOOL


#pragma mark- 登录检查
+(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"Cookie"];
}


+(void)logOut
{
    [User shareUser].manID = -1;
    [[User shareUser]saveUserInfo];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Cookie"];
  
}


+(void)logIn
{
    [[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"Cookie"];
}

#pragma mark- 验证功能
/**
 *  发送验证码
 *
 *  @param phoneNum 手机号码
 *  @param type     类型 （注册时就用type=register）（更换手机号时用type=cpapi）(用手机号修改密码 type=xgpwd)
 */


+(void)sendVerifyCodeToPhone:(NSString*)phoneNum type:(NSString*)type completionHandler:handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?phone=%@&type=%@",PORT_PHONEVERIFY, phoneNum,type];
   [[self class] handleResureInfoWithString:urlStr completionHandler:handler];
}

/**
 *  更换手机号码
 *
 *  @param newPhoneNum 新手机号码
 *  @param verifyCode  验证码
 *
 *  @return
 */
+(void)changePhoneNumber:(NSString *)newPhoneNum withVerifyCode:(NSString *)verifyCode  completionHandler:handler{
    NSString * urlStr = [NSString stringWithFormat:@"%@?token=%@&user_phone=%@&verify=%@", PORT_PHONECHANGE, [User shareUser].token, newPhoneNum, verifyCode];
    
    [[self class] handleResureInfoWithString:urlStr completionHandler:handler];
}

/**
 *  更换邮箱
 *
 *  @param user_email 必需是注册时绑定的邮箱地址
 */
+ (void)changEmailAddress:(NSString*)user_email completionHandler:handler
{
    NSString * urlStr = [NSString stringWithFormat:@"%@?token=%@&user_email=%@", PORT_EMAILCHANGE, [User shareUser].token, user_email];
   [[self class] handleResureInfoWithString:urlStr completionHandler:handler];
}

/**
 *  通过邮件找回密码
 *
 *  @param email   以前绑定的邮箱号码
 *  @param handler
 */
+(void)sendVerifyCodeToEmail:(NSString*)email completionHandler:handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?uid=%d&user_email=%@",PORT_EMAILVERIFY,[User shareUser].manID,email];
    [[self class] handleResureInfoWithString:urlStr completionHandler:handler];
}

/**
 *  通过手机验证码找回密码
 *
 *  @param phone 手机号码
 *  @param code  验证码
 *  @param pwd   新密码
 */
+(void)changPwdByPhone:(NSString*)phone Verify:(NSString*)code password:(NSString*)pwd completionHandler:handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?phone=%@&verify=%@&pwd=%@",PORT_CHANGPWD_PHONE,phone,code,pwd];
    [[self class] handleResureInfoWithString:urlStr completionHandler:handler];
}

/**
 *  上传头像
 *
 *  @param image   新的头像
 *  @param handler 处理回调
 */
+(void)uploadUserPhoto:(UIImage*)image completionHandler:(void (^)(bool, NSString *))handler
{
    NSData *data = UIImagePNGRepresentation(image);
    NSString *aString = [TOOL base64forData:data];
    NSString *token = [User shareUser].token;
     //构造字段
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?",PORT_HEADIMAGE];
    NSDictionary *partameter = @{@"token":token,@"img":aString};
    [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:partameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        bool status = [responseObject[@"status"]boolValue];
        NSString *info = responseObject[@"info"];
        handler(status,info);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO,@"网络故障");
    }];
}

/**
 *  通用，处理确认信息
 *
 *  @param urlStr 链接
 */
+(void)handleResureInfoWithString:(NSString*)urlStr completionHandler:(void(^)(bool status, NSString *indo)) handler
{
    
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        bool status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        handler(status,info);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO,@"网络故障");
    }];
    
    
}
#pragma mark- 通用功能
//由颜色得到图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//把NSData转NSString，从ASI里复制过来的
+ (NSString*)base64forData:(NSData*)theData {
	
	const uint8_t* input = (const uint8_t*)[theData bytes];
	NSInteger length = [theData length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
	NSInteger i,i2;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
		for (i2=0; i2<3; i2++) {
            value <<= 8;
            if (i+i2 < length) {
                value |= (0xFF & input[i+i2]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


#pragma mark - 系统设置

+(BOOL)findStatuesWithString:(NSString *)string
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * statuesDict = [user objectForKey:kConfigFileName];
    NSString * statues = [statuesDict objectForKey:string];
    NSLog(@"XXXXXXXXXXXXXXXXX%@", string);
    
    if ([statues isEqualToString:@"yes"]) {
        NSLog(@"yes");
        return YES;
    }
    else if([statues isEqualToString:@"no"]){
        NSLog(@"no-------------------------------------");
        return NO;
    }
    return NO;
}

+ (BOOL)soundWhenReceiveMessage
{
    return [self findStatuesWithString:MAINBROADCASTONLine];
//    return [self findString:@"关注的主播上线提醒"];
}


+ (BOOL)sharkWhenReceiveMessage
{
    return [self findStatuesWithString:RECEIVEMESSAGESHAKE];
//    return [self findString:@"收到消息时震动通知"];
}

+ (BOOL)handOverByShake
{
    return [self findStatuesWithString:SHAKEANDCHANGE];
//     return [self findString:@"摇一摇手机切换主播"];
}

+ (bool)autoDeleteCache30Day
{
    return [self findStatuesWithString:AUTODELETECACHE];
//    return [self findString:@"自动删除30天前的缓存"];
}

#pragma mark- 显示登录界面

/**
 *  显示登录界面
 *
 *  @param vc   登录界面现实的额界面
 *  @param push 是否是模态
 */
+(void)showLoginViewControllerForm:(UIViewController*)vc Push:(BOOL)push;
{
    LogInViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
    if (vc.navigationController==nil || push==NO) {
        [vc presentViewController:loginVC animated:YES completion:nil];
    }else{
         [vc.navigationController pushViewController:loginVC animated:YES];
    }
   

}

+(void)showPayViewControllerForm:(UIViewController*)vc Push:(BOOL)push;
{
    UIViewController *payVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"RchargeViewController"];
    if (vc.navigationController==nil || push==NO) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:payVC];
        [vc presentViewController:nav animated:YES completion:nil];
    }else{
        [vc.navigationController pushViewController:payVC animated:YES];
    }
    
    
}

@end

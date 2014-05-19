//
//  TOOL.m
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#import "TOOL.h"
#define FILE_NAME @"userInfo.dat"
@implementation TOOL


//登录检查
+(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"Cookie"];
}


+(void)logOut
{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Cookie"];
  
}
+(void)logIn
{
    [NSUserDefaults standardUserDefaults]setInteger:(NSInteger) forKey:<#(NSString *)#>
    [[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"Cookie"];
}

+(BOOL)sendVerifyCode
{
    INFO(@"sendVerifyCode");
    return YES;
}

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

@end

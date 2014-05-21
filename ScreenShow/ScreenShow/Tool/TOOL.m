//
//  TOOL.m
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-18.
//  Copyright (c) 2013年 FAB. All rights reserved.
//



#import <AGCommon/UINavigationBar+Common.h>
#import <AGCommon/UIImage+Common.h>


#import <AGCommon/UIColor+Common.h>
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/NSString+Common.h>


#import <RenRenConnection/RenRenConnection.h>

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
    [User saveUserInfo];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Cookie"];
  
}
+(void)logIn
{
    [[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"Cookie"];
}

+(BOOL)sendVerifyCodeToPhone:(NSString*)phoneNum;
{
    //TODO:获取手机验证码
//    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%d&user_email=%@",PORT_PHONEVERIFY,[User shareUser].manID,phoneNum];
    NSString *urlStr = [NSString stringWithFormat:@"%@?phone=%@&type=register",PORT_PHONEVERIFY, phoneNum];

    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    int status = [dict[@"status"]intValue];
    if (status==1) {
        return YES;
    }
    return NO;
}

+(BOOL)sendVerifyCodeToPhoneForChangePhoneNum:(NSString*)phoneNum
{
    //TODO:获取手机验证码
    //    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%d&user_email=%@",PORT_PHONEVERIFY,[User shareUser].manID,phoneNum];
    NSString *urlStr = [NSString stringWithFormat:@"%@?phone=%@&type=cpapi",PORT_PHONEVERIFY, phoneNum];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    int status = [dict[@"status"]intValue];
    if (status==1) {
        return YES;
    }
    return NO;
}

+(NSDictionary *)changePhoneNumber:(NSString *)newPhoneNum withVerifyCode:(NSString *)verifyCode
{
    NSString * urlStr = [NSString stringWithFormat:@"%@?token=%@&user_phone=%@&verify=%@", PORT_PHONECHANGE, [User shareUser].token, newPhoneNum, verifyCode];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    NSData * received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    return dict;
}

+(BOOL)sendVerifyCodeToEmail:(NSString*)email
{
//TODO:修改邮箱地址
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%d&user_email=%@",PORT_EMAILCHANGE,[User shareUser].manID,email];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    int status = [dict[@"status"]intValue];
    if (status==1) {
        return YES;
    }
    return NO;

    return YES;
}


+(void)uploadUserPhoto:(NSString*)token photo:(UIImage*)image complete:(void(^)(bool success))block
{
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *aString = [TOOL base64forData:data];
    
     //构造字段
    NSString *urlStr = [NSString stringWithFormat:@"%@?",PORT_HEADIMAGE];
    NSDictionary *partameter = @{@"token":token,@"img":aString};
    [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:partameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        int status = [responseObject[@"status"]intValue];
        if (status==1) {
            block(YES);
            
        }else{
            block(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        block(NO);
    }];
}

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

//+(BOOL)findString:(NSString*)mstring
//{
//    NSString *path = [[NSBundle mainBundle]pathForResource:kConfigFileName ofType:@"plist"];
//    NSArray *dataArray = [NSMutableArray arrayWithContentsOfFile:path];
//    __block BOOL isOk;
//    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString *string= [(NSDictionary*)obj objectForKey:@"string"];
//        if ([string isEqualToString:mstring]) {
//            isOk = [[(NSDictionary*)obj objectForKey:@"value"]boolValue];
//            *stop = YES;
//        }
//    }];
//    return isOk;
//}

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


+(void)showLoginViewControllerForm:(UIViewController*)vc Push:(BOOL)push;
{
    UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
    if (vc.navigationController==nil || push==NO) {
        [vc presentViewController:loginVC animated:YES completion:nil];
    }else{
         [vc.navigationController pushViewController:loginVC animated:YES];
    }
   

}

#pragma mark - 分享

/**
 *	@brief	分享全部
 *
 *	@param 	sender 	事件对象 info 要分享的信息
 */
+ (void)shareAllButtonClickHandler:(UIViewController *)vc WithInfo:(NSDictionary*)info
{
    NSString *content = info[@"content"];
    NSString *url = info[@"url"];
    NSString *title = info[@"title"];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:IMAGE_NAME ofType:IMAGE_EXT];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"form FABShow"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:title
                                                  url:url
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    //定制人人网信息
    [publishContent addRenRenUnitWithName:INHERIT_VALUE
                              description:INHERIT_VALUE
                                      url:INHERIT_VALUE
                                  message:INHERIT_VALUE
                                    image:INHERIT_VALUE
                                  caption:nil];
    
    //定制QQ空间信息
    [publishContent addQQSpaceUnitWithTitle:INHERIT_VALUE
                                        url:INHERIT_VALUE
                                       site:nil
                                    fromUrl:nil
                                    comment:INHERIT_VALUE
                                    summary:INHERIT_VALUE
                                      image:INHERIT_VALUE
                                       type:INHERIT_VALUE
                                    playUrl:nil
                                       nswb:nil];
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:INHERIT_VALUE
                                           title:NSLocalizedString(@"TEXT_HELLO_WECHAT_SESSION", @"Hello 微信好友!")
                                             url:INHERIT_VALUE
                                      thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                           image:INHERIT_VALUE
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:INHERIT_VALUE
                                            title:INHERIT_VALUE
                                              url:@"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4BDA0E4B88DE698AFE79C9FE6ADA3E79A84E5BFABE4B990222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696332342E74632E71712E636F6D2F586B303051563558484A645574315070536F4B7458796931667443755A68646C2F316F5A4465637734356375386355672B474B304964794E6A3770633447524A574C48795333383D2F3634363232332E6D34613F7569643D32333230303738313038266469723D423226663D312663743D3026636869643D222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31382E71716D757369632E71712E636F6D2F33303634363232332E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E5889BE980A0EFBC9AE5B08FE5B7A8E89B8B444E414C495645EFBC81E6BC94E594B1E4BC9AE5889BE7BAAAE5BD95E99FB3222C22736F6E675F4944223A3634363232332C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E4BA94E69C88E5A4A9222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D31354C5569396961495674593739786D436534456B5275696879366A702F674B65356E4D6E684178494C73484D6C6A307849634A454B394568572F4E3978464B316368316F37636848323568413D3D2F33303634363232332E6D70333F7569643D32333230303738313038266469723D423226663D302663743D3026636869643D2673747265616D5F706F733D38227D"
                                       thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    //定制微信收藏信息
    [publishContent addWeixinFavUnitWithType:INHERIT_VALUE
                                     content:INHERIT_VALUE
                                       title:INHERIT_VALUE
                                         url:INHERIT_VALUE
                                  thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                       image:INHERIT_VALUE
                                musicFileUrl:nil
                                     extInfo:nil
                                    fileData:nil
                                emoticonData:nil];
    
    //定制QQ分享信息
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:INHERIT_VALUE
                                title:@"Hello QQ!"
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE];
    
    //定制邮件信息
    [publishContent addMailUnitWithSubject:INHERIT_VALUE
                                   content:INHERIT_VALUE
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:INHERIT_VALUE
                                        to:nil
                                        cc:nil
                                       bcc:nil];
    
    //定制短信信息
    [publishContent addSMSUnitWithContent:[NSString stringWithFormat:@"%@/%@",title,content]];
    
    //定制有道云笔记信息
    [publishContent addYouDaoNoteUnitWithContent:INHERIT_VALUE
                                           title:INHERIT_VALUE
                                          author:@"星光秀"
                                          source:nil
                                     attachments:INHERIT_VALUE];
    
   
    
    //结束定制信息
    ////////////////////////
 
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:vc];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"星光秀分享"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}



#pragma mark - 第三方登录
+(void)logInWithThirdPart:(id)actionNum,...
{
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    va_list params; //定义一个指向个数可变的参数列表指针；
    va_start(params,actionNum);//va_start  得到第一个可变参数地址,
    id arg;
    
    if (actionNum) {
        //将第一个参数添加到array
        id prev = actionNum;
        [argsArray addObject:prev];
        
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        while( (arg = va_arg(params,id)) )
        {
            if ( arg ){
                [argsArray addObject:arg];
            }
            
        }
        //置空
        va_end(params);
        //这里循环 将看到所有参数
        for (NSNumber *num in argsArray) {
            NSLog(@"%d", [num intValue]);
        }
    }
    [ShareSDK getUserInfoWithType:1 authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        //
    }];
    
    return ;
}

+(void)logInWithShareSDK:(ShareType)type result:(void (^)(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)) blok
{
    [ShareSDK getUserInfoWithType:1 authOptions:nil result:blok];
    
}


@end

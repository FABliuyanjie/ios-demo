//
//  AppDelegate.m
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "MyAttentionViewController.h"
#import "NewVisiteViewController.h"
#import "MenuViewController.h"
#import "LeftViewController.h"
#import "MySegmentViewControllerSon.h"
//MARK:支付宝
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"

//MAKR:shareSDK
#import <ShareSDK/ShareSDK.h>

#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

//MARK:Jpush
#import "APService.h"
#import "JSON.h"
#import "Message.h"
#import "NSString+formatDate.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "VCchain.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //vcchain
    [VCchain sharedchain];
    
    //友盟
    [UMSocialData setAppKey:@"5373474456240b1cbc020bde"];
    [UMSocialWechatHandler setWXAppId:@"wxd95aad11f865fcd6" url:@"http://www.umeng.com/social"];
//    [UMSocialQQHandler setQQWithAppId:@"801076124" appKey:@"6ddc7dc46845644ae30fe189a2a296dd" url:@"http://www.umeng.com/social"];
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

    
    //创建root
    MenuViewController *menuVC=[MenuViewController shareMenu];
    
    RootViewController *rootVc=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    rootVc.tag=0;
    rootVc.title=@"直播";
    
    MyAttentionViewController *myAttentionVC=[[MyAttentionViewController alloc] initWithNibName:@"MyAttentionViewController" bundle:nil];
    myAttentionVC.title=@"关注";
    NewVisiteViewController *newVisitVC=[[NewVisiteViewController alloc] initWithNibName:@"NewVisiteViewController" bundle:nil];
    newVisitVC.title=@"最近访问";
    NSArray *arrayofsegment=[NSArray arrayWithObjects:rootVc,myAttentionVC,newVisitVC,nil];
    MySegmentViewControllerSon *mysegmentson=[[MySegmentViewControllerSon alloc] initMySegmentController:arrayofsegment imgarray:[NSArray arrayWithObjects:[UIImage imageNamed:@"myseg_zhibo.png"],[UIImage imageNamed:@"myseg_zhibo_selected.png"],[UIImage imageNamed:@"myseg_guanzhu.png"],[UIImage imageNamed:@"myseg_guanzhu_selected.png"],[UIImage imageNamed:@"myseg_zuijin.png"],[UIImage imageNamed:@"myseg_zuijin_selected.png"], nil]];
    mysegmentson.frame=CGRectMake(0,0, STATUSBAR_HEIGHT, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7);
    mysegmentson.segmenttopbarHeight=44;
    mysegmentson.segmentvaluechangebarHeight=44;
    mysegmentson.segmentTitle=@"星光秀";
    mysegmentson.issegmentvaluechangebarTop=NO;
    mysegmentson.hasName=NO;
    MynavViewController *loNav=[[MynavViewController alloc] initWithRootViewController:mysegmentson];
    if ([loNav respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        loNav.interactivePopGestureRecognizer.enabled = NO ;
    }
    loNav.navigationBar.hidden=YES;
    UINavigationController *myNav = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"MyNavigationController"];
    LeftViewController *leftVC=[[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    menuVC.leftVC=leftVC;
    menuVC.centerVC=loNav;
    menuVC.rightVC=myNav;
    
    
    /*
    
    //MARK:通知刷新用户信息
    SendNoti(kReflushUserInfo);
    
    //MARK:分享
    [ShareSDK registerApp:kShareSDKKey];
    
    [ShareSDK connectTencentWeiboWithAppKey:@"101003536" appSecret:@"8cb9805a1a3819f8a161f196f6a94952" redirectUri:@""];
    //QQ空间
    [ShareSDK connectQZoneWithAppKey:@"101003536" appSecret:@"8cb9805a1a3819f8a161f196f6a94952"];
    //微信
    [ShareSDK connectWeChatWithAppId:@"195f927365f5" wechatCls:[WXApi class]];
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3611880415"
                               appSecret:@"376b97e7c9e4cabe5f7d54f4af254640"
                             redirectUri:@"http://www.fabshow.cn"];
    
    //添加人人网应用
    [ShareSDK connectRenRenWithAppKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                            appSecret:@"f29df781abdd4f49beca5a2194676ca4"];
    
    
   */

    //监听用户信息变更
    [ShareSDK addNotificationWithName:SSN_USER_INFO_UPDATE
                               target:self
                               action:@selector(userInfoUpdateHandler:)];
    
    
    
    //MARK:JPush
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
    //设置用户名称和房间名

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];

    self.window.rootViewController=menuVC;
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark- ShareSDK
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    [self parse:url application:application];
     return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//    [ShareSDK handleOpenURL:url
//                 wxDelegate:self];
	return YES;


}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
}
//- (void)userInfoUpdateHandler:(NSNotification *)notif
//{
//    NSMutableArray *authList = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
//    if (authList == nil)
//    {
//        authList = [NSMutableArray array];
//    }
//    
//    NSString *platName = nil;
//    NSInteger plat = [[[notif userInfo] objectForKey:SSK_PLAT] integerValue];
//    switch (plat)
//    {
//        case ShareTypeSinaWeibo:
//            platName = NSLocalizedString(@"TEXT_SINA_WEIBO", @"新浪微博");
//            break;
//        case ShareType163Weibo:
//            platName = NSLocalizedString(@"TEXT_NETEASE_WEIBO", @"网易微博");
//            break;
//        case ShareTypeDouBan:
//            platName = NSLocalizedString(@"TEXT_DOUBAN", @"豆瓣");
//            break;
//        case ShareTypeFacebook:
//            platName = @"Facebook";
//            break;
//        case ShareTypeKaixin:
//            platName = NSLocalizedString(@"TEXT_KAIXIN", @"开心网");
//            break;
//        case ShareTypeQQSpace:
//            platName = NSLocalizedString(@"TEXT_QZONE", @"QQ空间");
//            break;
//        case ShareTypeRenren:
//            platName = NSLocalizedString(@"TEXT_RENREN", @"人人网");
//            break;
//        case ShareTypeSohuWeibo:
//            platName = NSLocalizedString(@"TEXT_SOHO_WEIBO", @"搜狐微博");
//            break;
//        case ShareTypeTencentWeibo:
//            platName = NSLocalizedString(@"TEXT_TENCENT_WEIBO", @"腾讯微博");
//            break;
//        case ShareTypeTwitter:
//            platName = @"Twitter";
//            break;
//        case ShareTypeInstapaper:
//            platName = @"Instapaper";
//            break;
//        case ShareTypeYouDaoNote:
//            platName = NSLocalizedString(@"TEXT_YOUDAO_NOTE", @"有道云笔记");
//            break;
//        case ShareTypeGooglePlus:
//            platName = @"Google+";
//            break;
//        case ShareTypeLinkedIn:
//            platName = @"LinkedIn";
//            break;
//        default:
//            platName = NSLocalizedString(@"TEXT_UNKNOWN", @"未知");
//    }
//    
//    id<ISSPlatformUser> userInfo = [[notif userInfo] objectForKey:SSK_USER_INFO];
//    BOOL hasExists = NO;
//    for (int i = 0; i < [authList count]; i++)
//    {
//        NSMutableDictionary *item = [authList objectAtIndex:i];
//        ShareType type = (ShareType)[[item objectForKey:@"type"] integerValue];
//        if (type == plat)
//        {
//            [item setObject:[userInfo nickname] forKey:@"username"];
//            hasExists = YES;
//            break;
//        }
//    }
//    
//    if (!hasExists)
//    {
//        NSDictionary *newItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                 platName,
//                                 @"title",
//                                 [NSNumber numberWithInteger:plat],
//                                 @"type",
//                                 [userInfo nickname],
//                                 @"username",
//                                 nil];
//        [authList addObject:newItem];
//    }
//    
//    [authList writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
//}

#pragma mark- applecation
//友盟分享需加内容
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnterForeground" object:nil];
}

//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark- AliPay 
//独立客户端回调函数


- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            @try {
                if ([verifier verifyString:result.resultString withSign:result.signString])
                {
                    [self paySuccess];
                    
                    //验证签名成功，交易结果无篡改
           		}
                
            }
            @catch (NSException *exception) {
                NSLog(@"verifyString faild");
            }
            @finally {
                NSLog(@"verifyString success");
            }
            
        }
        else
        {
            [self payFailed];
            //交易失败
        }
    }
    else
    {
        [self payFailed];
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}
-(void)paySuccess
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
-(void)payFailed
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

#pragma mark - 远程推送接收
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

#pragma mark- 本地推送接收
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict:%@",dict);
}

#pragma mark - 推送消息log

- (void)networkDidSetup:(NSNotification *)notification {
    
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
}

//MARK:接受到消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]);
    
    
    NSDictionary *contentdic=[content JSONValue];
    Message *message=[[Message alloc] init];
    message.sender.nickName=[contentdic valueForKey:@"user_name"];
    message.content=[contentdic valueForKey:@"content"];
    message.time=[NSString formatDate:[contentdic valueForKey:@"add_time"]];
    NSString *htmlStr = [NSString stringWithFormat:@"<font size = 15 color=#CC0033>%@ </font>"//time
                         "<font size = 20 color=blue><a href='liop://from.%d'>%@</a></font>"//发送者
                         "<font size = 15 color=black>说:</font>"//说：
                         "<font size = 15 color=black>%@</font>"//消息
                         ,message.time,message.sender.manID,message.sender.nickName,message.content];
    NSString *regexStr = @"\\[.*?\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *newHtmlStr = [regex stringByReplacingMatchesInString:htmlStr options:0 range:NSMakeRange(0, htmlStr.length) withTemplate:@"</font><img src='$0.png'><font size = 20 color=black>"];
    newHtmlStr=[newHtmlStr stringByReplacingOccurrencesOfString:@"[" withString:@""];
    newHtmlStr=[newHtmlStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSMutableDictionary *row = [NSMutableDictionary dictionary];
    [row setObject:newHtmlStr forKey:@"text"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"messagereceived" object:row];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
@end

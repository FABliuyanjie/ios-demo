//
//  CONST.h
//  XULIANG_5
//
//  Created by 李正峰 on 13-12-17.
//  Copyright (c) 2013年 FAB. All rights reserved.
//

#ifndef XULIANG_5_CONST_h
#define XULIANG_5_CONST_h
#import <Foundation/Foundation.h>
//MARK:屏幕适配
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) ==0)//< DBL_EPSILON )

//MARK:io7和iOS6适配
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

#ifdef DEBUG
#    define Log(fmt,...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#    define Log(...) {}
#endif

//MARK:客户端标识
#define APPKEY 1

//MARK:微博地址
#define WEIBO_URL @"http://weibo.com/xuliangcn"//

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)


#endif

#pragma mark - 提示
//MARK:网络提示
#define LOADING @"加载中....."
#define MESSAGE_NO_MORE @"没有更多的了"
#define MESSAGE_LOAD_OK @"加载完成"
#define CANNOT_LOAD @"网络故障"

#pragma mark - 消息

#define kLogInSuccess @"LoginSuccess"
#define kLogOutSuccess @"LogOutSuccess"
#define kReflushUserInfo @"ReflushUserInfo"
#define kLefttableselect @"lefttableselect"

#pragma mark- 支付宝

#define AppScheme @"ScreenShow"

//合作商户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define PartnerID @"2088211536968456"
//#define PartnerID @"2088801944194284"
//账户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define SellerID  @"2088211536968456"
//#define SellerID  @"750986570@qq.com"
//安全校验码（MD5）密钥  用签约支付宝账号登录ms.alipay.com后，在密钥管理页面获取
#define MD5_KEY @"oqq1bhg38szmzjmhlz6pue7uzauhn5on"

//alipay回调地址
#define AlipayReturnUrl @"http://s.fab.com.cn:8000/test/notify_url.php"
//商户私钥，自助生成
//#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMKEH5Vdut8hpatxx5FQOTUyzont140DkYVaEMqOlqJjNJNzpkAw9Zzvp0YGFSDKznMXKePtdmO9og8vd3SRyzJUufmh34/9ylFV/mecAoLzmMtMcY+jCatX04IjQanuFwkJ1iysr3wL/FHMYXnpb6CFdbgY7X31OvpRC2RExhEBAgMBAAECgYBEBLmanJUNE5IAGqBjkv7+OE768l2OpPHNBMqcWjIYhMJM0YMQLU6l2zPOC7B1sBVzL2Vpm47rn9M8pieKbrTzv3gj6Sc6dc7tUKJRpe1KKVenyptT5/y1N48cRSNK0HBGioIUOkVnPq/10jfQOEzT80hHT6krD4AszXgu/NHMAQJBAOf860iwZxDp1lKkqDmX+JT+1WarYmOETqCccps4Ft8GBzLHbwn0rwBVqBkPDu1oCOASxL5yA/9xHAytkX2yJ+ECQQDWpkwHq3MtRZugGkLWyzBWYbyWtMzuMOi3Nh/N7S3Pah3QZJRpZPWMtFGsSdhVat0uxeIeHxYWDuZqHNOr2I0hAkEA4CEt3BN58BBLXZrxYHtf0euGl2PbcdRA9tFPtIDzL9OuHrQppk+8x7D58APpYxrRAFOBu5GCJUfNVr5WQz9dYQJAIM+2241Hw+naCjU5dmAE+Y9jJp5onRh42li5r97Lm+Mav5pAXYQDTQjbWzzGhvgY62dwUy5pT+HjMuFJMgGeQQJAdaLdsDudYPS9SnKXd8yAXc7/2TmmjD8yVdlQBPXHBJ9U7AB26oj+9PHFNE8KcEJdqyUmfRxrF3p5AMVC7B0xeg=="
#define PartnerPrivKey  @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKttoJCbTfDiQwV/BS1l9ww/8jaVBbwWyt4dONmbWiKGNitLFHCWQfm4Vi6LtloKu1kl74OEH2LXFUFRMvja8SMTai73wE/OY3Kz8j3UWWWNP/iIOWmeRxYucKWT7bvDKZE8eg72+YK4nv8Iduj81I+u8BTAE8Fzx+/v+XGx5wWdAgMBAAECgYAysXRtzr85oG8ZTPqG9kQcBzzlDyRm/oZ3MEUDdIEu/GlAXC9rK8POyMgTc5U1Az9rmWA+j++IFvpeGljsZjIwJMKUs07SwhZWwFA5aJOI7ls4QY8sBcZ2R8MeAFsheUIUgX56AkKCYLTRk/N+bR+AfqvTFNx8oNudDsDLUHsmsQJBAOVC+tiLXfNwHx26fLohRv0hJx4DSOIswrUlLfYFwOkXHuVYoj+6BV+EzyCZpY4lAR93664a+BjpkuT67LauDScCQQC/a+0wOhh3wlWqT0wbyrmQioUozjo+Nb+NCakiCfu+tTeXE/UiPPHrQ0PQwox/x6Eu+6aoMiYe5PFhdyyRCdmbAkAMH/C4Rxae600Z+2ThSyU/+eLhuXa/T3K0tdSqcD91lF1z764VBLeIB7QUm0ugKuDWUzdJq+93EdNM/OBMAQR9AkBfo6TWO7CN5WK3vPbhy9/6/7qYMLGY83HJHdKLV0GYfyJPMYGAocKdMPZpD0rzbOJzfvg9gRDazrhrYge6T5mRAkBZlp5tRRrHaLNzLjXQGn5wBUplmRLYAxpj64gSvUW0bEy3t5PubkSCSBGwSlrhWK3e5UXyC4sJu5qmWfEycTyk"
//支付宝公钥，用签约支付宝账号登录ms.alipay.com后获取。
//#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"
#define AlipayPubKey  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


#pragma mark- shareSDK
#define kShareSDKKey @""


#endif






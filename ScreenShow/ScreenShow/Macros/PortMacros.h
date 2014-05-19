//
//  PortMacros.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-28.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#ifndef ScreenShow_PortMacros_h
#define ScreenShow_PortMacros_h
//基址
#define PORT_URLBASE @"http://100.100.40.214/index.php/Api/User/"

//在线人
#define PORT_ALLNUM PORT_URLBASE"allNum"

//获取手机验证码
//#define PORT_PHONEVERIFY PORT_URLBASE"registerVerify"
#define PORT_PHONEVERIFY PORT_URLBASE"verify"

//获取邮箱验证码
#define PORT_EMAILVERIFY PORT_URLBASE"registerVerify"
//普通注册
#define PORT_REGISTERNORMAL PORT_URLBASE"registerNormal"

//普通登录
#define PORT_USERINFO PORT_URLBASE"userInfo"

//图片登录
#define PORT_USERINFOTHIRD PORT_URLBASE"userInfoThird"

//用户信息
#define PORT_ACCOUNT PORT_URLBASE"account"

//更改手机号码
#define PORT_PHONECHANGE PORT_URLBASE"phoneChange"

//更改邮箱
#define PORT_EMAILCHANGE PORT_URLBASE"emailChange"

//更改头像
#define PORT_HEADIMAGE PORT_URLBASE"userImgChange"

//充值记录
#define PORT_RECHARGE PORT_URLBASE"recharge"

//消费记录
#define PORT_CONSUMELOG PORT_URLBASE"consumelog"

//支付宝充值
#define PORT_ALIPAYRECHARGE PORT_URLBASE"alipayRecharge"

//系统设置
#define PORT_SYSTEMSET PORT_URLBASE"systemSet"

//关于我们
#define PORT_ABOUTUS PORT_URLBASE"aboutUs"


#endif

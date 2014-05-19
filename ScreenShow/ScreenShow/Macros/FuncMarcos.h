//
//  FuncMarcos.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-27.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#ifndef ScreenShow_FuncMarcos_h
#define ScreenShow_FuncMarcos_h



#define LOGIN {[[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"Cookie"];[[NSUserDefaults standardUserDefaults]synchronize];}
#define LOGOUT {[[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Cookie"];[[NSUserDefaults standardUserDefaults]synchronize];}
#define IS_LOGIN [[NSUserDefaults standardUserDefaults]boolForKey:@"Cookie"]

#define SendNoti(message)  [[NSNotificationCenter defaultCenter]postNotificationName:message object:nil]



#endif

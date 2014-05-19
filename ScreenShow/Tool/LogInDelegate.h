//
//  LogInDelegate.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-27.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#ifndef ScreenShow_LogInDelegate_h
#define ScreenShow_LogInDelegate_h

@protocol loginDelegate <NSObject>

-(NSString*)loginSuccess;
-(NSString*)loginFailed;

@end


#endif

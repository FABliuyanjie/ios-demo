//
//  LoginHelper.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
@interface LoginHelper : NSObject
+(NSDictionary*)getUserInfoForm:(NSString*)platformName;
@end

//
//  Message.h
//  ScreenShow
//
//  Created by lee on 14-4-18.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Message : NSObject
@property(nonatomic,assign)int messageid;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)User *sender;
@property(nonatomic,strong)User *receicer;
@end

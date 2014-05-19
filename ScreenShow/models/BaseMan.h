//
//  baseMan.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMan : NSObject

@property(nonatomic,assign)NSInteger manType;//用户类型
@property(nonatomic,assign)NSUInteger manId;//用户id
@property(nonatomic,strong)NSString *nickName;//昵称
@property(nonatomic,strong)NSString *photoUrl;//头像
@property(nonatomic,assign)NSUInteger retainRed;//当前的红包
@property(nonatomic,assign)double accountMoney;//帐户余额
@property(nonatomic,assign)int accountFB;//帐户FB


@end

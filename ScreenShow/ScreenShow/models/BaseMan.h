//
//  baseMan.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMan : NSObject

@property(nonatomic,assign)NSInteger manID;//用户id
@property (nonatomic,copy)NSString *manName;//用户名
@property(nonatomic,strong)NSString *nickName;//昵称
@property(nonatomic,assign)NSInteger manType;//用户类型
@property(nonatomic,strong)NSString *photoUrl;//头像
@property(nonatomic,strong)NSString *consumeUrl;//消费等级
@property(nonatomic,assign)NSInteger retainRed;//当前的红包
@property(nonatomic,assign)double accountMoney;//帐户余额
@property(nonatomic,assign)NSInteger accountFB;//帐户FB


@property (nonatomic,assign) NSInteger userLevel;//用户等级
@property (nonatomic,copy) NSString *levelName;//用户称号
@property (nonatomic,copy) NSString *manPhone;
@property (nonatomic,copy) NSString *manEmail;
@property (nonatomic,copy) NSString *mxJmImg;



@end

//
//  RechargeRecord.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeRecord : NSObject

@property(nonatomic,strong)NSString *time;
@property(nonatomic,assign)int rechargeFB;//充值的FB
@property(nonatomic,assign)double rechargeMoney;//充值的rmb
@property(nonatomic,copy)NSString *reMark;//充值的rmb

@end

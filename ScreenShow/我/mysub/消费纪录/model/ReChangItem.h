//
//  ReChangItem.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReChangItem : NSObject
@property (nonatomic,copy) NSString *total_fee;
@property (nonatomic,copy) NSString *add_time;
@property (nonatomic,assign) NSInteger f_money;

-(instancetype)initWithDict:(NSDictionary*)dict;
-(NSString*)time;
@end

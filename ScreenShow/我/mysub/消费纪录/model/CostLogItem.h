//
//  CostLogItem.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CostLogItem : NSObject

@property (nonatomic,copy) NSString *gift_name;
@property (nonatomic,assign) NSInteger pnum;
@property (nonatomic,copy) NSString *add_time;
@property (nonatomic,assign) NSInteger money;


-(instancetype)initWithDict:(NSDictionary*)dict;
-(NSString*)time;
@end

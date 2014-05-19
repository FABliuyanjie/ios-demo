//
//  ReChangItem.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ReChangItem.h"

@implementation ReChangItem
-(instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.total_fee = dict[@"total_fee"];
        self.add_time = dict[@"add_time"];
        self.f_money = [dict[@"f_money"]integerValue];
    }
    return self;
}

-(NSString*)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *timeSp = [NSDate dateWithTimeIntervalSince1970:[self.add_time integerValue]];
    NSString *time = [formatter stringFromDate:timeSp];
    return time;
    
}
@end

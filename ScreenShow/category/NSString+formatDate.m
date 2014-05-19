//
//  NSString+formatDate.m
//  ScreenShow
//
//  Created by lee on 14-5-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "NSString+formatDate.h"

@implementation NSString (formatDate)

+(NSString *)formatDate:(NSString *)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *timeSp = [NSDate dateWithTimeIntervalSince1970:[str longLongValue]];
    NSString *time = [formatter stringFromDate:timeSp];
    return time;
}
+(NSString *)formatDatefromnow:(NSString *)str
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[str longLongValue]];
   NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH小时mm分"];
    
    NSDate *timeSp = [NSDate dateWithTimeIntervalSinceNow:-timeInterval];
    NSString *time = [formatter stringFromDate:timeSp];
    return time;
}
@end

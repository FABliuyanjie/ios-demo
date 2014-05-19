//
//  ConsumerRecord.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumerRecord : NSObject
@property(nonatomic,strong)NSString *time;
@property(nonatomic,copy)NSString *giftName;
@property(nonatomic,assign)int giftAmount;
@property(nonatomic,assign)int costFB;
@end

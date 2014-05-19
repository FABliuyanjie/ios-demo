//
//  Topic.h
//  ScreenShow
//
//  Created by lee on 14-3-18.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property(nonatomic,assign)int topicid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)int num;//对应当前话题下对应的主播数量
@end

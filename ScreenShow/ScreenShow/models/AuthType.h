//
//  AuthType.h
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-26.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthType : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * pinyin;
@property (nonatomic, assign) BOOL type;
@property (nonatomic, assign) int tag;

@end

//
//  Message.m
//  ScreenShow
//
//  Created by lee on 14-4-18.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id)init {
    self = [super init];  // Call a designated initializer here.
    if (self != nil) {
        // 省略其他细节
        self.sender=[[User alloc] init];
    }
    return self;
}
@end

//
//  VCchain.m
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "VCchain.h"

@implementation VCchain
+ (instancetype)sharedchain
{
    static VCchain *sharedVCchain = nil;
    @synchronized(sharedVCchain)
    {
        if (sharedVCchain == nil)
        {
            sharedVCchain = [[VCchain alloc] init];
        }
    }
    return sharedVCchain;
}
@end

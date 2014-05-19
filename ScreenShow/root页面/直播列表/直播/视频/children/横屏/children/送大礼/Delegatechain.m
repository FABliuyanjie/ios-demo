//
//  Delegatechain.m
//  ScreenShow
//
//  Created by lee on 14-5-16.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "Delegatechain.h"

@implementation Delegatechain

-(void)didwritenum:(int)num
{
    [_delegate Delegatechain:num];
}
@end

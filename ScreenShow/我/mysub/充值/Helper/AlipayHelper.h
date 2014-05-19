//
//  AlipayHelper.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-14.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlixLibService.h"
#import "AlixPayOrder.h"
@interface AlipayHelper : NSObject
{
@public
     SEL _result;
    void (^_success)();
    void (^_failure)();
    

}
@property (nonatomic,weak) UIView *view;
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
-(void)paymentResult:(NSString *)result;

+(void)payOrder:(AlixPayOrder*)product inView:(UIView*)view paySuccess:(void (^)())success payFailure:(void (^)())failure;

@end

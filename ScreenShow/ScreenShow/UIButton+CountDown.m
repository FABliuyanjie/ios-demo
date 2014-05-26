//
//  UIButton+CountDown.m
//  ScreenShow
//
//  Created by 李正峰 on 14-5-26.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)

-(void)startCountDown
{
  NSTimer *timer =   [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(nilSymbol) userInfo:nil repeats:YES];
    self.timer = timer;
}

-(void)perSecond
{
    static NSInteger second = 60;
    self.refreshHandle(second);
    if (second==0) {
        [self stopCountDown];
        self.endHanle();
        return;
    }
    
     second--;
}
-(void)stopCountDown
{
    [self.timer invalidate];
}

@end

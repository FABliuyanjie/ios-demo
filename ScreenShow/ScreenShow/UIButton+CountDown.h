//
//  UIButton+CountDown.h
//  ScreenShow
//
//  Created by 李正峰 on 14-5-26.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PorcessHandle)(NSInteger);
typedef void(^Endhandle)();

@interface UIButton (CountDown)

@property (nonatomic) NSTimer *timer;
@property (nonatomic,strong) PorcessHandle refreshHandle;
@property (nonatomic,copy) Endhandle endHanle;

-(void)startCountDown;
-(void)stopCountDown;

@end

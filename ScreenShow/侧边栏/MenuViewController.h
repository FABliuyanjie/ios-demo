//
//  MenuViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-19.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UIGestureRecognizerDelegate>


@property(nonatomic,strong)UIPanGestureRecognizer * pan;
@property(nonatomic,strong)UIViewController *leftVC;
@property(nonatomic,strong)UIViewController *centerVC;
@property(nonatomic,strong)UIViewController *rightVC;
@property(nonatomic,strong)UIView *viewslipper;
@property(nonatomic,assign)int showtype;//0 左边显示  1 中间显示 2.右边显示
@property(nonatomic,assign)CGPoint oldPoint;
+ (instancetype)shareMenu;
@end

//
//  EmotionScroller.h
//  ScreenShow
//
//  Created by lee on 14-4-21.
//  Copyright (c) 2014年 lee. All rights reserved.
//


@protocol EmotionScrollerdelegate <NSObject>
-(void)didselectemotion:(int)index;
@end
#import <UIKit/UIKit.h>


@interface EmotionScroller : UIScrollView
@property(nonatomic,assign) id<EmotionScrollerdelegate>delegate1;
@property(nonatomic,strong)NSMutableArray *imgarray;
@property(nonatomic,assign)int colnum;
-(void)setColnum:(int)colnum;
@end

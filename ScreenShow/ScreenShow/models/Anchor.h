//
//  Anchor.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMan.h"
@interface Anchor : BaseMan

@property(nonatomic,assign)int anchorid;
@property(nonatomic,assign)NSInteger level;//等级
@property(nonatomic,strong)NSString *niceNum;//靓号
@property(nonatomic,strong)NSMutableArray *fansArray;//粉丝列表
@property(nonatomic,assign)int audicecount;
@property(nonatomic,assign)int isonline;
@property(nonatomic,strong)NSString *talknotice;
@property(nonatomic,strong)NSString *rankpic;
@end

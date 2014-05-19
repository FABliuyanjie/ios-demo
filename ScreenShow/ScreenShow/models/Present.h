//
//  Present.h
//  ScreenShow
//
//  Created by lee on 14-4-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Present : NSObject
@property(nonatomic,assign)int presentid;
@property(nonatomic,strong)NSString *picurl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)BOOL isselected;
@end

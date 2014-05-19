//
//  Delegatechain.h
//  ScreenShow
//
//  Created by lee on 14-5-16.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Delegatechainprotocal <NSObject>
-(void)Delegatechain:(int)num;
@end
@interface Delegatechain : NSObject
@property(nonatomic,strong)id<Delegatechainprotocal> delegate;

@end

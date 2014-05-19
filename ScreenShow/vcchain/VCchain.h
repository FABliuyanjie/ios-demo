//
//  VCchain.h
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveStudioViewController.h"
#import "ScreenViewController.h"

@interface VCchain : NSObject
+ (instancetype)sharedchain;
@property(nonatomic,weak)LiveStudioViewController *livestudio;
@property(nonatomic,weak)ScreenViewController *screenvc;
@end

//
//  LiveStudio.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Anchor.h"

@interface LiveStudio : NSObject
@property(nonatomic,strong)NSString *LiveStreamUrl;
@property(nonatomic,strong)Anchor *anchor;
@property(nonatomic,strong)NSMutableArray *audienceArray;

@end

//
//  ToolpushLivestudioViewController.h
//  ScreenShow
//
//  Created by lee on 14-5-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"

@interface ToolpushLivestudioViewController : UIViewController
+(void)pushLiveStudioVC:(Anchor *)anchor anchorItems:(NSMutableArray *)anchorItems vc:(UIViewController *)vc;
@end

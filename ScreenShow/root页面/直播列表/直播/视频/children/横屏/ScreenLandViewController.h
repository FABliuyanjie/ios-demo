//
//  ScreenLandViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "BigPresentViewController.h"
#import "RCLabel.h"
#import "RCViewCell.h"
#import "EmotionScroller.h"

@interface ScreenLandViewController : UIViewController<UITextFieldDelegate,RTLabelDelegate,EmotionScrollerdelegate,UITableViewDataSource,UITableViewDelegate>
{
    BigPresentViewController *bigPresentVC;
    UIButton *btnKeyboardDown;
    BOOL is4hide;
    BOOL isControlhide;
    NSMutableArray *controlArray;
    BOOL ischatcontentshow;
    BOOL isemotionshow;
}
@property(nonatomic,strong)NSMutableArray *anchorarray;//所有主播
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)Anchor *anchor;

@end

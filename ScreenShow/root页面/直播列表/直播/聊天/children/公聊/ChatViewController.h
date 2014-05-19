//
//  ChatViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "RCLabel.h"
#import "EmotionScroller.h"
#import "BigPresentViewController.h"

@interface ChatViewController : UIViewController<UITextFieldDelegate,RTLabelDelegate,EmotionScrollerdelegate>
{
    EmotionScroller *emotionscroller;
    BOOL isemotionboardshow;
 
    NSMutableArray *imgarray;
    NSMutableArray *imgnamearray;
    BigPresentViewController *bigPresentVC;
    IBOutlet UIButton *btnmotionkeyboard;
   
}
@property(nonatomic,strong)NSMutableArray *anchorarray;//所有主播
@property(nonatomic,strong)IBOutlet UITableView *table;
@property(nonatomic,strong)IBOutlet UITextField *textfield;
@property(nonatomic,strong)IBOutlet UIView *bottomview;
@property(nonatomic,strong)UIButton *btnKeyboardDown;
@property(nonatomic,strong)Anchor *anchor;
@property(nonatomic,strong)NSMutableArray *dataArray;
-(IBAction)btnSendPresentClicked:(id)sender;
-(IBAction)btninfoClicked:(id)sender;
-(IBAction)btnemotionClicked:(id)sender;
@end

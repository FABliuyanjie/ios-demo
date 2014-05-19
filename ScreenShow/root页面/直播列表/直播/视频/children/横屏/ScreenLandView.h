//
//  ScreenLandView.h
//  ScreenShow
//
//  Created by lee on 14-3-14.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionScroller.h"
#import "Personalinfo.h"

@interface ScreenLandView : UIView

{
    
}
@property(nonatomic,strong)NSMutableArray *imgarray;
@property(nonatomic,strong)NSMutableArray *imgnamearray;

@property(nonatomic,strong)EmotionScroller *emotionscroller;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *controlArray;
@property(nonatomic,strong)UIView *topbar;
@property(nonatomic,strong)UILabel *labeltitle;
@property(nonatomic,strong)UIButton *btnBack;
@property(nonatomic,strong)UIButton *btnLogout;
@property(nonatomic,strong)UIButton *btnleft;
@property(nonatomic,strong)UIButton *btnright;


@property(nonatomic,strong)UIButton *btnPortait;
@property(nonatomic,strong)UIButton *btnKeyboard;
@property(nonatomic,strong)UIButton *btnInfo;
@property(nonatomic,strong)UIButton *btnBg;
@property(nonatomic,strong)UILabel *labelAlter;
@property(nonatomic,strong)UIView *toolbarofkeyboard;
@property(nonatomic,strong)UIButton *btnemotion;
@property(nonatomic,strong)UIButton *btnsend;

@property(nonatomic,strong)UIButton *btnAttention;
@property(nonatomic,strong)UIButton *btnPersonalinfo;
@property(nonatomic,strong)UIButton *btnBigpresent;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *viewtansparent;
@property(nonatomic,strong)Personalinfo *personalinfoview;
@end

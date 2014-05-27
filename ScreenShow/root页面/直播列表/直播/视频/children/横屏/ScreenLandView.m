//
//  ScreenLandView.m
//  ScreenShow
//
//  Created by lee on 14-3-14.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ScreenLandView.h"

@implementation ScreenLandView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIFont *font=[UIFont fontWithName:@"Arial" size:14];

        
        self.btnBg=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnBg.titleLabel.font=font;
        self.btnBg.backgroundColor=[UIColor clearColor];
        [self addSubview:self.btnBg];
        
        [self.btnBg sizeToFit];
        [self.btnBg setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBg attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        
        
        self.topbar=[[UIView alloc] initWithFrame:CGRectZero];
        self.topbar.backgroundColor=[UIColor whiteColor];
        self.topbar.alpha=0.5;
        [self addSubview:self.topbar];
        
        
        
        [self.topbar sizeToFit];
        [self.topbar setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topbar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(44)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topbar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topbar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        
        
        
        
        self.labeltitle=[[UILabel alloc] initWithFrame:CGRectZero];
        self.labeltitle.textAlignment=NSTextAlignmentCenter;
        self.labeltitle.textColor=[UIColor blackColor];
        self.labeltitle.backgroundColor=[UIColor clearColor];
        [self.topbar addSubview:self.labeltitle];
        [self.labeltitle sizeToFit];
        [self.labeltitle setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labeltitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labeltitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labeltitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labeltitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(100)]];
        
        
        
        self.btnBack=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnBack.titleLabel.font=font;
        [self.btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
        [self.btnBack setImage:[UIImage imageNamed:@"btn_back_highlight.png"] forState:UIControlStateHighlighted];
        [self.topbar addSubview:self.btnBack];
        
        [self.btnBack sizeToFit];
        [self.btnBack setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(39)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBack attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        
        
        
        self.btnLogout=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnLogout setImage:[UIImage imageNamed:@"land_vc_image_btnlogout.png"] forState:UIControlStateNormal];
        [self.topbar addSubview:self.btnLogout];
        
        
        [self.btnLogout sizeToFit];
        [self.btnLogout setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(39)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topbar attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0)]];
        
        
        self.btnleft=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnleft.backgroundColor=[UIColor blueColor];
        [self.btnleft setImage:[UIImage imageNamed:@"livestudiovc_btntoleft.png"] forState:UIControlStateNormal];
        [self addSubview:self.btnleft];
        
        
        [self.btnleft sizeToFit];
        self.btnright.tag=0;
        [self.btnleft setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnleft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(30)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnleft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(100.0f)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnleft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.0f constant:(70)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnleft attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(10)]];
        
        
        
        
        self.btnright=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnright.backgroundColor=[UIColor blueColor];
        self.btnright.tag=1;
        [self.btnright setImage:[UIImage imageNamed:@"livestudiovc_btntoright.png"] forState:UIControlStateNormal];
        [self addSubview:self.btnright];
        
        
        [self.btnright sizeToFit];
        [self.btnright setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnright attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(30)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnright attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(100.0f)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnright attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.0f constant:(70)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnright attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-10)]];
        
        
        
        
        
        self.btnPersonalinfo=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnPersonalinfo setTitle:@"资料" forState:UIControlStateNormal];
        self.btnPersonalinfo.tag=101;
        [self.btnPersonalinfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnPersonalinfo setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn"] forState:UIControlStateNormal];
        [self.btnPersonalinfo setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn_highlight"] forState:UIControlStateHighlighted];
        self.btnPersonalinfo.backgroundColor=[UIColor clearColor];
        self.btnPersonalinfo.titleLabel.font=font;
        [self addSubview:self.btnPersonalinfo];
        
        
        
        [self.btnPersonalinfo sizeToFit];
        [self.btnPersonalinfo setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPersonalinfo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(40)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPersonalinfo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(30)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPersonalinfo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(20)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPersonalinfo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(-60)]];
        
        
        
        
        
        
        self.btnBigpresent=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnBigpresent.titleLabel.font=font;
        self.btnBigpresent.tag=103;
        [self.btnBigpresent setImage:[UIImage imageNamed:@"chat_vc_present.png"] forState:UIControlStateNormal];
        [self addSubview:self.btnBigpresent];
        
        [self.btnBigpresent sizeToFit];
        [self.btnBigpresent setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBigpresent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(30)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBigpresent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(30)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBigpresent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(20)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBigpresent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(-10)]];
        
        
    
        
        
       
        
        self.btnPortait=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnPortait setImage:[UIImage imageNamed:@"land_vc_halfscreen.png"] forState:UIControlStateNormal];
        self.btnPortait.titleLabel.font=font;
        [self addSubview:self.btnPortait];
        
        
        self.btnAttention=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnAttention.titleLabel.font=font;
        self.btnAttention.tag=200;
        self.btnAttention.backgroundColor=[UIColor clearColor];
        [self.btnAttention setTitle:@"关注" forState:UIControlStateNormal];
        [self addSubview:self.btnAttention];
        [self.btnAttention sizeToFit];
        [self.btnAttention setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAttention attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnPortait attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAttention attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(20)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAttention attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(20)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAttention attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnPortait attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(-30)]];
        
        [self.btnPortait setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.btnPortait sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPortait attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(20)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPortait attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(20)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPortait attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(-100)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPortait attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-30)]];
        
        
        self.btnInfo=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnInfo.backgroundColor=[UIColor clearColor];
        self.btnInfo.titleLabel.font=font;
        self.btnInfo.titleLabel.textColor=[UIColor blackColor];
        [self.btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnInfo setTitle:@"消息" forState:UIControlStateNormal];
        [self.btnInfo setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn"] forState:UIControlStateNormal];
        [self.btnInfo setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn_highlight"] forState:UIControlStateHighlighted];
        [self addSubview:self.btnInfo];
        
        [self.btnInfo setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.btnInfo sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(45)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(31)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(-10)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-20)]];
        
        
        self.btnKeyboard=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnKeyboard.backgroundColor=[UIColor clearColor];
        [self.btnKeyboard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnKeyboard.titleLabel.font=font;
        [self.btnKeyboard setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn"] forState:UIControlStateNormal];
        [self.btnKeyboard setBackgroundImage:[UIImage imageNamed:@"land_vc_bg_btn_highlight"] forState:UIControlStateHighlighted];
        
        [self.btnKeyboard setTitle:@"聊天" forState:UIControlStateNormal];
        [self addSubview:self.btnKeyboard];
        
        
        
        [self.btnKeyboard setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.btnKeyboard sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnKeyboard attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(45)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnKeyboard attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(31)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnKeyboard attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.btnInfo attribute:NSLayoutAttributeTop multiplier:1.0f constant:(-20)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnKeyboard attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-20)]];
        
        
        self.toolbarofkeyboard=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT, 30)];
        self.toolbarofkeyboard.backgroundColor=[UIColor greenColor];
        [self addSubview:self.toolbarofkeyboard];
        
        
        self.btnemotion=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.toolbarofkeyboard addSubview:self.btnemotion];
        [self.btnemotion setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.btnemotion sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnemotion attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(30)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnemotion attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(30)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnemotion attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnemotion attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        
        
        
        self.btnsend=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnsend setTitle:@"发送" forState:UIControlStateNormal];
        [self.toolbarofkeyboard addSubview:self.btnsend];
        [self.btnsend setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.btnsend sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.btnemotion attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(50)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        
        
        self.textField=[[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.backgroundColor=[UIColor whiteColor];
        [self.toolbarofkeyboard addSubview:self.textField];
        
        [self.textField setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.textField sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnsend attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(-10)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnemotion attribute:NSLayoutAttributeRight multiplier:1.0f constant:(10)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.toolbarofkeyboard attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        
        
        
        
        self.table=[[UITableView alloc] initWithFrame:CGRectZero];
        self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.table.backgroundColor=[UIColor clearColor];
        [self addSubview:self.table];
        [self.table setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.table sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnPersonalinfo attribute:NSLayoutAttributeRight multiplier:1.0f constant:(10)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnInfo attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(-10)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnPersonalinfo attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
        
        self.viewtansparent=[[UIView alloc] initWithFrame:CGRectZero];
        self.viewtansparent.backgroundColor=[UIColor whiteColor];
        self.viewtansparent.alpha=0.3f;
        [self insertSubview:self.viewtansparent belowSubview:self.table];
        [self.viewtansparent setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.viewtansparent sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewtansparent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewtansparent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewtansparent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewtansparent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        
        
        self.emotionscroller=[[EmotionScroller alloc] initWithFrame:CGRectZero];
        self.emotionscroller.backgroundColor=[UIColor lightGrayColor];
        [self.emotionscroller setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.emotionscroller sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.emotionscroller attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.emotionscroller attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.emotionscroller attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.emotionscroller attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(150)]];
        
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"Personalinfo" owner:self options:nil];
        self.personalinfoview=[array objectAtIndex:0];
        CGRect rect=self.personalinfoview.frame;
        rect.origin.x=(SCREEN_HEIGHT-self.personalinfoview.frame.size.width)/2;
        rect.origin.y=(SCREEN_WIDTH-self.personalinfoview.frame.size.height)/2;
        self.personalinfoview.frame=rect;

        
        
        self.personalinfoview.hidden=YES;
        [self addSubview:self.personalinfoview];
        
        self.imgarray=[[NSMutableArray alloc] init];
        self.imgnamearray=[[NSMutableArray alloc] init];
        for (int i=1; i<24; i++) {
            UIImage *image=nil;
            NSString *name=@"";
            if (i<10) {
                image=[UIImage imageNamed:[NSString stringWithFormat:@"00%d.png",i]];
                name=[NSString stringWithFormat:@"00%d",i];
            }
            else
            {
                image=[UIImage imageNamed:[NSString stringWithFormat:@"0%d.png",i]];
                name=[NSString stringWithFormat:@"0%d",i];
            }
            [self.imgarray addObject:image];
            [self.imgnamearray addObject:name];
        }
        self.emotionscroller.imgarray=self.imgarray;
        self.emotionscroller.hidden=YES;
        [self addSubview:self.emotionscroller];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end

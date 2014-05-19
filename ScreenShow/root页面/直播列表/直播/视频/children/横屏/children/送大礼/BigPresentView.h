//
//  BigPresentView.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigPresentView : UIView
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)float bottomheight;
@property(nonatomic,strong)UILabel *labelleftmoneynote;
@property(nonatomic,strong)UILabel *labelleftmoney;
@property(nonatomic,strong)UILabel *labelnotenote;
@property(nonatomic,strong)UILabel *labelnotenote1;
@property(nonatomic,strong)UILabel *labelnote;
@property(nonatomic,strong)UILabel *labelnote1;


@property(nonatomic,strong)UILabel *labelnum;
@property(nonatomic,strong)UIButton *btnnum;

@property(nonatomic,strong)UIButton *btnsend;
@property(nonatomic,strong)UIButton *btnpay;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UIView *bottomview;
@property(nonatomic,strong)UIButton *btnx;
@end

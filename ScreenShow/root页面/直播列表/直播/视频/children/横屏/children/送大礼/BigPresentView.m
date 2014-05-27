//
//  BigPresentView.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BigPresentView.h"
#import "ScreenShow-Prefix.pch"
#import <QuartzCore/QuartzCore.h>

@implementation BigPresentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor=[UIColor blueColor];
        NSLog(@"%@",self);
        self.bottomheight=70;
        // Initialization code
        
        
        self.bgview=[[UIView alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, self.frame.size.height-self.bottomheight-15)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        self.bgview.layer.borderColor=[[UIColor blackColor] CGColor];
        self.bgview.layer.borderWidth=1;
        [self.bgview setClipsToBounds:NO];
        [self.bgview.layer setMasksToBounds:NO];
        maskLayer.frame = self.bgview.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgview.layer.mask = maskLayer;
        
        
        CAShapeLayer *strokeLayer = [CAShapeLayer layer];
        strokeLayer.path = maskPath.CGPath;
        strokeLayer.fillColor = [UIColor clearColor].CGColor;
        strokeLayer.strokeColor = [UIColor blackColor].CGColor;
        strokeLayer.lineWidth = 2;
        [self.bgview.layer addSublayer:strokeLayer];
        
        
        
        self.bgview.backgroundColor=[UIColor whiteColor];
        [self.bgview setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.bgview sizeToFit];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.0f constant:(15.0f)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(-1*self.bottomheight-15.0)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bgview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0)]];
        
        self.btnx=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnx setImage:[UIImage imageNamed:@"bigpresent_btnx.png"] forState:UIControlStateNormal];
        self.btnx.backgroundColor=[UIColor clearColor];
        [self.btnx sizeToFit];
        [self.btnx setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnx attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:(5.0f)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnx attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(25)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnx attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(25)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnx attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-2)]];
        
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator=NO;
        [self.bgview sizeToFit];
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bgview attribute:NSLayoutAttributeTop multiplier:1.0f constant:(5.0f)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bgview attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(-5)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bgview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(25)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bgview attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-25)]];
        
        
        self.bottomview=[[UIView alloc] initWithFrame:CGRectZero];
        [self.bgview sizeToFit];
        self.bottomview.backgroundColor=[UIColor colorWithRed:54/255.0 green:46/255.0 blue:58/255.0 alpha:1.0];
        [self.bottomview setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0.0f)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(self.bottomheight)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
        
        
        
        
        self.labelleftmoneynote=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelleftmoneynote sizeToFit];
        self.labelleftmoneynote.text=@"余额:";
        self.labelleftmoneynote.textColor=[UIColor whiteColor];
        [self.labelleftmoneynote setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoneynote attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoneynote attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(5.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoneynote attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoneynote attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(40)]];
        
        
        self.labelleftmoney=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelleftmoney sizeToFit];
        self.labelleftmoney.textColor=[UIColor colorWithRed:233/255.0 green:187/255.0 blue:117/255.0 alpha:1.0];
        self.labelleftmoney.text=@"";
        [self.labelleftmoney setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoney attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoney attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelleftmoneynote attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoney attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelleftmoney attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(200)]];
        
        
        
        
        self.labelnotenote=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelnotenote sizeToFit];
        self.labelnotenote.textColor=[UIColor whiteColor];
        [self.labelnotenote setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout
        self.labelnotenote.text=@"请选择";
        self.labelnotenote.textAlignment=NSTextAlignmentCenter;
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelleftmoneynote attribute:NSLayoutAttributeBottom multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(5.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(45)]];
        
        self.labelnote=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelnote sizeToFit];
        self.labelnote.textColor=[UIColor colorWithRed:233/255.0 green:187/255.0 blue:117/255.0 alpha:1.0];
        [self.labelnote setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout
        self.labelnote.text=@"礼物";
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelnotenote attribute:NSLayoutAttributeTop multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelnotenote attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(30)]];
        
        
        
        self.labelnotenote1=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelnotenote1 sizeToFit];
        self.labelnotenote1.textColor=[UIColor whiteColor];
        [self.labelnotenote1 setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout
        self.labelnotenote1.text=@"";
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelnote attribute:NSLayoutAttributeTop multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelnote attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnotenote1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(28)]];
        
        self.labelnote1=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.labelnote1 sizeToFit];
        self.labelnote1.textColor=[UIColor colorWithRed:233/255.0 green:187/255.0 blue:117/255.0 alpha:1.0];
        [self.labelnote1 setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout
        self.labelnote1.text=@"送给";
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelnotenote1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelnotenote1 attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnote1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(200)]];
        
        
        self.labelnum=[[UILabel alloc] initWithFrame:CGRectZero];
        self.labelnum.text=@"数量:";
        self.labelnum.textColor=[UIColor whiteColor];
        [self.labelnum sizeToFit];
        [self.labelnum setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelnotenote attribute:NSLayoutAttributeBottom multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(5.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.33f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.labelnum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(35)]];
        
        self.btnnum=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnnum setTitle:@"请选择数量" forState:UIControlStateNormal];
        [self.btnnum sizeToFit];
        [self.btnnum setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnnum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelnum attribute:NSLayoutAttributeTop multiplier:1.0 constant:(0)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnnum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelnum attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnnum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.labelnum attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(0)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnnum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(100)]];
        
        
        self.btnpay=[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnpay setTitle:@"支付" forState:UIControlStateNormal];
        [self.btnpay setBackgroundImage:[UIImage imageNamed:@"chat_vc_bg_btnsend.png"] forState:UIControlStateNormal];
        self.btnpay.backgroundColor=[UIColor clearColor];
        
        
        [self.btnpay sizeToFit];
        [self.btnpay setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnpay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeRight multiplier:1.0 constant:(-10)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnpay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeTop multiplier:1.0f constant:(5.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnpay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(25)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnpay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(50)]];
        
        
        self.btnsend=[[UIButton alloc] initWithFrame:CGRectZero];
        self.btnsend.backgroundColor=[UIColor clearColor];
        [self.btnsend setTitle:@"赠送" forState:UIControlStateNormal];
        [self.btnsend setBackgroundImage:[UIImage imageNamed:@"chat_vc_bg_btnsend.png"] forState:UIControlStateNormal];
        [self.btnsend sizeToFit];
        [self.btnsend setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeRight multiplier:1.0 constant:(-10)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(-5.0f)]];
        
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(25)]];
        [self.bottomview addConstraint:[NSLayoutConstraint constraintWithItem:self.btnsend attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomview attribute:NSLayoutAttributeWidth multiplier:0.0f constant:(50)]];
        
        
        UIFont *font=[UIFont systemFontOfSize:14.0f];
        self.labelleftmoneynote.font=font;
        self.labelleftmoney.font=font;
        self.labelnotenote.font=font;
        self.labelnotenote1.font=font;
        self.labelnote.font=font;
        self.labelnote1.font=font;
        self.labelnum.font=font;
        
        self.labelleftmoneynote.backgroundColor=[UIColor clearColor];
        self.labelnotenote.backgroundColor=[UIColor clearColor];
        self.labelnum.backgroundColor=[UIColor clearColor];
        self.labelleftmoney.backgroundColor=[UIColor clearColor];
        self.labelnote.backgroundColor=[UIColor clearColor];
        self.labelnote1.backgroundColor=[UIColor clearColor];
        [self addSubview:self.bgview];
        [self.bgview addSubview:self.tableView];
        
        [self addSubview:self.btnx];
        [self addSubview:self.bottomview];
        
        [self.bottomview addSubview:self.labelleftmoneynote];
        [self.bottomview addSubview:self.labelleftmoney];
        [self.bottomview addSubview:self.labelnotenote];
        [self.bottomview addSubview:self.labelnote];
        [self.bottomview addSubview:self.labelnum];
        [self.bottomview addSubview:self.btnnum];
        [self.bottomview addSubview:self.btnpay];
        [self.bottomview addSubview:self.btnsend];
        [self.bottomview addSubview:self.labelnotenote1];
        [self.bottomview addSubview:self.labelnote1];
        
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

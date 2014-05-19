//
//  MySegmentViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySegmentViewController : UIViewController
{
    UILabel *labeloftitle;
    NSMutableArray *btnArray;
    NSArray *imgarray;
}
@property(nonatomic,assign)BOOL hasName;
@property(nonatomic,assign)CGRect frame;
@property(nonatomic,strong)NSString *segmentTitle;//顶部bartitle
@property(nonatomic,strong)UIView *segmenttopbar;//顶部bar
@property(nonatomic,strong)UIButton *leftItem;//左侧按钮
@property(nonatomic,strong)UIButton *rightItem;//右侧按钮
@property(nonatomic,assign)BOOL issegmentvaluechangebarTop;//判断切换  按钮在视图上方还是下面
@property(nonatomic,strong)NSArray *vcArray;
@property(nonatomic,assign)int selectindex;
@property(nonatomic,assign)int segmenttopbarHeight;
@property(nonatomic,assign)int segmentvaluechangebarHeight;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)UIColor *colorselected;

- (id)initMySegmentController:(NSArray *)vcArray imgarray:(NSArray *)primgarray;
@end

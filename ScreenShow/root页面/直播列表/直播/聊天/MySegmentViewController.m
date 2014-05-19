//
//  MySegmentViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MySegmentViewController.h"
#import "ScreenShow-Prefix.pch"

@interface MySegmentViewController ()

@end

@implementation MySegmentViewController


- (id)initMySegmentController:(NSArray *)vcArray imgarray:(NSArray *)primgarray
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.vcArray=vcArray;
        btnArray=[[NSMutableArray alloc] init];
        imgarray=primgarray;
        self.hasName=YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //segmentbar  顶部bar
    self.segmenttopbar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH,self.segmenttopbarHeight)];
    labeloftitle=[[UILabel alloc] initWithFrame:CGRectMake((self.segmenttopbar.frame.size.width-100)/2, 0, 100,self.segmenttopbarHeight)];
    labeloftitle.textAlignment=NSTextAlignmentCenter;
    labeloftitle.text=self.segmentTitle;
    [self.segmenttopbar addSubview:labeloftitle];
    
    self.segmenttopbar.backgroundColor=[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0];
    [self.view addSubview:self.segmenttopbar];
    if (self.segmenttopbarHeight==0) {
        self.segmenttopbar.hidden=YES;
    }
    
    //leftitem
    self.leftItem=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, self.segmenttopbarHeight)];
    [self.leftItem setTitle:@"left" forState:UIControlStateNormal];
    self.leftItem.backgroundColor=[UIColor clearColor];
    [self.segmenttopbar addSubview:self.leftItem];
    
    //rightitem
    self.rightItem=[[UIButton alloc] initWithFrame:CGRectMake(self.segmenttopbar.frame.size.width-39, 0, 39, self.segmenttopbarHeight)];
    [self.rightItem setTitle:@"right" forState:UIControlStateNormal];
    self.rightItem.backgroundColor=[UIColor clearColor];
    [self.segmenttopbar addSubview:self.rightItem];
    
    
    
    for (int i=0; i<self.vcArray.count; i++) {
        if (self.issegmentvaluechangebarTop) {
            UIViewController *VC=[self.vcArray objectAtIndex:i];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(i*SCREEN_FRAME_WIDTH/self.vcArray.count, self.segmenttopbar.frame.size.height, SCREEN_FRAME_WIDTH/self.vcArray.count, self.segmentvaluechangebarHeight)];
            btn.backgroundColor=[UIColor lightGrayColor];
            btn.tag=i;
            if (self.hasName) {
                [btn setTitle:VC.title forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:btn];
            [btnArray addObject:btn];
            VC.view.frame=CGRectMake(0, self.segmentvaluechangebarHeight+self.segmenttopbarHeight, SCREEN_FRAME_WIDTH, self.view.frame.size.height-self.segmentvaluechangebarHeight-self.segmenttopbarHeight);
        }
        else
        {
            UIViewController *VC=[self.vcArray objectAtIndex:i];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(i*SCREEN_FRAME_WIDTH/self.vcArray.count, self.view.frame.size.height-self.segmentvaluechangebarHeight, SCREEN_FRAME_WIDTH/self.vcArray.count, self.segmentvaluechangebarHeight)];
            btn.tag=i;
            btn.backgroundColor=[UIColor whiteColor];
            if (self.hasName) {
                [btn setTitle:VC.title forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:btn];
            [btnArray addObject:btn];
            VC.view.frame=CGRectMake(0, self.segmenttopbarHeight, SCREEN_FRAME_WIDTH, self.view.frame.size.height-self.segmentvaluechangebarHeight-self.segmenttopbarHeight);
        }
    }
    self.selectindex=0;
}
-(void)loadView
{
    UIView *loloadview=[[UIView alloc] initWithFrame:self.frame];
    self.view=loloadview;
}
-(void)viewDidAppear:(BOOL)animated
{
//    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnClicked:(UIButton *)sender
{
    self.selectindex=(int)sender.tag;
}
#pragma mark-
#pragma mark setter
- (void)setSelectindex:(int)selectedindex
{
    _selectindex=selectedindex;
    for (int i=0; i<self.vcArray.count; i++) {
        UIViewController *VC=[self.vcArray objectAtIndex:i];
        UIButton *btn=[btnArray objectAtIndex:i];
        if (self.selectindex==i) {
            if (imgarray.count > 2*i+1) {
                [btn setBackgroundImage:[imgarray objectAtIndex:2*i+1] forState:UIControlStateNormal];
            }
            if (self.colorselected) {
                btn.backgroundColor=self.colorselected;
                [btn setTitleColor:[UIColor colorWithRed:220/255.0f green:163/255.0f blue:109/255.0f alpha:1.0] forState:UIControlStateNormal];
            }
            [self addChildViewController:VC];
            [self.view insertSubview:VC.view belowSubview:self.segmenttopbar];
            [VC willMoveToParentViewController:self];
            [VC didMoveToParentViewController:self];
        }
        else
        {
            if (imgarray.count > 2*i) {
                [btn setBackgroundImage:[imgarray objectAtIndex:2*i] forState:UIControlStateNormal];
            }
            if (self.color) {
                btn.backgroundColor=self.color;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [VC willMoveToParentViewController:nil];  // 1
            [VC didMoveToParentViewController:nil];
            [VC.view removeFromSuperview];            // 2
            [VC removeFromParentViewController];      // 3
        }
    }
}
//-(void)setSegmentTitle:(NSString *)segmentTitle
//{
//    _segmentTitle = segmentTitle;
//    labeloftitle.text=segmentTitle;
//}
@end

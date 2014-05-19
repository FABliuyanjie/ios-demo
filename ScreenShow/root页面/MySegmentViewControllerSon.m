//
//  MySegmentViewControllerSon.m
//  ScreenShow
//
//  Created by lee on 14-4-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MySegmentViewControllerSon.h"
#import "MenuViewController.h"


@interface MySegmentViewControllerSon ()

@end

@implementation MySegmentViewControllerSon

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initMySegmentController:(NSArray *)vcArray imgarray:(NSArray *)primgarray
{
    self = [super initMySegmentController:vcArray imgarray:primgarray];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.leftItem addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchDown];
    [self.leftItem setImage:[UIImage imageNamed:@"myseg_leftitem.png"] forState:UIControlStateNormal];
    [self.leftItem setImage:[UIImage imageNamed:@"myseg_leftitem_highlight.png"] forState:UIControlStateHighlighted];
    
    [self.rightItem setImage:[UIImage imageNamed:@"myseg_rightitem.png"] forState:UIControlStateNormal];
    [self.rightItem setImage:[UIImage imageNamed:@"myseg_rightitem_highlight.png"] forState:UIControlStateHighlighted];
    
    
    [self.rightItem addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchDown];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(lefttableselect:) name:kLefttableselect object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    MenuViewController *menuVC=[MenuViewController shareMenu];
    [menuVC.viewslipper removeGestureRecognizer:menuVC.pan];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MenuViewController *menuVC=[MenuViewController shareMenu];
    [menuVC.viewslipper addGestureRecognizer:menuVC.pan];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnBackClicked:(id)sender
{
    int obj=[[MenuViewController shareMenu] showtype];
    if (obj==0) {
        [[MenuViewController shareMenu] setShowtype:1];
    }
    if (obj==1) {
        [[MenuViewController shareMenu] setShowtype:0];
    }
}
-(void)rightItemClicked:(id)sender
{
    [[MenuViewController shareMenu] setShowtype:2];
}
#pragma mark-
#pragma mark notification
-(void)lefttableselect:(NSNotification *)noti
{
    self.selectindex=0;
}
#pragma mark-
#pragma mark UIInterfaceOrientation delegate
-(BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}
#pragma mark-
#pragma mark rotate delegate
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@",[[MenuViewController shareMenu] viewslipper]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

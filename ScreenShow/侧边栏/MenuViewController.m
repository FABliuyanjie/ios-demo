//
//  MenuViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-19.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MenuViewController.h"
#import "ScreenShow-Prefix.pch"

static int flipflag=100;
static int flipflag1=-100;

@interface MenuViewController ()

@end

@implementation MenuViewController

+ (instancetype)shareMenu
{
    static MenuViewController *sharedRootController = nil;
    @synchronized(sharedRootController)
    {
        if (sharedRootController == nil)
        {
            sharedRootController = [[MenuViewController alloc] init];
        }
    }
    return sharedRootController;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    self.showtype=1;
    [self addChildViewController:self.leftVC];
    [self.view addSubview:self.leftVC.view];
    [self.leftVC didMoveToParentViewController:self];
    
    
    self.viewslipper=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT)];
    [[self.viewslipper layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.viewslipper layer] setShadowRadius:3];
    [[self.viewslipper layer] setShadowOpacity:1];
    [[self.viewslipper layer] setShadowColor:[UIColor blackColor].CGColor];
    self.viewslipper.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.viewslipper.bounds].CGPath;
    [self.view addSubview:self.viewslipper];

    
    [self addChildViewController:self.rightVC];
    self.rightVC.view.autoresizesSubviews = NO;
    [self.viewslipper addSubview:self.rightVC.view];
    self.rightVC.view.frame=CGRectMake(SCREEN_FRAME_WIDTH, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT);
    [self.rightVC didMoveToParentViewController:self];

    
    [self addChildViewController:self.centerVC];
    [self.viewslipper addSubview:self.centerVC.view];
    [self.centerVC didMoveToParentViewController:self];
    
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.pan setDelegate:self];
    [self.viewslipper addGestureRecognizer:self.pan];
}
#pragma mark-
#pragma mark setter

-(void)setShowtype:(int)showtype
{
    __weak UIView *loview=self.viewslipper;
    _showtype=showtype;
    if (showtype==0) {
        [UIView animateWithDuration:0.2 animations:^{
            loview.frame=CGRectMake(256, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
        } completion:^(BOOL finished) {
        }];
    }
    else if (showtype==1)
    {
        [UIView animateWithDuration:0.2 animations:^{
            loview.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            loview.frame=CGRectMake(-1*SCREEN_FRAME_WIDTH, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
        } completion:^(BOOL finished) {
        }];
    }
}
#pragma mark-
#pragma mark panGesture
-(void)panGesture:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.oldPoint=CGPointZero;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [panGesture translationInView:self.view];
            CGRect rect=self.viewslipper.frame;
            if (point.x-self.oldPoint.x>0) {
                flipflag1=-270;
                flipflag=50;
            }
            else
            {
                flipflag1=-50;
                flipflag=150;
            }
            if (rect.origin.x+point.x-self.oldPoint.x<=256 && rect.origin.x+point.x-self.oldPoint.x>(-1*SCREEN_FRAME_WIDTH)) {
                 self.viewslipper.frame=CGRectMake(rect.origin.x+point.x-self.oldPoint.x, rect.origin.y, rect.size.width, rect.size.height);
            }
            self.oldPoint=point;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            [UIView beginAnimations:nil context:nil];
            //动画持续时间
            [UIView setAnimationDuration:0.1];
            if (self.viewslipper.frame.origin.x>0 && self.viewslipper.frame.origin.x<=flipflag)
            {
                self.viewslipper.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
                self.showtype=1;
            }
            else if (self.viewslipper.frame.origin.x>flipflag)
            {
                self.viewslipper.frame=CGRectMake(256, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
                self.showtype=0;
            }
            else if (self.viewslipper.frame.origin.x<=0 && self.viewslipper.frame.origin.x>flipflag1)
            {
                self.viewslipper.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
                self.showtype=1;
            }
            else if (self.viewslipper.frame.origin.x<=flipflag1)
            {
                self.viewslipper.frame=CGRectMake(-1*SCREEN_FRAME_WIDTH, 0, SCREEN_FRAME_WIDTH*2, SCREEN_FRAME_HEIGHT);
                self.showtype=2;
            }
            [UIView commitAnimations];
            break;
        }
        default:
            break;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.leftVC.view.frame=CGRectMake(0,STATUSBAR_HEIGHT, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7);
    self.centerVC.view.frame=CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7);
    self.rightVC.view.frame=CGRectMake(SCREEN_FRAME_WIDTH, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark-
#pragma mark UIInterfaceOrientation delegate
- (BOOL)shouldAutorotate
{
    return self.centerVC.shouldAutorotate;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return self.centerVC.supportedInterfaceOrientations;
}
#pragma mark-
#pragma mark rotate delegate
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        NSLog(@"%@",self.parentViewController.parentViewController.view);
        //iphone4s down
        if (SCREEN_FRAME_HEIGHT==480) {
            NSLog(@"Landscape");
            self.centerVC.view.frame=CGRectMake(0, STATUSBAR_HEIGHT, 480, 320-STATUSBAR_HEIGHT_IOS7);
        }
        //iphone5 up
        else
        {
            NSLog(@"Landscape");
            self.centerVC.view.frame=CGRectMake(0, STATUSBAR_HEIGHT, 568, 320-STATUSBAR_HEIGHT_IOS7);
        }
    }
    else
    {
        self.centerVC.view.frame=CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7);
    }
}
@end

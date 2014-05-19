//
//  LiveStudioViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "LiveStudioViewController.h"
#import "ScreenViewController.h"
#import "ScreenShow-Prefix.pch"
#import "ChatViewController.h"
#import "TOOL.h"
#import "AppDelegate.h"


@interface LiveStudioViewController ()

@end

@implementation LiveStudioViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithscreenController:(UIViewController*)screenController
                mysegmentController:(UIViewController*)mysegmentController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.screenVC=screenController;
        self.mysegmentVC=mysegmentController;
    }
    return self;
}
-(void)isMotionstate
{
    [[User shareUser] setIsMotion:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    motionManager = [[CMMotionManager alloc]init];
    motionManager.accelerometerUpdateInterval=1.0/30.0;
    [self addChildViewController:self.screenVC];
    [self.view addSubview:self.screenVC.view];
    [self.screenVC didMoveToParentViewController:self];
    [self addChildViewController:self.mysegmentVC];
    self.mysegmentVC.view.frame=CGRectMake(0, 220, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-220);
    [self.view addSubview:self.mysegmentVC.view];
    [self.mysegmentVC didMoveToParentViewController:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"glass" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
}
-(void)loadView
{
    UIView *loloadview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7)];
    self.view=loloadview;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    __weak UIViewController *weakself=self;
    __weak User *user=[User shareUser];
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData*accelerometerData,NSError*error)
     {
         CMAcceleration accleleration=accelerometerData.acceleration;
         if (fabsf(accleleration.x) > 1.7  || fabsf(accleleration.y) > 1.7)
         {
             if (!user.isMotion) {
                 if ([TOOL handOverByShake]) {
                     user.isMotion=YES;
                     [weakself performSelector:@selector(isMotionstate) withObject:nil afterDelay:2.0];
                     AudioServicesPlaySystemSound (soundID);
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"motionended" object:[NSNumber numberWithInt:1]];
                 }
             }
         }
     }];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [motionManager stopAccelerometerUpdates];
    [super viewDidDisappear:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark UIInterfaceOrientation delegate
-(BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
#pragma mark-
#pragma mark rotate delegate
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        self.mysegmentVC.view.hidden=YES;
    }
    else
    {
        self.mysegmentVC.view.hidden=NO;
    }
}
@end

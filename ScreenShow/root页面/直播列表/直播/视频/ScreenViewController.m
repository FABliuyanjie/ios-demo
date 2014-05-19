//
//  ScreenViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ScreenViewController.h"
#import "ScreenShow-Prefix.pch"
#import "ScreenPortaitViewController.h"
#import "ScreenLandViewController.h"
#include <objc/message.h>
#import "ScreenControlview.h"
#import "User.h"


@interface ScreenViewController ()

@end

@implementation ScreenViewController

- (id)initWithsportaitController:(UIViewController*)protraitVC
                  landController:(UIViewController*)landVC
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.protraitVC=protraitVC;
        self.landVC=landVC;
        self.isgzofcurrentanchor=0;
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    BOOL ispop=YES;
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if (VC==self.parentViewController) {
            ispop=NO;
            break;
        }
    }
    if (ispop) {
        [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"index.php/Api/Show/closeShow?id=%d&zb_id=%d",[[User shareUser] manID],self.anchor.anchorid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //z
            NSLog(@"%@",[responseObject objectForKey:@"info"]);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //
            NSLog(@"%@",error);
        }];
        [self.player removeObserver:self forKeyPath:@"status"];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http://192.168.2.1:1935/screenshow/myStream/playlist.m3u8"] options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_FRAME_WIDTH, 200);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:self.playerLayer];
    [self.player play];
    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    
    [self addChildViewController:self.protraitVC];
    self.view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.protraitVC.view];
    [self.protraitVC didMoveToParentViewController:self];
    
    
    [self addChildViewController:self.landVC];
    self.landVC.view.hidden=YES;
    [self.view addSubview:self.landVC.view];
    [self.landVC didMoveToParentViewController:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appenterForeground:) name:@"EnterForeground" object:nil];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
        } else if (self.player.status == AVPlayerStatusFailed) {
            // something went wrong. player.error should contain some information
            NSLog(@"%@",self.player.error);
        }
    }
}
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    NSError *error = [[notify userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
}
- (void)loadView
{
    ScreenControlview *screenview=[[ScreenControlview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7)];
    screenview.backgroundColor=[UIColor whiteColor];
    self.view=screenview;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            self.view.frame=CGRectMake(0, 0, 480, 320);
            [self.playerLayer setFrame: CGRectMake(0, STATUSBAR_HEIGHT, 480, 320)];
            ScreenLandViewController *landVC=[self.childViewControllers objectAtIndex:1];
            landVC.view.hidden=NO;
            
            ScreenPortaitViewController *portaitVC=[self.childViewControllers objectAtIndex:0];
            portaitVC.view.hidden=YES;
        }
        //iphone5 up
        else
        {
            NSLog(@"Landscape");
            self.view.frame=CGRectMake(0, 0, 568, 320);
            [self.playerLayer setFrame: CGRectMake(0, STATUSBAR_HEIGHT, 568, 320)];
            ScreenPortaitViewController *portaitVC=[self.childViewControllers objectAtIndex:0];
            portaitVC.view.hidden=YES;
            
            ScreenLandViewController *landVC=[self.childViewControllers objectAtIndex:1];
            landVC.view.hidden=NO;
        }
    }
    else
    {
        self.view.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, self.view.frame.size.height);
        [self.playerLayer setFrame: CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_FRAME_WIDTH, self.view.frame.size.height-STATUSBAR_HEIGHT_IOS7)];
        ScreenPortaitViewController *portaitVC=[self.childViewControllers objectAtIndex:0];
        portaitVC.view.hidden=NO;
        
        ScreenLandViewController *landVC=[self.childViewControllers objectAtIndex:1];
        landVC.view.hidden=YES;
    }
}
#pragma mark-
#pragma mark nsnotification
-(void)appenterForeground:(id)sender
{
    [self.player play];
}
@end

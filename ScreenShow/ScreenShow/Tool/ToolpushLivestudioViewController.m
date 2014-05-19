//
//  ToolpushLivestudioViewController.m
//  ScreenShow
//
//  Created by lee on 14-5-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ToolpushLivestudioViewController.h"
#import "ScreenPortaitViewController.h"
#import "ScreenLandViewController.h"
#import "ScreenViewController.h"
#import "ChatViewController.h"
#import "AudienceViewController.h"
#import "FansViewController.h"
#import "MySegmentViewController.h"
#import "LiveStudioViewController.h"
#import "VCchain.h"

@interface ToolpushLivestudioViewController ()

@end

@implementation ToolpushLivestudioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)pushLiveStudioVC:(Anchor *)anchor anchorItems:(NSMutableArray *)anchorItems vc:(UIViewController *)vc
{
    NSString *astr=[NSString stringWithFormat:@"index.php/Api/Show/enterShow?id=%d&zb_id=%d",[[User shareUser] manID],anchor.anchorid];
    [self startnetwork1:astr];
    //screen
    ScreenPortaitViewController *portaitVC=[[ScreenPortaitViewController alloc] initWithNibName:@"ScreenPortaitViewController" bundle:nil obj:(anchor)];
    portaitVC.anchorarray=anchorItems;
    ScreenLandViewController *landVC=[[ScreenLandViewController alloc] initWithNibName:nil bundle:nil];
    landVC.anchorarray=anchorItems;
    landVC.anchor=anchor;
    
    
    ScreenViewController *screenVC=[[ScreenViewController alloc] initWithsportaitController:portaitVC landController:landVC];
    [VCchain sharedchain].screenvc=screenVC;
    screenVC.anchor=anchor;
    
    
    //mysegment
    ChatViewController *chatVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil ];
    chatVC.anchorarray=anchorItems;
    chatVC.anchor=anchor;
    chatVC.title=@"公聊";
    AudienceViewController *andienceVC=[[AudienceViewController alloc] initWithNibName
                                        :@"AudienceViewController" bundle:nil];
    andienceVC.anchor=anchor;
    andienceVC.anchorarray=anchorItems;
    andienceVC.title=@"观众";
    FansViewController *fansVC=[[FansViewController alloc] initWithNibName:@"FansViewController" bundle:nil ];
    fansVC.anchor=anchor;
    fansVC.anchorarray=anchorItems;
    fansVC.title=@"粉丝";
    
    NSMutableArray *vcArray=[[NSMutableArray alloc] initWithObjects:chatVC,andienceVC,fansVC, nil];
    MySegmentViewController *mysegmentVC=[[MySegmentViewController alloc] initMySegmentController:vcArray  imgarray:nil];
    mysegmentVC.frame=CGRectMake(0, 220, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-220-STATUSBAR_HEIGHT_IOS7);
    mysegmentVC.segmentvaluechangebarHeight=30;
    mysegmentVC.segmenttopbarHeight=0;
    mysegmentVC.issegmentvaluechangebarTop=YES;
    mysegmentVC.colorselected=[UIColor blackColor];
    mysegmentVC.color=[UIColor colorWithRed:54/255.0f green:46/255.0f  blue:58/255.0f  alpha:1.0];
    LiveStudioViewController *liveVc=[[LiveStudioViewController alloc] initWithscreenController:screenVC mysegmentController:mysegmentVC];
    [VCchain sharedchain].livestudio=liveVc;
    [vc.navigationController pushViewController:liveVc animated:YES];
}
+(void)startnetwork1:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"%@",[responseObject objectForKey:@"info"]);
        @try {
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
    }];
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

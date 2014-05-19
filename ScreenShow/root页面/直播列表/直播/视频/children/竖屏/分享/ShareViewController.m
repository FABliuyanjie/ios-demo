//
//  ShareViewController.m
//  ScreenShow
//
//  Created by lee on 14-5-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ShareViewController.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

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
    // Do any additional setup after loading the view from its nib.
    textview.layer.borderWidth=1;
    textview.layer.borderColor=[UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnbackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)shareClicked:(id)sender
{
    [self.view endEditing:YES];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5373474456240b1cbc020bde"
                                      shareText:@"你要分享的文字aasdfas"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToRenren,UMShareToQQ,nil]
                                       delegate:nil];
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
//    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:textview.text
//                                       defaultContent:@""
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"starshow"
//                                                  url:nil
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    [ShareSDK showShareActionSheet:nil
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions: nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
}
@end

//
//  ScreenPortaitViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ScreenPortaitViewController.h"
#include <objc/message.h>
#import "ScreenViewController.h"
#import "UIImageView+WebCache.h"
#import "ReportViewController.h"
#import "ScreenViewController.h"
#import "MenuViewController.h"
#import "RootViewController.h"
#import "NSString+formatDate.h"
#import "ShareViewController.h"
#import "VCchain.h"


@interface ScreenPortaitViewController ()

@end

@implementation ScreenPortaitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil obj:(Anchor *)anchor
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        controlArray=[[NSMutableArray alloc] init];
        self.anchor1=[[Anchor alloc] init];
        isControlhide=YES;
        isMiddlehide=YES;
        self.anchor=anchor;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [controlArray addObject:self.bottombar];
    [controlArray addObject:self.topbar];
    [controlArray addObject:viewtransparent];
    [controlArray addObject:self.labelaudiencecount];
    [controlArray addObject:self.imgviewaudience];
    [controlArray addObject:btnleft];
    [controlArray addObject:btnright];
    
    
    self.imgtou.layer.cornerRadius = 5;//设置那个圆角的有多圆
    self.imgtou.layer.masksToBounds = YES;//设为NO去试试
    for (UIView *loview in controlArray) {
        loview.hidden=YES;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removemyobserver) name:@"removeobservers" object:nil];
    [[VCchain sharedchain].screenvc addObserver:self forKeyPath:@"isgzofcurrentanchor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    if (!IS_LOGIN) {
        [[User shareUser] setManID:-1];
    }
    [self startnetworkofanchorinfo:[NSString stringWithFormat:@"index.php/Api/Show/roomInfo?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]]];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(motionended:) name:@"motionended" object:nil];
    [self becomeFirstResponder];
}
-(void)startnetworkofanchorinfo:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"%@",[responseObject objectForKey:@"info"]);
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                if (![[lodic objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                    self.anchor1.photoUrl=[[lodic objectForKey:@"data"] valueForKey:@"img_tou"];
                    self.anchor1.nickName=[[lodic objectForKey:@"data"] valueForKey:@"name"];
                    self.anchor1.levelName=[[lodic objectForKey:@"data"] valueForKey:@"rank_name"];
                    self.anchor1.rankpic=[[lodic objectForKey:@"data"] valueForKey:@"rank_img"];
                    self.anchor1.audicecount=[[[lodic objectForKey:@"data"] valueForKey:@"num"] intValue];
                    
                
                    labelrank.text=self.anchor1.levelName;
                    [self.imgtou setImageWithURL:[NSURL URLWithString:self.anchor1.photoUrl]];
                    self.labelname.text=self.anchor1.nickName;
                    self.labelname1.text=self.anchor1.nickName;
                    [imgrank setImageWithURL:[NSURL URLWithString:self.anchor1.rankpic]];
                    
                    
                    self.labelaudiencecount.text=[NSString stringWithFormat:@"%d人",self.anchor1.audicecount];
                    int is_gz=[[[lodic objectForKey:@"data"] valueForKey:@"is_gz"] intValue];
                    [[VCchain sharedchain].screenvc setIsgzofcurrentanchor:is_gz];
                    [self refreshattentionbtn];
                    if (![[[lodic objectForKey:@"data"] valueForKey:@"start_time"] isKindOfClass:[NSNull class]]) {
                        self.labelstarttime.text=[NSString stringWithFormat:@"已开播%@",[NSString formatDatefromnow:[[lodic objectForKey:@"data"] valueForKey:@"start_time"]]];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"roominfogeted" object:self.anchor1];
                }
            }
            else
            {
                
            }
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    BOOL ispop=YES;
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if (VC==self.parentViewController.parentViewController) {
            ispop=NO;
            break;
        }
    }
    if (ispop) {
        [[VCchain sharedchain].screenvc removeObserver:self forKeyPath:@"isgzofcurrentanchor"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnControlClicked:(id)sender
{
    NSLog(@"%@",self.parentViewController.view);
    isControlhide=!isControlhide;
    if (isControlhide) {
        for (UIView *loview in controlArray) {
            loview.hidden=YES;
        }
    }
    else
    {
        for (UIView *loview in controlArray) {
            loview.hidden=NO;
        }
    }
}
-(IBAction)btnBackClicked:(id)sender
{
    [self.parentViewController.parentViewController.navigationController popViewControllerAnimated:YES];
}
-(IBAction)moreClicked:(id)sender
{
    isMiddlehide=!isMiddlehide;
    if (isMiddlehide) {
        self.middle.hidden=YES;
        viewtransparent1.hidden=YES;
    }
    else
    {
        self.middle.hidden=NO;
        viewtransparent1.hidden=NO;
    }
}
-(IBAction)btnFullScreenClicked:(id)sender
{
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
}
-(IBAction)btn6Clicked:(UIButton *)sender
{
    isMiddlehide=!isMiddlehide;
    self.middle.hidden=YES;
    viewtransparent1.hidden=YES;
    if (sender.tag==103) {
        ReportViewController *reportVC=[[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
        reportVC.anchor=self.anchor;
        [self.navigationController pushViewController:reportVC animated:YES];
    }
    if (sender.tag==104) {
        ShareViewController *shareVC=[[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
        [self.navigationController pushViewController:shareVC animated:YES];
    }
}
-(IBAction)btnAttentionClicked:(UIButton *)sender
{
    if (!IS_LOGIN) {
        UIViewController *loLogin = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loLogin animated:YES];
        return;
    }
    NSString *urlstr=@"";
    //关注主播
    if (sender.tag==101) {
        urlstr=[NSString stringWithFormat:@"index.php/Api/Show/anchorInterest?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]];
        [[AFAppDotNetAPIClient sharedClient] GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",[responseObject objectForKey:@"info"]);
            @try {
                NSDictionary *lodic=(NSDictionary *)responseObject;
                if ([[lodic objectForKey:@"status"] integerValue]==1) {
                    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"关注成功" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alter show];
                    [[VCchain sharedchain].screenvc setIsgzofcurrentanchor:1];
                }
                else
                {
                    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alter show];
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
            @finally {
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alter show];
            //
            NSLog(@"%@",error);
        }];
    }
    //取消关注主播
    if (sender.tag==100) {
        urlstr=[NSString stringWithFormat:@"index.php/Api/Show/anchorInterestDelete?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]];
        [[AFAppDotNetAPIClient sharedClient] GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"%@",[responseObject objectForKey:@"info"]);
            @try {
                NSDictionary *lodic=(NSDictionary *)responseObject;
                if ([[lodic objectForKey:@"status"] integerValue]==1) {
                    [[VCchain sharedchain].screenvc setIsgzofcurrentanchor:0];
                }
                else
                {
                }
                UIAlertView *alter=[[UIAlertView alloc] initWithTitle:[lodic valueForKey:@"info"] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alter show];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
            @finally {
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"取消关注失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alter show];
            //
            NSLog(@"%@",error);
        }];
    }
}
-(void)refreshattentionbtn
{
    if ([[VCchain sharedchain].screenvc isgzofcurrentanchor]==0) {
        self.btnattention.tag=101;
        [self.btnattention setImage:[UIImage imageNamed:@"screenportait_vc_btn_quxiaoguanzhu"] forState:UIControlStateNormal];
    }
    else
    {
        self.btnattention.tag=100;
        [self.btnattention setImage:[UIImage imageNamed:@"screenportait_vc_btn_guanzhu"] forState:UIControlStateNormal];
    }
}
-(IBAction)btnleftorrightClicked:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"motionended" object:[NSNumber numberWithInt:sender.tag]];
}
#pragma mark-
#pragma mark -motionended
-(void)motionended:(NSNotification *)noti
{
    int type=[[noti object] integerValue];
    for (int i=0; i<self.anchorarray.count; i++) {
        Anchor *tmpanchor=[self.anchorarray objectAtIndex:i];
        if (self.anchor==tmpanchor) {
            if (type==0) {
                if (i-1<0) {
                    self.anchor=[self.anchorarray objectAtIndex:self.anchorarray.count-1];
                }
                else
                {
                    self.anchor=[self.anchorarray objectAtIndex:i-1];
                }
            }
            else
            {
                if (i+1>self.anchorarray.count-1) {
                    self.anchor=[self.anchorarray objectAtIndex:0];
                }
                else
                {
                    self.anchor=[self.anchorarray objectAtIndex:i+1];
                }
            }
            [self startnetworkofanchorinfo:[NSString stringWithFormat:@"index.php/Api/Show/roomInfo?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]]];
            break;
        }
    }
}
#pragma mark-
#pragma mark notification
-(void)removemyobserver
{
    [[VCchain sharedchain].screenvc removeObserver:self forKeyPath:@"isgzofcurrentanchor"];
}

#pragma mark-
#pragma mark- KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"isgzofcurrentanchor"])
    {
        [self refreshattentionbtn];
    }
}
@end

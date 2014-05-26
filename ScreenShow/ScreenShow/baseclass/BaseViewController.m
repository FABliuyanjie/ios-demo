//
//  BaseViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Additions.h"

#define kBtnImage [UIImage imageNamed:@"btn_back_small.png"]
#define kBtnHgighLighImage [UIImage imageNamed:@"btn_back_highligh.png"]
@interface BaseViewController ()

@end

@implementation BaseViewController

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
    
#ifdef __IPHONE_7_0
    if (isIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
   
#endif

    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 31.0, 44.0)];

    [button setImage:kBtnImage forState:UIControlStateNormal];
    [button setImage:kBtnHgighLighImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if (IsIOS7) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 0)];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    item.width=100;
    self.navigationItem.leftBarButtonItem = item;
    
}

-(void)back
{
    if (self.navigationController ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    NSArray *subViews = [self.tabBarController.view subviews];
    
    UIView *contentView = [subViews objectAtIndex:0];
    
#ifdef __IPHONE_7_0
    
    if (isIOS7) {
        contentView.frame = CGRectMake(0, 0, 320, SCREEN_HEIGHT - 49 + 64);
    }
    
#endif
   
    if(!isIOS7) {
        contentView.frame = CGRectMake(0, 0, 320, SCREEN_HEIGHT - 49);
    }
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:0.868 alpha:1.000] size:CGSizeMake(320, 44) andRoundSize:0];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)setTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:18];
    [label sizeToFit];
   
    
    self.navigationItem.titleView = label;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}
-(void)flushUI
{
    //TODO:刷新界面
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [TSMessage dismissActiveNotification];
    
}
@end

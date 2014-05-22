 //
//  MyViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MyViewController.h"
#import "AccountManagementViewController.h"
#import "LogInViewController.h"
#import "MenuViewController.h"
#import "MyCostListViewController.h"
#import <objc/objc-api.h>
#import "SignInViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#import "User.h"
#import "CostListViewController.h"
#import "RechangViewController.h"

#import "UIImage+Additions.h"

#import "MySegmentViewController.h"
@interface MyViewController ()<UIScrollViewDelegate>
{
   
    CGFloat _imageHeigh;
    CGFloat _bgHeight;
    CGFloat _nameHeight;
    CGFloat _typeHeight;
}

@end

@implementation MyViewController

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
   self.title = @"我的";
    
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.width = 320;
    self.navigationController.navigationBar.frame = frame;
    self.navigationController.navigationBar.autoresizesSubviews = NO;
    
    self.systemSetBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.systemSetBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1]] forState:UIControlStateHighlighted];
    
    self.systemSetBtn.layer.borderWidth = 0.5f;
    self.userSetBtn.layer.borderWidth = 0.5f;
    self.userSetBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.userSetBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1]] forState:UIControlStateHighlighted];

    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_NO_TABBAR);

    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.aboutUse.frame.origin.y + self.aboutUse.frame.size.height + 10);
  
    
    //tableView set
   [User readUserInfo];
    
    [self flushUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(flushUI) name:kLogInSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(flushUI) name:kLogOutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flushUI) name:kReflushUserInfo object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)back
{
    [self moveToParentVC];
}
//返回
-(void)moveToParentVC
{
    MenuViewController *ppVC = [MenuViewController shareMenu];
    [ppVC setShowtype:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MenuViewController *menuVC=[MenuViewController shareMenu];
    [menuVC.viewslipper addGestureRecognizer:menuVC.pan];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    MenuViewController *menuVC=[MenuViewController shareMenu];
    [menuVC.viewslipper removeGestureRecognizer:menuVC.pan];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  view
//MARK:刷新UI
-(void)flushUI
{
    //充值view设置边框
    self.userAccount.layer.borderWidth = 1;
    self.userAccount.layer.borderColor = [PBFlatSettings sharedInstance].secondColor.CGColor;
    
    //头像切圆
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 50.f;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImageView.layer.borderWidth = 2;
    self.scrollView.delegate = self;
    if (IS_LOGIN) {
        [self flushUIWhenLogined];
        
    }else{
        [self flushUIWhenNotLogined];
    }
    
}

-(void)flushUIWhenNotLogined
{
    //设置默认头像，用户名
    [self.headImageView setImage:[UIImage imageNamed:@"login_headImage"]];
    self.userName.text = [NSString stringWithFormat:@"游客%@",@"235"];
    self.userType.text = @"";
    
    //登录注册按钮显示，用户设置隐藏，调整系统设置按钮的坐标
    self.loginBtn.hidden = NO;
    self.registerBtn.hidden = NO;
    self.userSetBtn.hidden = YES;
    self.systemSetBtn.frame = CGRectMake(107*2, self.systemSetBtn.top, 107, self.systemSetBtn.height);
    
    //账号余额和资金记录隐藏
    self.userAccount.hidden = YES;
    self.userMoneyBt.hidden = YES;
    
}

-(void)flushUIWhenLogined
{
    //头像
    User *user = [User readUserInfo];
    
    [self.headImageView setImageWithURL:[NSURL URLWithString:user.photoUrl] placeholderImage:[UIImage imageNamed:@"login_headImage"] success:^(UIImage *image) {
        user.photo = image;
        [User saveUserInfo];
    } failure:^(NSError *error) {
        //
    }];
    //=======
    //登录 注册 系统设置 按钮
    self.userName.text = user.nickName;
    self.userType.text = user.levelName;
    
    self.registerBtn.hidden = YES;
    self.loginBtn.hidden = YES;
    self.userSetBtn.hidden = NO;
    self.systemSetBtn.hidden = NO;
    
    //====== 下方账号金额和按钮
    //显示充值按钮
    self.userAccount.hidden = NO;
    self.userMoneyBt.hidden = NO;
    //内容
    self.reChangLb.text = @"充值";
    self.userAcountLb.text = @"(余额：";
    self.fbMoneyLb.text = [NSString stringWithFormat:@"%ld ",(long)user.accountFB];
    self.biLb.text = @"F币)";
    
    
    //位置
    self.userSetBtn.frame = CGRectMake(0, self.userSetBtn.top, 160, self.userSetBtn.height);
    self.systemSetBtn.frame = CGRectMake(160, self.systemSetBtn.top, 160, self.systemSetBtn.height);
    
    CGFloat totalwidth = 0.f;
    CGFloat reChangWidth = [self.reChangLb.text sizeWithFont:[UIFont systemFontOfSize:20]].width;
    CGFloat userAcountLbWidth = [self.userAcountLb.text sizeWithFont:[UIFont systemFontOfSize:14]].width;
    CGFloat fbMoneyLbWidth = [self.fbMoneyLb.text sizeWithFont:[UIFont systemFontOfSize:14]].width;
    CGFloat biLbWidth = [self.biLb.text sizeWithFont:[UIFont systemFontOfSize:14]].width;
    
    totalwidth = reChangWidth + userAcountLbWidth + fbMoneyLbWidth + biLbWidth;
    
    self.reChangLb.frame = CGRectMake((self.userAccount.width-totalwidth)/2, self.reChangLb.top, reChangWidth, self.userAccount.height);
    
    self.userAcountLb.frame = CGRectMake(self.reChangLb.right, self.userAcountLb.top, userAcountLbWidth, 20);

    self.fbMoneyLb.frame = CGRectMake(self.userAcountLb.right, self.fbMoneyLb.top, fbMoneyLbWidth, 20);
    self.biLb.frame = CGRectMake(self.fbMoneyLb.right, self.biLb.top, biLbWidth, 20);
}



#pragma mark - TableView Delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //消费记录
    if ([segue.identifier isEqualToString:@"CostLogSegue"]) {
        CostListViewController *cvc = [[CostListViewController alloc]init];
        cvc.urlStr = PORT_CONSUMELOG;
        cvc.title = @"充值记录";
        cvc.segIndex = 0;
        
        RechangViewController *rvc = [[RechangViewController alloc]init];
        rvc.urlStr = PORT_RECHARGE;
        rvc.title = @"消费记录";
        rvc.segIndex = 1;

  
        MyCostListViewController *mclvc = segue.destinationViewController;
        mclvc.viewControllers = @[rvc,cvc];

        
    }
    if ([segue.identifier isEqualToString:@"LogInViewController"]) {
        LogInViewController *lvc = segue.destinationViewController;
        lvc.isFromMyViewController = YES;
    }
    if ([segue.identifier isEqualToString:@"SignInViewController"]) {
        SignInViewController *lvc = segue.destinationViewController;
        lvc.isFromMyViewController = YES;
    }

    
    
}

#pragma mark - ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//   _imageHeigh = 0.0f;
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        _imageHeigh = self.headImageView.height;
//        _bgHeight = self.headBackgroundImageView.height;
//        _nameHeight = self.userName.top;
//        _typeHeight = self.userType.top;
//        
//    });//第一次时，设置高度
//    CGRect frame= self.headImageView.frame;
//    CGFloat offheigh= scrollView.contentOffset.y;
//    
//    if (offheigh<0) {
//        frame.size.height=_imageHeigh+ abs(offheigh);
//        self.headBackgroundImageView.frame = frame;
//    
//    }
    
}



- (IBAction)clickAccountImage:(UITapGestureRecognizer *)sender
{
    if (IS_LOGIN) {
        AccountManagementViewController *avc = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"AccountManagementViewController"];
        [self.navigationController pushViewController:avc animated:YES];
    }else{
        LogInViewController *lvc = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:lvc animated:YES];
    }
}
    

@end

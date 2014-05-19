//
//  ScreenLandViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ScreenLandViewController.h"
#import "PersonInfoViewController.h"
#import "BigPresentViewController.h"
#import "ScreenLandView.h"
#import "ScreenViewController.h"
#include <objc/message.h>
#import "BigPresentView.h"
#import "UIImageView+WebCache.h"
#import "VCchain.h"


@interface ScreenLandViewController ()

@end

@implementation ScreenLandViewController
#pragma mark-
#pragma mark life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        is4hide=YES;
        ischatcontentshow=NO;
        isControlhide=NO;
        isemotionshow=NO;
        controlArray=[[NSMutableArray alloc] init];
        self.dataArray=[[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ScreenLandView *landView=(ScreenLandView *)self.view;
    landView.table.delegate=self;
    landView.table.dataSource=self;
    landView.labeltitle.text=self.anchor.nickName;
    [controlArray addObject:landView.topbar];
    [controlArray addObject:landView.btnAttention];
    [controlArray addObject:landView.btnPersonalinfo];
    [controlArray addObject:landView.btnBigpresent];
    [controlArray addObject:landView.btnPortait];
    [controlArray addObject:landView.btnKeyboard];
    [controlArray addObject:landView.btnInfo];
    
    [landView.btnBg addTarget:self action:@selector(btnControlClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnLogout addTarget:self action:@selector(btnLogoutClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnPortait addTarget:self action:@selector(btnprotaitClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnKeyboard addTarget:self action:@selector(btnKeyboardupClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnInfo addTarget:self action:@selector(btnInfolistClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnemotion addTarget:self action:@selector(btnEmotionClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnsend addTarget:self action:@selector(btnSendClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnleft addTarget:self action:@selector(btnleftorrightClicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnright addTarget:self action:@selector(btnleftorrightClicked:) forControlEvents:UIControlEventTouchDown];
    
    
    
    [landView.btnAttention addTarget:self action:@selector(btn4Clicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnPersonalinfo addTarget:self action:@selector(btn4Clicked:) forControlEvents:UIControlEventTouchDown];
    [landView.btnBigpresent addTarget:self action:@selector(btn4Clicked:) forControlEvents:UIControlEventTouchDown];
    [landView.personalinfoview.btnx addTarget:self action:@selector(btnxClicked:) forControlEvents:UIControlEventTouchDown];
    
    
    [[VCchain sharedchain].screenvc addObserver:self forKeyPath:@"isgzofcurrentanchor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardheightchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    btnKeyboardDown=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_HEIGHT, SCREEN_FRAME_WIDTH)];
    [btnKeyboardDown addTarget:self action:@selector(btnKeyboardClicked:) forControlEvents:UIControlEventTouchDown];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagereceived:) name:@"messagereceived" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(motionended:) name:@"motionended" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roominfogeted:) name:@"roominfogeted" object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
     ScreenLandView *landView=(ScreenLandView *)self.view;
    [landView insertSubview:btnKeyboardDown belowSubview:landView.textField];
    btnKeyboardDown.hidden=YES;
    landView.emotionscroller.colnum=7;
    landView.emotionscroller.delegate1=self;
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
-(void)loadView
{
    float width=0;
    if (IS_IPHONE_5)
    {
        width=568;
    }
    else
    {
        width=480;
    }
    ScreenLandView *landView=[[ScreenLandView alloc] initWithFrame:CGRectMake(0, 0, width, 320-STATUSBAR_HEIGHT_IOS7)];
    self.view=landView;
}
#pragma mark-
#pragma mark -local method
-(void)btnKeyboardClicked:(UIButton *)sender
{
    [self.navigationController.view endEditing:YES];
    btnKeyboardDown.hidden=YES;
    
    ScreenLandView *landView=(ScreenLandView *)self.view;
    landView.emotionscroller.hidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnBackClicked:(id)sender
{
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
    [self.parentViewController.parentViewController.navigationController popViewControllerAnimated:YES];
}
-(void)btnLogoutClicked:(id)sender
{
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
    [self.parentViewController.parentViewController.navigationController popViewControllerAnimated:YES];
}
-(void)btnprotaitClicked:(id)sender
{
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
}
-(void)btnKeyboardupClicked:(id)sender
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    [landView.textField becomeFirstResponder];
    [landView.btnemotion setImage:[UIImage imageNamed:@"chat_vc_emotion.png"] forState:UIControlStateNormal];
    isemotionshow=YES;
}
-(void)btnInfolistClicked:(id)sender
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    if (ischatcontentshow) {
        landView.table.hidden=NO;
        landView.viewtansparent.hidden=NO;
    }
    else
    {
        landView.table.hidden=YES;
        landView.viewtansparent.hidden=YES;
    }
    ischatcontentshow=!ischatcontentshow;
}
-(void)btnControlClicked:(id)sender
{
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
-(void)btnEmotionClicked:(id)sender
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    if (isemotionshow) {
        [landView.btnemotion setImage:[UIImage imageNamed:@"chat_vc_keyboard.png"] forState:UIControlStateNormal];
        landView.emotionscroller.hidden=NO;
        [landView.textField resignFirstResponder];
    }
    else
    {
         [landView.btnemotion setImage:[UIImage imageNamed:@"chat_vc_emotion.png"] forState:UIControlStateNormal];
        landView.emotionscroller.hidden=YES;
        [landView.textField becomeFirstResponder];
    }
    isemotionshow=!isemotionshow;
}
-(void)btnSendClicked:(id)sender
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    if (IS_LOGIN) {
        [self startnetwork:[NSString stringWithFormat:@"index.php/Api/Chat/sendMsg?uid=%d&zb_id=%d&content=%@",[[User shareUser] manID],self.anchor.anchorid,landView.textField.text]];
    }
    else
    {
        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    landView.textField.text=@"";
}
-(IBAction)btnleftorrightClicked:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"motionended" object:[NSNumber numberWithInt:sender.tag]];
}



-(void)startnetworkofattention:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"info"]);
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                [[VCchain sharedchain].screenvc setIsgzofcurrentanchor:1];
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
        UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        //
        NSLog(@"%@",error);
    }];
}
-(void)startnetworkofcancelattention:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
-(void)btn4Clicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    //关注
    if (btn.tag==201) {
        if (IS_LOGIN) {
            NSString *str=[NSString stringWithFormat:@"index.php/Api/Show/anchorInterest?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]];
            [self startnetworkofattention:str];
        }
        else
        {
            UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
    if (btn.tag==200) {
        if (IS_LOGIN) {
            NSString *str=[NSString stringWithFormat:@"index.php/Api/Show/anchorInterestDelete?id=%d&user_id=%d",self.anchor.anchorid,[[User shareUser] manID]];
            [self startnetworkofcancelattention:str];
        }
        else
        {
            UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
    //其他
    if (btn.tag==101) {
        ScreenLandView *tmpview=(ScreenLandView *)self.view;
        tmpview.personalinfoview.hidden=NO;
    }
    if (btn.tag==102) {
    }
    if (btn.tag==103) {
        if (IS_LOGIN) {
            bigPresentVC=[[BigPresentViewController alloc] initWithNibName:nil bundle:nil];
            bigPresentVC.anchor=self.anchor;
            bigPresentVC.isportrait=NO;
            [self addChildViewController:bigPresentVC];
            [self.view addSubview:bigPresentVC.view];
            [bigPresentVC didMoveToParentViewController:self];
            
            BigPresentView *lobigview=(BigPresentView *)bigPresentVC.view;
            [lobigview.btnx  addTarget:self action:@selector(singTapped:) forControlEvents:UIControlEventTouchDown];
        }
        else
        {
            UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
}
-(void)btnxClicked:(UIButton *)sender
{
    sender.superview.hidden=YES;
}
-(void)refreshattentionbtn
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    if ([[VCchain sharedchain].screenvc isgzofcurrentanchor]==0) {
        landView.btnAttention.tag=201;
        [landView.btnAttention setImage:[UIImage imageNamed:@"screenportait_vc_btn_quxiaoguanzhu.png"] forState:UIControlStateNormal];
    }
    else
    {
        landView.btnAttention.tag=200;
        [landView.btnAttention setImage:[UIImage imageNamed:@"screenportait_vc_btn_guanzhu.png"] forState:UIControlStateNormal];
    }
}
-(void)singTapped:(UIView *)sender
{
    [bigPresentVC willMoveToParentViewController:nil];
    [sender.superview removeFromSuperview];
    [bigPresentVC removeFromParentViewController];
}
#pragma mark-
#pragma mark-network
-(void)startnetwork:(NSString *)prstr
{
    NSLog(@"%@",prstr);
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //z
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
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableDictionary *rowInfo = [self.dataArray objectAtIndex:indexPath.row];
	if ([rowInfo objectForKey:@"cell_height"])
	{
		return [[rowInfo objectForKey:@"cell_height"] floatValue];
	}
	else
	{
        
        //NSString *plainData = [RTLabel getParsedPlainText:[rowInfo objectForKey:@"text"]];
        RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(10,0,300,100)];
        //tempLabel.lineBreakMode = kCTLineBreakByTruncatingTail;
        RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:[rowInfo objectForKey:@"text"]];
        tempLabel.componentsAndPlainText = componentsDS;
        CGSize optimalSize = [tempLabel optimumSize];
        [rowInfo setObject:[NSNumber numberWithFloat:optimalSize.height + 5] forKey:@"cell_height"];
		return [[rowInfo objectForKey:@"cell_height"] floatValue];
	}
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DemoTableViewCell";
    NSMutableDictionary *rowInfo = [self.dataArray objectAtIndex:indexPath.row];
    RCViewCell *cell = (RCViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[RCViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.rtLabel.delegate = self;
    RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:[rowInfo objectForKey:@"text"]];
    cell.rtLabel.componentsAndPlainText = componentsDS;
    return cell;
}
#pragma mark-
#pragma mark- rtLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSString*)url
{
    NSLog(@"url");
    if ([url hasPrefix:@"'liop"]) {
        NSLog(@"ok");
    }
}
#pragma mark-
#pragma mark keyboard notification
- (void)keyboardheightchange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRecttmp = [aValue CGRectValue];
    CGRect keyboardRect = [self.view convertRect:keyboardRecttmp fromView:nil];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    ScreenLandView *landView=(ScreenLandView *)self.view;
    ScreenViewController *screenVC=(ScreenViewController *)[self.parentViewController.parentViewController.childViewControllers objectAtIndex:0];
    NSLog(@"%f",SCREEN_FRAME_WIDTH);
    if (screenVC.playerLayer.frame.size.width==320) {
        
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        //动画持续时间
        [UIView setAnimationDuration:animationDuration];
        CGRect rect=landView.textField.frame;
        if (keyboardRect.origin.y==320-STATUSBAR_HEIGHT_IOS7) {
            landView.toolbarofkeyboard.frame=CGRectMake(0, 320-STATUSBAR_HEIGHT_IOS7, SCREEN_FRAME_HEIGHT,rect.size.height);
        }
        else
        {
            btnKeyboardDown.frame=CGRectMake(0, 0, SCREEN_FRAME_HEIGHT, SCREEN_FRAME_WIDTH-keyboardRect.size.height-rect.size.height-STATUSBAR_HEIGHT_IOS7);
            landView.toolbarofkeyboard.frame=CGRectMake(0, SCREEN_FRAME_WIDTH-keyboardRect.size.height-rect.size.height-STATUSBAR_HEIGHT_IOS7, SCREEN_FRAME_HEIGHT,rect.size.height);
            btnKeyboardDown.hidden=NO;
        }
        [UIView commitAnimations];
    }
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
-(void)messagereceived:(NSNotification *)noti
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    [self.dataArray addObject:[noti object]];
    [landView.table reloadData];
}
-(void)roominfogeted:(NSNotification *)noti
{
    Anchor *tmpanchor=[noti object];
    ScreenLandView *landView=(ScreenLandView *)self.view;
    [landView.personalinfoview.imgtou setImageWithURL:[NSURL URLWithString:tmpanchor.photoUrl]];
    [landView.personalinfoview.imgrank setImageWithURL:[NSURL URLWithString:tmpanchor.rankpic]];
    landView.personalinfoview.labelname.text=tmpanchor.nickName;
    landView.personalinfoview.labelranknum.text=tmpanchor.levelName;
    landView.personalinfoview.labelaudiencenum.text=[NSString stringWithFormat:@"(%d)人",tmpanchor.audicecount];
}
#pragma mark-
#pragma mark emotiondelegate
-(void)didselectemotion:(int)index
{
    ScreenLandView *landView=(ScreenLandView *)self.view;
    NSString *name=[landView.imgnamearray objectAtIndex:index];
    NSString *rep=[NSString stringWithFormat:@"[%@]",name];
    landView.textField.text=[NSString stringWithFormat:@"%@%@",landView.textField.text,rep];
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
            ScreenLandView *landView=(ScreenLandView *)self.view;
            landView.labeltitle.text=self.anchor.nickName;
            break;
        }
    }
}
@end

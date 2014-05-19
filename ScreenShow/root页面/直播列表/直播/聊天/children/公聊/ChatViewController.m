//
//  ChatViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-10.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ChatViewController.h"
#import "BigPresentViewController.h"
#import "ScreenViewController.h"
#import "RCLabel.h"
#import "RCViewCell.h"
#import "MySegmentViewController.h"
#import "Message.h"
#import "APService.h"
#import "BigPresentView.h"


@interface ChatViewController ()

@end

@implementation ChatViewController
#pragma mark-
#pragma mark- life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isemotionboardshow=NO;
        imgarray=[[NSMutableArray alloc] init];
        imgnamearray=[[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnKeyboardDown=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT)];
    [self.btnKeyboardDown addTarget:self action:@selector(btnKeyboardClicked:) forControlEvents:UIControlEventTouchDown];
    NSLog(@"%@",self.view);
    self.table.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, self.view.frame.size.height-80);
    self.bottomview.frame=CGRectMake(0, self.view.frame.size.height-80, SCREEN_FRAME_WIDTH, 80);
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardheightchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,30)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];
    [titleLabel setFont:[UIFont systemFontOfSize:20]];
    [titleLabel setText:@"RTLabel"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.dataArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(motionended:) name:@"motionended" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagereceived:) name:@"messagereceived" object:nil];
    if (IS_LOGIN) {
        //设置用户名称和房间名
        NSSet *set = [NSSet setWithObjects:[NSString stringWithFormat:@"%d",self.anchor.anchorid],nil];
        [APService setTags:set alias:[NSString stringWithFormat:@"%d",[[User shareUser] manID]] callbackSelector:nil target:self];
    }
    emotionscroller=[[EmotionScroller alloc] initWithFrame:CGRectMake(0, SCREEN_FRAME_HEIGHT-STATUSBAR_HEIGHT_IOS7-200, SCREEN_FRAME_WIDTH, 200)];
    emotionscroller.delegate1=self;
    for (int i=1; i<24; i++) {
        UIImage *image=nil;
        NSString *name=@"";
        if (i<10) {
            image=[UIImage imageNamed:[NSString stringWithFormat:@"00%d.png",i]];
            name=[NSString stringWithFormat:@"00%d",i];
        }
        else
        {
            image=[UIImage imageNamed:[NSString stringWithFormat:@"0%d.png",i]];
            name=[NSString stringWithFormat:@"0%d",i];
        }
        [imgarray addObject:image];
        [imgnamearray addObject:name];
    }
    emotionscroller.imgarray=imgarray;
    emotionscroller.colnum=4;
    emotionscroller.hidden=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    CGRect rect=self.bottomview.frame;
    self.table.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, self.view.frame.size.height-rect.size.height);
    self.bottomview.frame=CGRectMake(0, SCREEN_FRAME_HEIGHT-rect.size.height-STATUSBAR_HEIGHT_IOS7, 320, rect.size.height);
    [self.parentViewController.parentViewController.view addSubview:emotionscroller];
    [self.parentViewController.parentViewController.view addSubview:self.bottomview];
    self.btnKeyboardDown.hidden=YES;
    self.bottomview.hidden=NO;
    [self.parentViewController.parentViewController.view addSubview:self.btnKeyboardDown];
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
    }
    self.bottomview.hidden=YES;
    
    [bigPresentVC willMoveToParentViewController:nil];
    [bigPresentVC.view removeFromSuperview];
    [bigPresentVC removeFromParentViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark jpush delegate
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
#pragma mark-
#pragma mark keyboadr notification
- (void)keyboardheightchange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    
    ScreenViewController *screenVC=(ScreenViewController *)[self.parentViewController.parentViewController.childViewControllers objectAtIndex:0];
    if (screenVC.playerLayer.frame.size.width==SCREEN_FRAME_WIDTH) {
        
        [UIView beginAnimations:nil context:nil];
        //动画持续时间
        [UIView setAnimationDuration:animationDuration];
        CGRect rect=self.bottomview.frame;
        float loy=0;
        if (keyboardRect.origin.y==SCREEN_FRAME_HEIGHT) {
            if (isemotionboardshow) {
                emotionscroller.hidden=NO;
                loy=SCREEN_FRAME_HEIGHT-200-rect.size.height-STATUSBAR_HEIGHT_IOS7;
            }
            else
            {
                loy=SCREEN_FRAME_HEIGHT-rect.size.height-STATUSBAR_HEIGHT_IOS7;
                emotionscroller.hidden=YES;
            }
        }
        else
        {
            loy=SCREEN_FRAME_HEIGHT-keyboardRect.size.height-rect.size.height-STATUSBAR_HEIGHT_IOS7;
            self.btnKeyboardDown.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-rect.size.height-keyboardRect.size.height-STATUSBAR_HEIGHT);
            self.btnKeyboardDown.hidden=NO;
        }
        self.bottomview.frame=CGRectMake(0, loy, rect.size.width, rect.size.height);
        [UIView commitAnimations];
    }
    else
    {
    
    }
}
#pragma mark-
#pragma mark local method
-(void)btnKeyboardClicked:(UIButton *)sender
{
    [self.navigationController.view endEditing:YES];
    emotionscroller.hidden=YES;
    CGRect rect=self.bottomview.frame;
    self.bottomview.frame=CGRectMake(0, SCREEN_FRAME_HEIGHT-rect.size.height-STATUSBAR_HEIGHT_IOS7, SCREEN_FRAME_WIDTH, rect.size.height);
    sender.hidden=YES;
    [btnmotionkeyboard setImage:[UIImage imageNamed:@"chat_vc_emotion.png"] forState:UIControlStateNormal];
}
-(IBAction)btnSendPresentClicked:(id)sender
{
    if (IS_LOGIN) {
        bigPresentVC=[[BigPresentViewController alloc] initWithNibName:nil bundle:nil];
        bigPresentVC.isportrait=YES;
        bigPresentVC.anchor=self.anchor;
        [self addChildViewController:bigPresentVC];
        [self.view addSubview:bigPresentVC.view];
        [bigPresentVC didMoveToParentViewController:self];
        self.bottomview.hidden=YES;
        
        BigPresentView *lobigview=(BigPresentView *)bigPresentVC.view;
        [lobigview.btnx  addTarget:self action:@selector(singTapped:) forControlEvents:UIControlEventTouchDown];
    }
    else
    {
        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
-(void)singTapped:(UIView *)sender
{
    [btnmotionkeyboard setImage:[UIImage imageNamed:@"chat_vc_keyboard.png"] forState:UIControlStateNormal];
    self.bottomview.hidden=NO;
    [bigPresentVC willMoveToParentViewController:nil];
    [sender.superview removeFromSuperview];
    [bigPresentVC removeFromParentViewController];
}
-(IBAction)btnemotionClicked:(id)sender
{
    if (self.bottomview.frame.origin.y==SCREEN_FRAME_HEIGHT-self.bottomview.frame.size.height-STATUSBAR_HEIGHT) {
        isemotionboardshow=YES;
    }
    else
    {
        isemotionboardshow=!isemotionboardshow;
    }
    if (isemotionboardshow) {
        [self.navigationController.view endEditing:YES];
        CGRect rect=self.bottomview.frame;
        float loy=SCREEN_FRAME_HEIGHT-200-rect.size.height-STATUSBAR_HEIGHT_IOS7;
        self.bottomview.frame=CGRectMake(0, loy, rect.size.width, rect.size.height);
        emotionscroller.hidden=NO;
        
        self.btnKeyboardDown.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-loy-rect.size.height);
        self.btnKeyboardDown.hidden=NO;
        [btnmotionkeyboard setImage:[UIImage imageNamed:@"chat_vc_keyboard.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.textfield becomeFirstResponder];
        [btnmotionkeyboard setImage:[UIImage imageNamed:@"chat_vc_emotion.png"] forState:UIControlStateNormal];
    }
}
-(IBAction)btninfoClicked:(id)sender
{
    if (IS_LOGIN) {
        [self startnetwork:[NSString stringWithFormat:@"index.php/Api/Chat/sendMsg?uid=%d&zb_id=%d&content=%@",[[User shareUser] manID],self.anchor.anchorid,self.textfield.text]];
    }
    else
    {
        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    self.textfield.text=@"";
}
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
#pragma mark-
#pragma mark textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    isemotionboardshow=NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
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
#pragma mark emotiondelegate
-(void)didselectemotion:(int)index
{
    NSString *name=[imgnamearray objectAtIndex:index];
    NSString *rep=[NSString stringWithFormat:@"[%@]",name];
    self.textfield.text=[NSString stringWithFormat:@"%@%@",self.textfield.text,rep];
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
            MySegmentViewController *myparent=(MySegmentViewController *)self.parentViewController;
            myparent.selectindex=0;
            break;
        }
    }

}
-(void)messagereceived:(NSNotification *)noti
{
    [self.dataArray addObject:[noti object]];
    [self.table reloadData];
}
@end

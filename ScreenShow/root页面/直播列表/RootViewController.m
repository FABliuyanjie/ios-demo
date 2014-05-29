//
//  RootViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "RootViewController.h"
#import "LiveStudio.h"
#import "ScreenShow-Prefix.pch"
#import "LiveStudioViewController.h"
#import "ScreenViewController.h"
#import "ChatViewController.h"
#import "MySegmentViewController.h"
#import "AudienceViewController.h"
#import "FansViewController.h"
#import "RootPscollectionCell.h"
#import "UIImageView+WebCache.h"
#import "RootPscollectionCell.h"
#import "AFHTTPRequestOperation.h"
#import "AFAppDotNetAPIClient.h"
#import "Anchor.h"
#import "Topic.h"
#import "Program.h"
#import "MenuViewController.h"
#import "ToolpushLivestudioViewController.h"
#import "SubNSLayoutConstraint.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.anchorItems = [[NSMutableArray alloc] init];
        heightArray=[[NSMutableArray alloc] init];
        page=1;
        hasNext=NO;
        isloading=NO;
        datatype=-1;
    }
    return self;
}
-(void)initLoadingLabel
{
	loadingLabel = [[UILabel alloc] init];
	loadingLabel.frame = CGRectMake(loadingLabel.frame.origin.x, loadingLabel.frame.origin.y, loadingLabel.frame.size.width, 40);
	loadingLabel.font = [UIFont systemFontOfSize:14];
	loadingLabel.textColor = [UIColor lightGrayColor];
	loadingLabel.textAlignment = NSTextAlignmentCenter;
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.text = @"加载中...";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"直播";
    
    [self configurecollectionView:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(lefttableselect:) name:kLefttableselect object:nil];
    [self initLoadingLabel];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    isloading=YES;
    
    page=1;
    NSString *str;
    if (datatype==-1) {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?page=%d",page];
    }
    else
    {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?type=%d&page=1",datatype];
    }
    [self startnetwork:str isloadmore:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
-(void)fuck
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
   
    UIEdgeInsets currentInsets = collectionView.contentInset;
    currentInsets.top = 0;
    currentInsets.bottom = 0;
    collectionView.contentInset = currentInsets;
    [UIView commitAnimations];
    [loadingLabel removeFromSuperview];
}
-(void)startnetwork:(NSString *)prstr isloadmore:(BOOL)isloadmore
{
    moisloadmore=isloadmore;
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            isloading=NO;
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                if (isloadmore) {
                    page++;
                    [self performSelector:@selector(fuck) withObject:nil afterDelay:1.0];
                }
                else
                {
                    [self.anchorItems removeAllObjects];
                    [heightArray removeAllObjects];
                }
                if (![[lodic objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                    int i=0;
                   
                    NSArray *loarray=[lodic valueForKey:@"data"];
                    if (loarray.count!=0) {
                        for (NSDictionary *lodic1 in [lodic objectForKey:@"data"]) {
                            if (![lodic1 isKindOfClass:[NSNull class]]) {
                                Anchor *anchor=[[Anchor alloc] init];
                                if (![[lodic1 valueForKey:@"user_id"] isKindOfClass:[NSNull class]]) {
                                    anchor.anchorid=[[lodic1 objectForKey:@"user_id"] intValue];
                                }
                                if (![[lodic1 valueForKey:@"mx_jm_img"] isKindOfClass:[NSNull class]]) {
                                    anchor.photoUrl=[lodic1 objectForKey:@"mx_jm_img"];
                                }
                                if (![[lodic1 valueForKey:@"nick_name"] isKindOfClass:[NSNull class]]) {
                                    anchor.nickName=[lodic1 objectForKey:@"nick_name"];
                                }
                                if (![[lodic1 valueForKey:@"num"] isKindOfClass:[NSNull class]]) {
                                    anchor.audicecount=[[lodic1 objectForKey:@"num"] intValue];
                                }
                                anchor.talknotice=[lodic1 objectForKey:@"talk_notice"];
                                UIFont *font = [UIFont systemFontOfSize:13];
                                CGSize size = CGSizeMake(157,INT_MAX);
                                CGSize labelsize = [anchor.talknotice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
                                int topheight=0;
                                if (i==1) {
                                    topheight=45;
                                }
                                [heightArray addObject:[NSNumber numberWithInt:(157+topheight+4+labelsize.height)]];
                                [self.anchorItems addObject:anchor];
                                i++;
                            }
                        }
                    }
                }
                
                if ([[lodic valueForKey:@"other"] respondsToSelector:@selector(isEqualToString:)]) {
                    
                }
                else
                {
                    hasNext=[[[lodic valueForKey:@"other"] valueForKey:@"hasnext"] boolValue];
                }
                [self startnetworkofonlinecount:@"index.php/Api/User/allNum"];
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
          [self refreshTable];
        //
        NSLog(@"%@",error);
          isloading=NO;
          
    }];
}
-(void)startnetworkofonlinecount:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                onlinecount=1230;
            }
            else
            {
                
            }
            if (moisloadmore) {
                
            }
            else
            {
                [self refreshTable];
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
-(void)configurecollectionView:(PullPsCollectionView *)prcollectionView
{
    
    collectionView = [[PullPsCollectionView alloc] initWithFrame:CGRectZero];
    [collectionView sizeToFit];
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(00.0f)]];
    
    
    [self.view addSubview:collectionView];
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.pullDelegate=self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.numColsPortrait = 2;
    collectionView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    collectionView.pullBackgroundColor = [UIColor yellowColor];
    collectionView.pullTextColor = [UIColor blackColor];
    UILabel *loadingLabel1 = [[UILabel alloc] initWithFrame:collectionView.bounds];
    loadingLabel1.text = @"Loading...";
    loadingLabel1.textAlignment = NSTextAlignmentCenter;
    collectionView.loadingView = loadingLabel1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) refreshTable
{
    /*
     Code to actually refresh goes here.
     */
    collectionView.pullLastRefreshDate = [NSDate date];
    collectionView.pullTableIsRefreshing = NO;
    [collectionView reloadData];
}
- (void) loadMoreDataToTable
{
    /*
     Code to actually load more data goes here.
     */
    //    [self loadDataSource];
    [collectionView reloadData];
}
- (int)arrarCounttoRow:(int)prcount
{
    if (prcount<=4) {
        if (prcount%2==0) {
            return prcount/2;
        }
        return prcount/2+1;
    }
    else
    {
        if ((prcount-4)%3==0) {
            return 2+(prcount-4)/3;
        }
        return 2+(prcount-4)/3+1;
    }
}
- (void)addTapgesture:(UIView *)prView
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [prView addGestureRecognizer:tapGesture];
}
- (void)viewTapped:(int)sender
{
    [ToolpushLivestudioViewController pushLiveStudioVC:[self.anchorItems objectAtIndex:sender] anchorItems:self.anchorItems vc:self];
}
#pragma mark-
#pragma mark notification
-(void)lefttableselect:(NSNotification *)noti
{
    NSMutableArray *loarray=(NSMutableArray *)[noti object];
     NSString *str=@"";
    datatype=[[loarray objectAtIndex:1] integerValue];
    page=1;
    isloading=YES;
    if (datatype==-1) {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?page=%d",page];
    }
    else
    {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?type=%d&page=1",datatype];
    }
    [self startnetwork:str isloadmore:NO];
}
#pragma mark-
#pragma mark RootChildPrototal
- (void)startChangeDatasource
{
    
}
#pragma mark-
#pragma mark screenVC delegate
-(void)datasourcechanged
{
//    [self refreshdata];
}
#pragma mark-
#pragma mark screenVC delegate
-(void)datasourcechanged1
{
//    [self refreshdata];
}
#pragma mark - PullTableViewDelegate

- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
{
    NSString *str=@"";
    page=1;
    isloading=YES;
    if (datatype==-1) {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?page=%d",page];
    }
    else
    {
        str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?type=%d&page=%d",datatype,page];
    }
    [self startnetwork:str isloadmore:NO];
}
- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
{
    
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}
- (void)didscrolltobottom
{
    if (!isloading) {
        hasNext=YES;
        if (hasNext) {
            NSString *str=@"";
            isloading=YES;
            str=[NSString stringWithFormat:@"index.php/Api/Show/showlist?type=%d&page=%d",datatype,page+1];
            [self startnetwork:str isloadmore:YES];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            
            UIEdgeInsets currentInsets = collectionView.contentInset;
            currentInsets.top = -30;
            currentInsets.bottom=30;
            collectionView.contentInset = currentInsets;
            [UIView commitAnimations];
            loadingLabel.frame = CGRectMake(0, collectionView.contentSize.height, SCREEN_WIDTH, 30);
            [collectionView addSubview:loadingLabel];
            
        }
        else
        {
        }
    }
}
#pragma mark -
#pragma mark collectionview delegate
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView1 viewAtIndex:(NSInteger)index {
    RootPscollectionCell *v = (RootPscollectionCell *)[collectionView1 dequeueReusableView];
    if(v == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"RootPscollectionCell" owner:self options:nil];
        v = [nib objectAtIndex:0];
        [self cellautolayout:v];
    }
    for (int i=0; i<v.constraints.count; i++) {
        SubNSLayoutConstraint *losublayout=[v.constraints objectAtIndex:i];
        if ([losublayout respondsToSelector:@selector(setTag:)]) {
            if (losublayout.tag==100) {
                [v removeConstraint:losublayout];
            }
        }
    }
    SubNSLayoutConstraint *sublayout=nil;
    if (index==1) {
        sublayout=[SubNSLayoutConstraint constraintWithItem:v.viewtop attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(45)];
        sublayout.tag=100;
        [v addConstraint:sublayout];
        v.viewtop.hidden=NO;
        v.labelonlinenum.text=[NSString stringWithFormat:@"%d",onlinecount];
    }
    else
    {
         sublayout=[SubNSLayoutConstraint constraintWithItem:v.viewtop attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeHeight multiplier:0.0f constant:(0)];
        sublayout.tag=100;
         [v addConstraint:sublayout];
         v.viewtop.hidden=YES;
    }
    [v setNeedsUpdateConstraints];
    Anchor *anchor=[self.anchorItems objectAtIndex:index];
    if ([anchor.photoUrl class]!=[NSNull class]) {
        [v.picView setImageWithURL:[NSURL URLWithString:anchor.photoUrl]];
    }
    v.labelaudicecount.text=[NSString stringWithFormat:@"%d",anchor.audicecount];
    v.labenickname.text=anchor.nickName;
    v.labelmotto.text=anchor.talknotice;
    return v;
}
-(void)cellautolayout:(RootPscollectionCell *)v;
{
    [v.viewtop sizeToFit];
    [v.viewtop setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    
    
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.viewtop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeTop multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.viewtop attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.viewtop attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
    
    [v.picView sizeToFit];
    [v.picView setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.picView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v.viewtop attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(1)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.picView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.picView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.picView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
    
    
    [v.view1 sizeToFit];
    [v.view1 setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    
    
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v.picView attribute:NSLayoutAttributeHeight multiplier:0.2f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v.picView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:v.picView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
    
    
    
    [v.picViewAudience sizeToFit];
    [v.picViewAudience setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.picViewAudience attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeHeight multiplier:0.6f constant:(0)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.picViewAudience attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeHeight multiplier:0.6f constant:(0)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.picViewAudience attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(0)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.picViewAudience attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(10)]];
    
    [v.labelaudicecount sizeToFit];
    [v.labelaudicecount setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.labelaudicecount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v.picViewAudience attribute:NSLayoutAttributeRight multiplier:1.0f constant:(3)]];
    
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.labelaudicecount attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v.picViewAudience attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(0)]];
    
    [v.labenickname sizeToFit];
    [v.labenickname setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.labenickname attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeRight multiplier:1.0f constant:(0.0f)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.labenickname attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v.picViewAudience attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(0)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.labenickname attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v.view1 attribute:NSLayoutAttributeRight multiplier:1.0f constant:(-10)]];
    
    
    v.viewbgofname.layer.cornerRadius = 3;//设置那个圆角的有多圆
    v.viewbgofname.layer.masksToBounds = YES;//设为NO去试试
    [v.viewbgofname sizeToFit];
    [v.viewbgofname setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.viewbgofname attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v.labenickname attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(10.0f)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.viewbgofname attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v.labenickname attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(10.0f)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.viewbgofname attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v.labenickname attribute:NSLayoutAttributeRight multiplier:1.0f constant:(5.0f)]];
    [v.view1 addConstraint:[NSLayoutConstraint constraintWithItem:v.viewbgofname attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v.labenickname attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(0)]];
    
    
    [v.labelmotto sizeToFit];
    [v.labelmotto setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.labelmotto attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(0)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.labelmotto attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v.picView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(1)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.labelmotto attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(0.0f)]];
    [v addConstraint:[NSLayoutConstraint constraintWithItem:v.labelmotto attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0)]];
}
- (CGFloat)heightForViewAtIndex:(NSInteger)index {
//    return 200;
    return [[heightArray objectAtIndex:index] floatValue];
}
- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    // Do something with the tap
    [self viewTapped:index];
}
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.anchorItems count];
}
- (void)dataSourceDidLoad {
    [collectionView reloadData];
}
- (void)dataSourceDidError {
    [collectionView reloadData];
}
@end

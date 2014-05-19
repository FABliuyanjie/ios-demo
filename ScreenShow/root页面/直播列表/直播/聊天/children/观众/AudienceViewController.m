//
//  AudienceViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AudienceViewController.h"
#import "AudienceTableViewCell.h"
#import "Audience.h"
#import "MySegmentViewController.h"
#import "UIImageView+WebCache.h"

@interface AudienceViewController ()

@end

@implementation AudienceViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.audienceArray=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hasNext = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(motionended:) name:@"motionended" object:nil];
}

-(void)addRefreshTableHeaderView
{
    if (self.header == nil) {
		self.header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableview.bounds.size.height, self.view.frame.size.width, self.tableview.bounds.size.height)];
		self.header.delegate = self;
		[self.tableview addSubview:self.header];
	}
}

//上拉加载更多
-(void)initialLoadingLabel{
	_loadingLabel = [[UILabel alloc] init];
	_loadingLabel.frame = CGRectMake(_loadingLabel.frame.origin.x, _loadingLabel.frame.origin.y, _loadingLabel.frame.size.width, 40);
	_loadingLabel.font = [UIFont systemFontOfSize:14];
	_loadingLabel.textColor = [UIColor lightGrayColor];
	_loadingLabel.textAlignment = NSTextAlignmentCenter;
	_loadingLabel.backgroundColor = [UIColor clearColor];
	_loadingLabel.text = @"加载中...";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.tableview.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, self.view.frame.size.height);
//    if (self.header == nil) {
//		self.header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableview.bounds.size.height, self.view.frame.size.width, self.tableview.bounds.size.height)];
//		self.header.delegate = self;
//		[self.tableview addSubview:self.header];
//	}
    
    [self addRefreshTableHeaderView];
    [self initialLoadingLabel];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"audice will appear");
    [super viewWillAppear:YES];
    
    self.page = 1;
    [self requestDataWithPage:self.page];
}

#pragma mark reload data
-(void)requestDataWithPage:(NSInteger)page
{
    NSString *lostr=[NSString stringWithFormat:@"index.php/Api/Show/roomAudienceInfo?id=%d&page=%d",self.anchor.anchorid, page];
    
    NSLog(@"requestAddress = %@", lostr);
    
    [[AFAppDotNetAPIClient sharedClient] GET:lostr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"观众下载完成： = %@",responseObject);
        
        @try {
            self.isloading = NO;
            
            [self reloadDataSuccess:responseObject];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isloading = NO;
        
        [self reloadDataFailed:error];
    }];
    
}

-(void)reloadDataSuccess:(NSDictionary *)noti
{
    [self doneLoadingTableViewData];
    NSDictionary *lodic=(NSDictionary *)noti;
    if ([[lodic objectForKey:@"status"] integerValue]==1) {
        
        if (self.page == 1 && self.audienceArray.count != 0 && lodic != nil) {
            [self.audienceArray removeAllObjects];
        }
        
        self.page += 1;
        
        NSDictionary *lodic1 =[lodic valueForKey:@"data"];
        if (![[lodic1 valueForKey:@"user_info"] isKindOfClass:[NSNull class]]) {
            for (NSDictionary *lodic2 in [lodic1 valueForKey:@"user_info"]) {
                Audience *audience=[[Audience alloc] init];
                audience.manID=[[lodic2 valueForKey:@"user_id"] intValue];
                audience.nickName=[lodic2 valueForKey:@"nick_name"];
                audience.levelName=[lodic2 valueForKey:@"user_consume_rank"];
                audience.mxJmImg = [lodic2 valueForKey:@"user_consume_rank_img"];
                audience.manType = [[lodic2 valueForKey:@"user_type"] intValue];
                [self.audienceArray addObject:audience];
            }
        }
        if (![[lodic1 valueForKey:@"other"] isKindOfClass:[NSNull class]]) {
            NSDictionary * other = [ lodic1 objectForKey:@"other"];
            if (![[other objectForKey:@"hasnext"] isKindOfClass:[NSNull class]]) {
                self.hasNext = [[other objectForKey:@"hasnext"] boolValue];
            }
        }
        [self.tableview setTableFooterView:self.hasNext?_loadingLabel:nil];
        [self.tableview reloadData];

    }
    else
    {
        
    }
}

-(void)reloadDataFailed:(NSError *)error
{
    [self doneLoadingTableViewData];
    NSLog(@"%@",error);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSections
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.audienceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AudienceTableViewCell";
    AudienceTableViewCell *cell = (AudienceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AudienceTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1];
    }
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    Audience *audience=[self.audienceArray objectAtIndex:indexPath.row];
    cell.labelname.text=audience.nickName;
    cell.labelrank.text=audience.levelName;
    [cell.imgview setImageWithURL:[NSURL URLWithString:audience.mxJmImg]];
    if (audience.manType == 2) {
        [cell.audienceImageView setTitle:@"主播" forState:UIControlStateNormal];
        [cell.audienceImageView setBackgroundImage:[UIImage imageNamed:@"hostBackroundImge.png"] forState:UIControlStateNormal];

    }
    else if (audience.manType == 1){
        [cell.audienceImageView setTitle:@"观众" forState:UIControlStateNormal];
        [cell.audienceImageView setBackgroundImage:[UIImage imageNamed:@"audienceBackgroundImg.png"] forState:UIControlStateNormal];

    }
    return cell;
}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	self.isloading = YES;
    self.hasNext = YES;
    self.page = 1;
    [self requestDataWithPage:self.page];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    if (	self.isloading == NO) {
        [self.header egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableview];
    }
	
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.header egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.header egoRefreshScrollViewDidEndDragging:scrollView];
    
    if (scrollView.contentOffset.y + scrollView.height >= scrollView.contentSize.height) {
        if (self.hasNext &&!self.isloading) {
			self.isloading = YES;
            [self requestDataWithPage:self.page];
            self.hasNext = NO;
		}
	}
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return self.isloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
#pragma mark-
#pragma mark -nsnotification
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
@end

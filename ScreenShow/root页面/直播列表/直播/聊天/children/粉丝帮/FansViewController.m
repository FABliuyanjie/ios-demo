//
//  FansViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "FansViewController.h"
#import "FansTableViewCell.h"
#import "Fan.h"
#import "UIImageView+WebCache.h"
#import "MySegmentViewController.h"


@interface FansViewController ()

@end

@implementation FansViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fansArray=[[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [super viewWillAppear:YES];
    NSLog(@"fanswillappear");
    
    self.page = 1;
    
    [self requestDataWithPage:self.page];
}

-(void)requestDataWithPage:(NSInteger)page
{
    NSString *lostr=[NSString stringWithFormat:@"index.php/Api/Show/anchorFen?id=%d&page=%d",self.anchor.anchorid, page];
//    NSString *lostr=[NSString stringWithFormat:@"index.php/Api/Show/anchorFen?id=%d&page=1",30];

    [[AFAppDotNetAPIClient sharedClient] GET:lostr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

-(void)reloadDataSuccess:(NSDictionary *)dict
{
    NSLog(@"粉丝榜请求结果：%@",dict);
    [self doneLoadingTableViewData];

    if ([[dict objectForKey:@"status"] integerValue]==1) {
        if (![[dict valueForKey:@"data"] isKindOfClass:[NSNull class]]) {
            NSDictionary *lodic1 =[dict valueForKey:@"data"];
            
            if (self.page == 1 && self.fansArray.count != 0 && lodic1 != nil) {
                [self.fansArray removeAllObjects];
            }
            
            self.page += 1;
            
            for (NSDictionary *lodic2 in lodic1) {
                Fan *fan=[[Fan alloc] init];
                fan.manID=[[lodic2 valueForKey:@"fen_id"] intValue];
                if (![[lodic2 valueForKey:@"fen_name"] isKindOfClass:[NSNull class]]) {
                    fan.nickName=[lodic2 valueForKey:@"fen_name"];
                }
                if (![[lodic2 valueForKey:@"fen_rank"] isKindOfClass:[NSNull class]]) {
                    fan.levelName=[lodic2 valueForKey:@"fen_rank"];
                }
                if (![[lodic2 valueForKey:@"consume"] isKindOfClass:[NSNull class]]) {
                    fan.spendMoney=[[lodic2 valueForKey:@"consume"] floatValue];
                }
                fan.photoUrl=[lodic2 valueForKey:@"fen_img"];
                fan.consumeUrl=[lodic2 valueForKey:@"consume_rank_img"];
                [self.fansArray addObject:fan];
            }
        }
        if (![[dict valueForKey:@"other"] isKindOfClass:[NSNull class]]) {
            NSDictionary * other = [ dict objectForKey:@"other"];
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
    return self.fansArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FansTableViewCell";
    FansTableViewCell *cell = (FansTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"FansTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.labelnum.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    if (indexPath.row==0) {
        cell.imgview1.image=[UIImage imageNamed:@"fans_vc_rank0.png"];
    }
    else if (indexPath.row==1)
    {
        cell.imgview1.image=[UIImage imageNamed:@"fans_vc_rank1.png"];
    }
    else
    {
        cell.imgview1.image=[UIImage imageNamed:@"fans_vc_rank2.png"];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1];
    }
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.imgview.layer.cornerRadius=5;
    cell.imgview.layer.masksToBounds=YES;
    Fan *fan=[self.fansArray objectAtIndex:indexPath.row];
    [cell.imgview setImageWithURL:[NSURL URLWithString:fan.photoUrl]];
    [cell.imgview2 setImageWithURL:[NSURL URLWithString:fan.consumeUrl]];
    
    cell.labelname.text=fan.nickName;
    cell.labelcostmoney.text=[NSString stringWithFormat:@"%.0f币",fan.spendMoney];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
	if (self.isloading == NO) {
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
            //            self.page += 1;
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
@end

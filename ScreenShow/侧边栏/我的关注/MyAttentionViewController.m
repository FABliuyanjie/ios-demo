//
//  MyAttentionViewController.m
//  ScreenShow
//
//  Created by lee on 14-4-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "MyAttentionTableViewCell.h"
#import "Anchor.h"
#import "ToolpushLivestudioViewController.h"
#import "UIImageView+WebCache.h"

#define HttpUrlRequestAttention  @"index.php/Api/Show/interest?"

@interface MyAttentionViewController ()

@end

@implementation MyAttentionViewController
{
    BOOL _hasNext;
    int _page;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        anchorItems=[[NSMutableArray alloc] init];
        self.firstIn = YES;

    }
    return self;
}

-(void)initLoadingLabel
{
	_loadingLabel = [[UILabel alloc] init];
	_loadingLabel.frame = CGRectMake(_loadingLabel.frame.origin.x, _loadingLabel.frame.origin.y, _loadingLabel.frame.size.width, 40);
	_loadingLabel.font = [UIFont systemFontOfSize:14];
	_loadingLabel.textColor = [UIColor lightGrayColor];
	_loadingLabel.textAlignment = NSTextAlignmentCenter;
	_loadingLabel.backgroundColor = [UIColor clearColor];
	_loadingLabel.text = @"加载中...";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.table sizeToFit];
    [self.table setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(00.0f)]];
//    加载更多
    [self initLoadingLabel];
    _page = 1;
    _hasNext = NO;
    if (self.header == nil) {
		self.header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, self.view.frame.size.width, self.table.bounds.size.height)];
		self.header.delegate = self;
		[self.table addSubview:self.header];
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstIn) {
        self.firstIn = NO;
        
        if (IS_LOGIN) {
            
            [self startnetwork:HttpUrlRequestAttention withPage:_page];
        }
        else
        {
            UIViewController *loLogin = [[UIStoryboard storyboardWithName:@"MyStoryBoard" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
            [self.navigationController pushViewController:loLogin animated:YES];
        }
    }
    else
    {
        if (IS_LOGIN) {
        }
        else
        {
            [anchorItems removeAllObjects];
            [self.table reloadData];
        }

    }
}

-(void)startnetwork:(NSString *)prstr withPage:(NSInteger)page
{
    
    NSString * url = [NSString stringWithFormat:@"%@page=%d&id=%d", prstr, page, [[User shareUser] manID]];
    
    NSLog(@"请求url = %@",url);
    
    [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isloading = NO;

        //
        NSLog(@"%@",responseObject);
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                _page += 1;

                if (anchorItems.count != 0) {
                    [anchorItems removeAllObjects];
                }
                
                if (![[lodic objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
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
                            anchor.levelName=[lodic1 valueForKey:@"rank_name"];
                            anchor.rankpic=[lodic1 valueForKey:@"rank_img"];
                            anchor.isonline=[[lodic1 valueForKey:@"online"] integerValue];
                            [anchorItems addObject:anchor];
                        }
                    }
                    if (![[lodic objectForKey:@"other"] isKindOfClass:[NSNull class]]) {
                        if (![[[lodic objectForKey:@"other"] objectForKey:@"hasNext"] isKindOfClass:[NSNull class]]) {
                            _hasNext = [[[lodic objectForKey:@"other"] objectForKey:@"hasNext"] boolValue];
                        }
                    }
                    
                    [self.table setTableFooterView:_hasNext ? _loadingLabel:nil];
                    [self doneLoadingTableViewData];
                    [self.table reloadData];
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
        self.isloading = NO;
        [self doneLoadingTableViewData];
        //
        NSLog(@"%@",error);
    }];
}
-(void)celldeleteclicked:(UIButton *)sender
{
    Anchor *anchor=[anchorItems objectAtIndex:sender.tag];
    __weak UITableView *weaktableview=self.table;
    __weak NSMutableArray *weakarray=anchorItems;
    __weak UIButton *weaksender=sender;
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"index.php/Api/Show/anchorInterestDelete?id=%d&user_id=%d",anchor.anchorid,[[User shareUser] manID]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *lodic=(NSDictionary *)responseObject;
        NSLog(@"%@",[lodic objectForKey:@"info"]);
        if ([[lodic objectForKey:@"status"] integerValue]==1) {
            [weakarray removeObjectAtIndex:weaksender.tag];
            [weaktableview reloadData];
        }
        else
        {
            UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"删除失败" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alter show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)taped:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    [ToolpushLivestudioViewController pushLiveStudioVC:[anchorItems objectAtIndex:[tap view].tag] anchorItems:anchorItems vc:self];
}

#pragma mark-
#pragma mark uitableview delegate

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return anchorItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyAttentionTableViewCell";
    MyAttentionTableViewCell *cell = (MyAttentionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyAttentionTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0];
    }
    else
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    cell.btndelete.tag=indexPath.row;
    [cell.btndelete addTarget:self action:@selector(celldeleteclicked:) forControlEvents:UIControlEventTouchDown];
    cell.imgview.layer.cornerRadius=5;
    cell.imgview.layer.masksToBounds = YES;
    cell.imgview.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
    [cell.imgview addGestureRecognizer:tap];
    UIView *tapView = [tap view];
    tapView.tag = [indexPath row];
    
    
    Anchor *anchor=[anchorItems objectAtIndex:[indexPath row]];
    cell.labelname.text=anchor.nickName;
    cell.labelrank.text=[NSString stringWithFormat:@"%@",anchor.levelName];
    cell.labelnum.text=[NSString stringWithFormat:@"(%d人)",anchor.audicecount];
    [cell.imgview setImageWithURL:[NSURL URLWithString:anchor.photoUrl]];
    [cell.imgview1 setImageWithURL:[NSURL URLWithString:anchor.rankpic]];
    if (anchor.isonline) {
        cell.labelonline.text=@"正在直播";
    }
    else
    {
        cell.labelonline.text=@"没有直播";
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	self.isloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    if (self.isloading == NO) {
        [self.header egoRefreshScrollViewDataSourceDidFinishedLoading:self.table];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.header egoRefreshScrollViewDidScroll:scrollView];
    if (scrollView.contentOffset.y + scrollView.height >= scrollView.contentSize.height) {
        if (_hasNext &&!self.isloading) {
			self.isloading = YES;
            [self startnetwork:HttpUrlRequestAttention withPage:_page];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.header egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    _page = 1;
    [self startnetwork:HttpUrlRequestAttention withPage:_page];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return self.isloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end

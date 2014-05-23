//
//  RechangViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//
#import "ReChangItem.h"
#import "RechangViewController.h"
#import "LogInViewController.h"



#import "CostListCell.h"
extern const double cDay;
extern const double cWeek ;
extern const double cMonth ;
@interface RechangViewController ()<UIAlertViewDelegate>

@end

@implementation RechangViewController

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

    self.title = @"充值记录";
    
    //选择时间段，下拉列表
    NSArray *combineData = @[@"最近一天",@"最近一周",@"最近一个月",@"全部"];
    self.timeSelectView = [[ComboBoxView alloc]initWithFrame:CGRectMake(7, 0, 306, 100)];
    self.timeSelectView.delegate = self;
    self.timeSelectView.comboBoxDatasource = combineData;
    self.timeSelectView.backgroundColor = [UIColor whiteColor];
    [self.timeSelectView setContent:@"请选择时间段"];
    [self.view addSubview:self.timeSelectView];

    //记录显示表格
    _tableView  =[[PullTableView alloc]initWithFrame:CGRectMake(0,_timeSelectView.bottom + 10, 320, SCREEN_HEIGHT - 64 - 50 -_timeSelectView.bottom - 10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.pullDelegate = self;
    [self.view addSubview:_tableView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self downloadDataAdd:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 30;
    }
    return 56.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fiteredArray.count+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"costList";
    static NSString *idCell2 = @"headerView";
    if (indexPath.row==0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell2];
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        UIFont *font1 = [UIFont systemFontOfSize:14];
        
        NSString *str1 = @"共充值";
        CGSize size1 = [str1 sizeWithFont:font1];
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, size1.width, 20)];
        lb1.font = font1;
        lb1.text = str1;
        [headView addSubview:lb1];
        
        CGSize size2 = [_money sizeWithFont:font1];
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(lb1.right, 5, size2.width, 20)];
        lb2.font =font1;
        lb2.textColor = [UIColor redColor];
        lb2.text = _money;
        [headView addSubview:lb2];
        
        NSString *str3 = @"元，获得F币";
        CGSize size3 = [str3 sizeWithFont:font1];
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(lb2.right, 5, size3.width, 20)];
        lb3.font =font1;
        lb3.text = str3;
        [headView addSubview:lb3];
        
        CGSize size4 = [_fmoney sizeWithFont:font1];
        UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(lb3.right, 5, size4.width, 20)];
        lb4.textColor = [UIColor redColor];
        lb4.font = font1;
        lb4.text = _fmoney;
        [headView addSubview:lb4];
        
        NSString *str5 = @"个";
        CGSize size5 = [str5 sizeWithFont:font1];
        UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(lb4.right, 5, size5.width, 20)];
        lb5.text = str5;
        lb5.font = font1;
        [headView addSubview:lb5];
        
        [cell addSubview:headView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CostListCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CostListCell" owner:self options:nil]lastObject];
        }
        ReChangItem *item = _fiteredArray[indexPath.row-1];
        cell.firstLb.text = [NSString stringWithFormat:@"金额：%@元",item.total_fee];
        
        cell.secondLb.text = [NSString stringWithFormat:@"F币：%ld个",(long)item.f_money];
        cell.threeLb.text = item.time;
        cell.fourLb.hidden = YES;
        
        if (indexPath.row % 2 != 0) {
            cell.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1];
        }else{
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark - CombineBox Delegate
-(void)comboxCellDidSelected:(ComboBoxView*)combox atIndex:(NSIndexPath*)index;
{
    INFO(@"select:%d",index.row);
    _type = index.row;
    [self fiterResultArray:_type];
    [self.tableView reloadData];
    
}

-(void)comboxCellWillSelected
{
    [self.view bringSubviewToFront:self.timeSelectView];
}


#pragma mark - PullTableView Delegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self downloadDataAdd:NO];
    
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self downloadDataAdd:YES];
}

#pragma mark -Load Data
-(void)downloadDataAdd:(BOOL)isAdd
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",self.urlStr,[User shareUser].token];
    [[AFAppDotNetAPIClient sharedClient]GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int status = [responseObject[@"status"]integerValue];
        NSString *info = responseObject[@"info"];
        self.info.text = info;
        if (status==1) {
            NSDictionary *data = responseObject[@"data"];
            _money = [NSString stringWithFormat:@"%@",data[@"all_money"]];
            _fmoney = [NSString stringWithFormat:@"%@",data[@"all_f"]];
            
            NSArray *log = data[@"log"];
            
            if (_totalArray==nil) {
                _totalArray = [[NSMutableArray alloc]initWithCapacity:log.count];
            }else{
                [_totalArray removeAllObjects];
            }
            
            for (NSDictionary *subDict in log) {
                ReChangItem *item = [[ReChangItem alloc]initWithDict:subDict];
                [_totalArray addObject:item];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"info" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self.tableView reloadData];
        [self fiterResultArray:_type];
        if (isAdd==YES) {
            self.tableView.pullTableIsLoadingMore = NO;
        }else{
            self.tableView.pullTableIsRefreshing = NO;
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//      UIAlertView *alert = [UIAlertView alloc]i
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [TOOL showLoginViewControllerForm:self Push:YES];
    }
}

-(BOOL)fiterResultArray:(kFiterType)type
{

    if (_totalArray==nil || _totalArray.count==0) {
        self.info.text = @"无充值记录";
        self.tableView.backgroundColor = [UIColor clearColor];
        return NO;
    }
    NSTimeInterval retainTime;
    NSTimeInterval nowInterval = [[NSDate date]timeIntervalSince1970];
    
    switch (type) {
        case ThisDay:
            retainTime = nowInterval-cDay;
            break;
        case ThisWeek:
            retainTime = nowInterval-cWeek;
            break;
        case ThisMonth:
            retainTime = nowInterval-cMonth;
            break;
        case ALL:
            retainTime = 0;
        default:
            break;
    }
    
    if (_fiteredArray==nil ) {
        _fiteredArray = [[NSMutableArray alloc]init];
    }else if (_fiteredArray.count!=0){
        [_fiteredArray removeAllObjects];
    }
    
    for (ReChangItem *item in _totalArray) {
        NSTimeInterval time = [item.add_time doubleValue];
        if (time-retainTime>=0) {
            [_fiteredArray addObject:item];
        }
    }
    if (_fiteredArray==nil || _fiteredArray.count==0) {
        self.info.text = @"无充值记录";
         self.tableView.backgroundColor = [UIColor clearColor];
    }else{
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView reloadData];
    }

    return YES;
}
@end

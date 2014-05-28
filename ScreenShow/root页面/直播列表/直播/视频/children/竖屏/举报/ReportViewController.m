//
//  ReportViewController.m
//  ScreenShow
//
//  Created by lee on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportTableViewCell.h"


@interface ReportViewController ()

@end

@implementation ReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrayContent=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.arrayContent addObject:@"政治非法内容"];
    [self.arrayContent addObject:@"色情内容"];
    [self.arrayContent addObject:@"低俗内容"];
    table.scrollEnabled=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnbackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)startnetworkofreport:(NSString *)prstr
{
    [[AFAppDotNetAPIClient sharedClient] GET:prstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                
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
        NSLog(@"%@",error);
    }];
    
}
-(void)cellbtnClicked:(UIButton *)sender
{
    [self startnetworkofreport:[NSString stringWithFormat:@"index.php/Api/Show/report?user_id=%d&anchor_id=%d&type=%d",[[User shareUser] manID],self.anchor.anchorid,sender.tag+1]];
}
#pragma mark-
#pragma mark uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.arrayContent.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReportTableViewCell";
    ReportTableViewCell *cell = (ReportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ReportTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    cell.btn.tag=indexPath.row;
    [cell.btn setTitle:[self.arrayContent objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.btn addTarget:self action:@selector(cellbtnClicked:) forControlEvents:UIControlEventTouchDown];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row!=3) {
//       [self startnetworkofreport:[NSString stringWithFormat:@"index.php/Api/Show/report?user_id=%d&anchor_id=%d&type=%d",[[User shareUser] manID],self.anchor.anchorid,indexPath.row+1]];
//    }
//    else
//    {
//    
//    }
}
@end

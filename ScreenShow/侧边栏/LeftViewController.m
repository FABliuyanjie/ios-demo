//
//  LeftViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-19.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "Program.h"
#import "Topic.h"
#import "ScreenShow-Prefix.pch"
#import "AFHTTPRequestOperationManager.h"
#import "MenuViewController.h"


@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.programArray=[[NSMutableArray alloc] init];
        self.topicArray=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startnetwork];
    [self startnetworkofall];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:self options:nil];
    LeftTableViewCell *header = [array objectAtIndex:0];
    header.frame=CGRectMake(0, 0, SCREEN_FRAME_WIDTH, 55);
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headclicked:)];
    [header addGestureRecognizer:singletap];
    
    
    
    
    
    CGRect rect=header.label.frame;
    CGSize fitLabelSize = CGSizeMake(MAXFLOAT,rect.size.height);
    CGSize labelSize = [header.label.text sizeWithFont:header.label.font constrainedToSize:fitLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    header.label.frame=CGRectMake(rect.origin.x, rect.origin.y, labelSize.width, rect.size.height);
    header.label.text=@"全部";
    
    [header.label sizeToFit];
    [header.label setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [header addConstraint:[NSLayoutConstraint constraintWithItem:header.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:header attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(20.0f)]];
    [header addConstraint:[NSLayoutConstraint constraintWithItem:header.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:header attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:(00.0f)]];
    
    
    [header.labelnum sizeToFit];
    [header.labelnum setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [header addConstraint:[NSLayoutConstraint constraintWithItem:header.labelnum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:header.label attribute:NSLayoutAttributeRight multiplier:1.0f constant:(10.0f)]];
    [header addConstraint:[NSLayoutConstraint constraintWithItem:header.labelnum attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:header.label attribute:NSLayoutAttributeBottom multiplier:1.0f constant:(0.0f)]];
    [self.tableview setTableHeaderView:header];
    
    
    
    [self.tableview sizeToFit];
    [self.tableview setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(00.0f)]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"viewWillAppear");
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    NSLog(@"viewDidAppear");
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    NSLog(@"viewWillDisappear");
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    NSLog(@"viewDidDisappear");
}
-(void)startnetwork
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@index.php/Api/Show/talk",addressport] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *lodic=(NSDictionary *)responseObject;
        if ([[lodic objectForKey:@"status"] integerValue]==1) {
            for (NSDictionary *lodic1 in [lodic objectForKey:@"data"]) {
                Topic *topic=[[Topic alloc] init];
                topic.name=[lodic1 valueForKey:@"name"];
                topic.topicid=[[lodic1 valueForKey:@"id"] integerValue];
                topic.num=[[lodic1 valueForKey:@"num"] integerValue];
                [self.topicArray addObject:topic];
            }
            [self.tableview reloadData];
        }
        else
        {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
-(void)startnetworkofall
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@index.php/Api/Show/anchornum",addressport] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *lodic=(NSDictionary *)responseObject;
        if ([[lodic objectForKey:@"status"] integerValue]==1) {
            LeftTableViewCell *tmpheader=(LeftTableViewCell *)self.tableview.tableHeaderView;
            tmpheader.labelnum.text=[NSString stringWithFormat:@"(%d)人",[[[lodic valueForKey:@"data"] valueForKey:@"num"] integerValue]];
        }
        else
        {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)headclicked:(id)sender
{
    NSMutableArray *loarray=[[NSMutableArray alloc] init];
    [loarray addObject:[NSNumber numberWithInt:1]];
    [loarray addObject:[NSNumber numberWithInt:-1]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLefttableselect object:loarray];
    [[MenuViewController shareMenu] setShowtype:1];
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
    if (section==0) {
        return self.topicArray.count;
    }
    else
    {
        return self.topicArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftTableViewCell";
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        
        [cell.labelnum sizeToFit];
        [cell.labelnum setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:cell.labelnum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.label attribute:NSLayoutAttributeRight multiplier:1.0f constant:(10.0f)]];
    }
    Topic *topic=[self.topicArray objectAtIndex:[indexPath row]];
    cell.label.text=topic.name;
    cell.labelnum.text=[NSString stringWithFormat:@"(%d)人",topic.num];
    CGRect rect=cell.label.frame;
    CGSize fitLabelSize = CGSizeMake(MAXFLOAT,rect.size.height);
    CGSize labelSize = [cell.label.text sizeWithFont:cell.label.font constrainedToSize:fitLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    cell.label.frame=CGRectMake(rect.origin.x, rect.origin.y, labelSize.width, rect.size.height);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH, 20)];
    label.backgroundColor=[UIColor blackColor];
    label.textColor=[UIColor whiteColor];
    if (section==0) {
        label.text=@"    话题    Tpic";
    }
    else
    {
        label.text=@"    话题    Tpic";
    }
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        Topic *topic=[self.topicArray objectAtIndex:indexPath.row];
        NSMutableArray *loarray=[[NSMutableArray alloc] init];
        [loarray addObject:[NSNumber numberWithInt:1]];
        [loarray addObject:[NSNumber numberWithInt:topic.topicid]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLefttableselect object:loarray];
//        Program *program=[self.programArray objectAtIndex:indexPath.row];
//        NSMutableArray *loarray=[[NSMutableArray alloc] init];
//        [loarray addObject:[NSNumber numberWithInt:0]];
//        [loarray addObject:[NSNumber numberWithInt:program.programid]];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLefttableselect object:loarray];
    }
    else
    {
        Topic *topic=[self.topicArray objectAtIndex:indexPath.row];
        NSMutableArray *loarray=[[NSMutableArray alloc] init];
        [loarray addObject:[NSNumber numberWithInt:1]];
        [loarray addObject:[NSNumber numberWithInt:topic.topicid]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLefttableselect object:loarray];
    }
    [[MenuViewController shareMenu] setShowtype:1];
}
@end

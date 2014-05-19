//
//  NumlistViewController.m
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "NumlistViewController.h"
#import "NumlistcellTableViewCell.h"
#import "WritenumViewController.h"
#import "LiveStudioViewController.h"
#import "VCchain.h"



@interface NumlistViewController ()

@end

@implementation NumlistViewController

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
    // Do any additional setup after loading the view from its nib.
    dataarray=[[NSMutableArray alloc] init];
    [dataarray addObject:@"1"];
    [dataarray addObject:@"2"];
    [dataarray addObject:@"3"];
    [dataarray addObject:@"4"];
    [dataarray addObject:@"5"];
    [dataarray addObject:@"手动输入"];
    [dataarray addObject:@"取消"];
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
    return dataarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AudienceTableViewCell";
    NumlistcellTableViewCell *cell = (NumlistcellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NumlistcellTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.label.text=[dataarray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==5) {
        WritenumViewController *writenumVC=[[WritenumViewController alloc] initWithNibName:@"WritenumViewController" bundle:nil];
        writenumVC.delegate=self.delegatechain;
        CGRect rect=writenumVC.view.frame;
        
        UIViewController *tmpVC=[VCchain sharedchain].livestudio;
        rect.size.width=tmpVC.view.frame.size.width;
        writenumVC.view.frame=rect;
        [tmpVC addChildViewController:writenumVC];
        [tmpVC.view addSubview:writenumVC.view];
        [writenumVC didMoveToParentViewController:self];
    }
    else if (indexPath.row==6)
    {
    
    }
    else
    {
        [_delegate numdidselect:indexPath.row+1];
    }
    _delegate=nil;
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

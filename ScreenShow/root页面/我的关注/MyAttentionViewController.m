//
//  MyAttentionViewController.m
//  ScreenShow
//
//  Created by lee on 14-4-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "MyAttentionTableViewCell.h"

@interface MyAttentionViewController ()

@end

@implementation MyAttentionViewController

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
    [self.table sizeToFit];
    [self.table setTranslatesAutoresizingMaskIntoConstraints:NO];//采用autolayout布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:(00.0f)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.table attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:(00.0f)]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark uitableview delegate
-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end

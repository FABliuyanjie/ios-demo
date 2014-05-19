//
//  BigPresentViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BigPresentViewController.h"
#import "BigPresentTableViewCell.h"
#import "BigPresentView.h"
#import "ScreenShow-Prefix.pch"
#import "Present.h"
#import "UIImageView+WebCache.h"
#import "BigPresent.h"
#import "User.h"
#import "Altertable.h"
#import "NumlistViewController.h"
#import "Delegatechain.h"


@interface BigPresentViewController ()

@end

@implementation BigPresentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.presentArray=[[NSMutableArray alloc] init];
        totalcolland=7;
        totalcolportait=4;
    }
    return self;
}
- (void)loadView
{
    BigPresentView *bigView;
    if (self.isportrait) {
         bigView=[[BigPresentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_WIDTH, SCREEN_FRAME_HEIGHT-220-30-STATUSBAR_HEIGHT_IOS7)];
    }
    else
    {
        bigView=[[BigPresentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FRAME_HEIGHT, SCREEN_FRAME_WIDTH-STATUSBAR_HEIGHT_IOS7)];
    }
    self.view=bigView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BigPresentView *bigView=(BigPresentView*)self.view;
    bigView.tableView.delegate=self;
    bigView.tableView.dataSource=self;
    
    
    bigView.labelleftmoney.text=[NSString stringWithFormat:@"%.0f币",[[User shareUser] accountMoney]];
    [bigView.btnsend addTarget:self  action:@selector(btnsendClicked:) forControlEvents:UIControlEventTouchDown];
    [bigView.btnnum addTarget:self action:@selector(btnnumClicked:) forControlEvents:UIControlEventTouchDown];
    [self startnetworkofpresentlist:[NSString stringWithFormat:@"index.php/Api/Show/giftsList"]];
}
-(void)startnetworkofpresentlist:(NSString *)prstr
{
    BigPresentView *bigView=(BigPresentView*)self.view;
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"index.php/Api/Show/giftsList"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.presentArray removeAllObjects];
        @try {
            NSDictionary *lodic=(NSDictionary *)responseObject;
            if ([[lodic objectForKey:@"status"] integerValue]==1) {
                if (![[lodic objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                    for (NSDictionary *lodic1 in [lodic objectForKey:@"data"]) {
                        Present *present=[[Present alloc] init];
                        present.isselected=NO;
                        present.presentid=[[lodic1 valueForKey:@"gift_id"] integerValue];
                        present.name=[lodic1 valueForKey:@"gift_name"];
                        present.price=[[lodic1 valueForKey:@"gift_price"] floatValue];
                        present.picurl=[lodic1 valueForKey:@"gift_img"];
                        [self.presentArray addObject:present];
                    }
                }
                [bigView.tableView reloadData];
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
        NSLog(@"%@",error);
    }];

}
-(void)startnetworkofsend:(NSString *)prstr
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnnumClicked:(UIButton *)sender
{
    delegatechain=[[Delegatechain alloc] init];
    delegatechain.delegate=self;
    
    
    NumlistViewController *numlistVC=[[NumlistViewController alloc] initWithNibName:@"NumlistViewController" bundle:nil];
    numlistVC.delegate=self;
    numlistVC.delegatechain=delegatechain;
    numlistVC.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:numlistVC];
    [self.view addSubview:numlistVC.view];
    [numlistVC didMoveToParentViewController:self];
}
-(void)btnsendClicked:(id)sender
{
    BigPresentView *bigview=(BigPresentView *)self.view;
    if (!self.presenttosend) {
        UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"请选择礼物" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    int tmpnum=[bigview.btnnum.titleLabel.text intValue];
    [self startnetworkofsend:[NSString stringWithFormat:@"index.php/Api/Show/giftsGive?id=%d&to_id=%d&gift_id=%d&num=%d",[[User shareUser] manID],self.anchor.anchorid,self.presenttosend.presentid,tmpnum]];
}
-(void)configurecell:(BigPresentTableViewCell *)cell indexPath:(NSIndexPath *)indexPath totalcol:(int)totalcol
{
    for (int i=0;i<cell.contentView.subviews.count; i++) {
        if (self.presentArray.count>(indexPath.row)*totalcol+i) {
            Present *present=[self.presentArray objectAtIndex:(indexPath.row)*totalcol+i];
            BigPresent *loview=(BigPresent *)[cell.contentView.subviews objectAtIndex:i];
            if (present.isselected) {
                loview.layer.borderWidth=1;
                loview.layer.borderColor=[UIColor blackColor].CGColor;
                loview.layer.masksToBounds=YES;
            }
            else
            {
                loview.layer.borderWidth=0;
    
            }
            [loview.imgview setImageWithURL:[NSURL URLWithString:present.picurl]];
            loview.labelname.text=present.name;
            loview.labelprice.text=[NSString stringWithFormat:@"%.0f币",present.price];
            loview.tag=(indexPath.row)*totalcol+i;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigPresentTapped:)];
            [loview addGestureRecognizer:tapGesture];
        }
    }
}
-(void)bigPresentTapped:(UITapGestureRecognizer *)sender
{
    NSLog(@"%d",sender.view.tag);
    BigPresentView *bigView=(BigPresentView*)self.view;
    Present *selectedobj=[self.presentArray objectAtIndex:sender.view.tag];
    for (Present *obj in self.presentArray) {
        if (selectedobj==obj) {
            obj.isselected=YES;
            CGRect rect=bigView.labelnote.frame;
            bigView.labelnote.text=[NSString stringWithFormat:@"%@",obj.name];
            CGSize size = CGSizeMake(1000,bigView.labelnote.frame.size.height);
            CGSize labelsize = [bigView.labelnote.text sizeWithFont:bigView.labelnote.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
            bigView.labelnote.frame=CGRectMake(rect.origin.x, rect.origin.y, labelsize.width, rect.size.height);
            CGRect rect1=bigView.labelnotenote1.frame;
            bigView.labelnotenote1.frame=CGRectMake(bigView.labelnote.frame.origin.x+bigView.labelnote.frame.size.width, rect1.origin.y, rect1.size.width, rect1.size.height);
            CGRect rect2=bigView.labelnote1.frame;
            bigView.labelnote1.text=self.anchor.nickName;
            bigView.labelnote1.frame=CGRectMake(bigView.labelnotenote1.frame.origin.x+bigView.labelnotenote1.frame.size.width, rect2.origin.y, rect2.size.width, rect2.size.height);
            self.presenttosend=obj;
        }
        else
        {
            obj.isselected=NO;
        }
    }
    [bigView.tableView reloadData];
}
-(void)celldynamicsubview:contentview colom:(int)colom lowidth:(float)lowidth
{
    for (int i=0; i<colom; i++) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BigPresent" owner:self options:nil];
        UIView *loview=[array objectAtIndex:0];
        loview.tag=100+i;
        loview.frame=CGRectMake(i*lowidth, 0, lowidth, loview.frame.size.height);
        [contentview addSubview:loview];
    }
}
-(void)determinwhichtohidden:(UIView *)contentview colom:(int)colom  row:(int)row
{
    for (int i=0; i<contentview.subviews.count; i++) {
        UIView *loview=[contentview.subviews objectAtIndex:i];
        if (self.presentArray.count/colom==row && i>=self.presentArray.count%colom) {
            loview.hidden=YES;
        }
        else
        {
            loview.hidden=NO;
        }
    }
}
#pragma mark-
#pragma mark- numlist delegate
-(void)numdidselect:(int)sender
{
    BigPresentView *bigView=(BigPresentView *)self.view;
    [bigView.btnnum setTitle:[NSString stringWithFormat:@"%d",sender] forState:UIControlStateNormal];
}
-(void)Delegatechain:(int)sender
{
    BigPresentView *bigView=(BigPresentView *)self.view;
    [bigView.btnnum setTitle:[NSString stringWithFormat:@"%d",sender] forState:UIControlStateNormal];
    [self btnsendClicked:nil];
}
#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSections
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int totocalcol;
    if (self.isportrait) {
        totocalcol=totalcolportait;
    }
    else
    {
         totocalcol=totalcolland;
    }
    if (self.presentArray.count%totocalcol==0) {
        return self.presentArray.count/totocalcol;
    }
    else
    {
        return self.presentArray.count/totocalcol+1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BigPresentTableViewCell";
    BigPresentTableViewCell *cell = (BigPresentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[BigPresentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        BigPresentView *bigView=(BigPresentView*)self.view;
        float lowidthland=bigView.tableView.frame.size.width/totalcolland;
        float lowidthportait=bigView.tableView.frame.size.width/totalcolportait;
        //竖屏
        if (self.isportrait) {
            [self celldynamicsubview:cell.contentView colom:totalcolportait lowidth:lowidthportait];
        }
        //横屏
        else
        {
            [self celldynamicsubview:cell.contentView colom:totalcolland lowidth:lowidthland];
        }
    }
    if (self.isportrait) {
        [self determinwhichtohidden:cell.contentView colom:totalcolportait row:indexPath.row];
        [self configurecell:cell indexPath:indexPath totalcol:totalcolportait];
    }
    else
    {
        [self determinwhichtohidden:cell.contentView colom:totalcolland row:indexPath.row];
        [self configurecell:cell indexPath:indexPath totalcol:totalcolland];
    }
    return cell;
}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}
@end

//
//  SystemSettingsTableViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "SystemSettingsTableViewController.h"

@interface SystemSettingsTableViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableDictionary * _statusDictionary;
    NSArray * _macroDefinition;
}
@end

@implementation SystemSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"关注主播上线提醒", @"运行时自动登录", @"私聊消息提醒", @"收到消息时声音通知", @"收到消息时震动通知", @"摇一摇手机切换主播", @"自动删除30天前的缓存", nil];
    _macroDefinition = [[NSArray alloc] initWithObjects:MAINBROADCASTONLine, AUTOLOGIN, PRIVATEMESSAGE, RECEIVEMESSAGESOUND, RECEIVEMESSAGESHAKE, SHAKEANDCHANGE, AUTODELETECACHE,  nil];
    [self initData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)initData
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    _statusDictionary = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:kConfigFileName]];
    if (_statusDictionary.count == 0) {
        [_statusDictionary setObject:@"no" forKey:MAINBROADCASTONLine];
        [_statusDictionary setObject:@"no" forKey:AUTOLOGIN];
        [_statusDictionary setObject:@"no" forKey:PRIVATEMESSAGE];
        [_statusDictionary setObject:@"no" forKey:RECEIVEMESSAGESOUND];
        [_statusDictionary setObject:@"no" forKey:RECEIVEMESSAGESHAKE];
        [_statusDictionary setObject:@"no" forKey:SHAKEANDCHANGE];
        [_statusDictionary setObject:@"no" forKey:AUTODELETECACHE];
        [userDefaults setObject:_statusDictionary forKey:kConfigFileName];
    }
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row < [_dataArray count])
        {
            UIButton * selecteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selecteBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 9, 19, 20);
//            [selecteBtn sizeToFit];
            NSString * statues = [_statusDictionary objectForKey:[_macroDefinition objectAtIndex:indexPath.row]];
            UIImage * imageSelected = [UIImage imageNamed:@"SystemSettings_vc_btn_check_selected.png"];
            UIImage * imageSelect = [UIImage imageNamed:@"SystemSettings_vc_btn_check_select.png"];
            
            if ([statues isEqualToString:@"yes"]) {
                [selecteBtn setBackgroundImage: [imageSelected stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                 
                                      forState:UIControlStateNormal];
            }
            else if ([statues isEqualToString:@"no"]){
                [selecteBtn setBackgroundImage:
                 [imageSelect stretchableImageWithLeftCapWidth:10
                                                  topCapHeight:10]
                 
                                      forState:UIControlStateNormal];
            }
            selecteBtn.tag = indexPath.row + 1;
            
            [selecteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:selecteBtn];
            cell.accessoryView = nil;
        }
    }
    
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = [NSString stringWithFormat:@"  %@",[_dataArray objectAtIndex:indexPath.row]];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1];
    }
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];


    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton * cacheBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cacheBtn.frame = CGRectMake(10, 30, SCREEN_WIDTH - 20, 40);
    [cacheBtn setTitle:@"立刻删除缓存" forState:UIControlStateNormal];
    cacheBtn.titleLabel.textColor = [UIColor whiteColor];
    cacheBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [cacheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [cacheBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cacheBtn addTarget:self action:@selector(clearCache) forControlEvents:UIControlEventTouchUpInside];
    [cacheBtn setBackgroundColor:[UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1]];
    [view addSubview:cacheBtn];
    view.userInteractionEnabled = YES;
    
    return view;
}

-(void)clearCache
{
    NSLog(@"立即删除缓存");
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_dataArray count]) {
        
        [self updateCheckBox:indexPath.row];
        [self saveChange:indexPath.row];
        [self.tableView reloadData];
        
    }else{
        //TODO:clear cache
    }
}


//更改记住密码按钮背景图片
-(void)updateCheckBox:(NSInteger)integer
{
    UIButton * selecteBtn = (UIButton *)[self.view viewWithTag:integer + 1];
    NSString * statues = [_statusDictionary objectForKey:[_macroDefinition objectAtIndex:integer]];
    if ([statues isEqualToString:@"yes"]) {
        [selecteBtn setBackgroundImage:[UIImage imageNamed:@"SystemSettings_vc_btn_check_select.png"] forState:UIControlStateNormal];
    }
    else if ([statues isEqualToString:@"no"]){
        [selecteBtn setBackgroundImage:[UIImage imageNamed:@"SystemSettings_vc_btn_check_selected.png"] forState:UIControlStateNormal];
    }
}


-(IBAction)btnClick:(UIButton *)btn
{
    [self updateCheckBox:btn.tag - 1];
    [self saveChange:btn.tag - 1];
}

-(void)saveChange:(NSInteger)tag
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * statues = [_statusDictionary objectForKey:[_macroDefinition objectAtIndex:tag]];
    if ([statues isEqualToString:@"yes"]) {
        [_statusDictionary setObject:@"no" forKey:[_macroDefinition objectAtIndex:tag]];
    }
    else if ([statues isEqualToString:@"no"]){
        [_statusDictionary setObject:@"yes" forKey:[_macroDefinition objectAtIndex:tag]];
    }
    [userDefaults setObject:_statusDictionary forKey:kConfigFileName];
    
    
    [userDefaults synchronize];

}
@end

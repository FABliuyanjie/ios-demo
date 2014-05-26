//
//  AccountBindViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-5-22.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AccountBindViewController.h"
#import "AuthType.h"

#define TARGET_CELL_ID @"targetCell"

@interface AccountBindViewController ()

@end

@implementation AccountBindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
  
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)awakeFromNib
{
    AuthType * qqType = [[AuthType alloc] init];
    qqType.name = @"QQ";
    qqType.pinyin = @"qzone";
    qqType.type = NO;
    qqType.tag = 1;
    
    AuthType * weixinType = [[AuthType alloc] init];
    weixinType.name = @"微信";
    weixinType.pinyin = @"weixin";
    weixinType.type = NO;
    weixinType.tag = 2;
    
    AuthType * weiboType = [[AuthType alloc] init];
    weiboType.name = @"微博";
    weiboType.pinyin = @"sina";
    weiboType.type = NO;
    weiboType.tag = 3;
    
    AuthType * renrenType = [[AuthType alloc] init];
    renrenType.name = @"人人";
    renrenType.pinyin = @"renren";
    renrenType.type = NO;
    renrenType.tag = 4;
    
    _shareTypeArray = [[NSMutableArray alloc] initWithObjects:qqType, weixinType, weiboType, renrenType, nil];
    [self startnetwork];
}

-(void)startnetwork
{
    NSString * url = [NSString stringWithFormat:@"index.php/Api/User/bindinfo?token=%@", [[User shareUser] token]];
    
    NSLog(@"requestAddress = %@",url);
    
    [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            NSArray * array = [responseObject objectForKey:@"data"];
            if (![array isKindOfClass:[NSNull class]]) {
                if (array.count !=0) {
                    
                    for (NSDictionary * dict in array) {
                        for (AuthType * authType in _shareTypeArray) {
                            if ([authType.pinyin isEqualToString:[dict objectForKey:@"type"]]){
                                authType.type = YES;
                            }
                        }
                    }
                }
                else
                {
                    
                }
            }
        }
        [self.tableView reloadData];

        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
    self.tableView.scrollEnabled = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shareTypeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TARGET_CELL_ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TARGET_CELL_ID] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row < [_shareTypeArray count])
    {
        AuthType * authType = [_shareTypeArray objectAtIndex:indexPath.row];
        NSString * str;
        if (authType.type == YES) {
            str = [NSString stringWithFormat:@"%@(已绑定)",authType.name];
        }
        else if(authType.type == NO){
            str = [NSString stringWithFormat:@"%@(未绑定)",authType.name];
        }
        cell.textLabel.text = str;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AuthType * authType = [_shareTypeArray objectAtIndex:indexPath.row];
    if (authType.type == YES) {
        NSString * str = [NSString stringWithFormat:@"确定要解除%@的绑定？", authType.name];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = authType.tag;
        [alertView show];
        return;

    }
    else
    {
        NSLog(@"绑定%@", authType.name);
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        AuthType * authType = [_shareTypeArray objectAtIndex:alertView.tag - 1];
        NSLog(@"解除绑定%@", authType.name);
    }
}


@end

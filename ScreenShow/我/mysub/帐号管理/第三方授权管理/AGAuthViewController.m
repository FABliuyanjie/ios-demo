//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import "AGAuthViewController.h"
#import <AGCommon/UIImage+Common.h>
#import "AGShareCell.h"

#import <AGCommon/UIColor+Common.h>

#import <AGCommon/UIDevice+Common.h>
#import "AppDelegate.h"
#import <AGCommon/NSString+Common.h>

#define TARGET_CELL_ID @"targetCell"
#define BASE_TAG 100
#import "AlixLibService.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface AGAuthViewController()
{
    TencentOAuth *_tencentOAuth;
}
/**
 *	@brief	用户信息更新
 *
 *	@param 	notif 	通知
 */
- (void)userInfoUpdateHandler:(NSNotification *)notif;


@end

@implementation AGAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self startnetwork];
    }
    return self;
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
                    requestTypeArray = [[NSMutableArray alloc] init];

                    for (NSDictionary * dict in array) {
                        
                        [requestTypeArray addObject:[dict objectForKey:@"type"]];

                        if ([[dict objectForKey:@"type"] isEqualToString:@"qq"]) {
                            
                           NSString * str = [_shareTypeArray objectAtIndex:0];
                            str = @"QQ（已绑定）";
                            [_shareTypeArray replaceObjectAtIndex:0 withObject:str];
                        }
                        else if ( [[dict objectForKey:@"type"] isEqualToString:@"微信"])
                        {
                            NSString * str = [_shareTypeArray objectAtIndex:1];
                            str = @"微信（已绑定）";
                            [_shareTypeArray replaceObjectAtIndex:1 withObject:str];
                        }
                        else if ( [[dict objectForKey:@"type"] isEqualToString:@"微博"])
                        {
                            NSString * str = [_shareTypeArray objectAtIndex:2];
                            str = @"微博（已绑定）";
                            [_shareTypeArray replaceObjectAtIndex:2 withObject:str];
                        }
                        else if ( [[dict objectForKey:@"type"] isEqualToString:@"renren"])
                        {
                            NSString * str = [_shareTypeArray objectAtIndex:3];
                            str = @"人人（已绑定）";
                            [_shareTypeArray replaceObjectAtIndex:3 withObject:str];
                        }
                        [_tableView reloadData];
                    }
                }
                else
                {
                    
                }
            }
        }
        
        NSLog(@"%@",responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}



- (void)loadView
{
    [super loadView];
    
    [self startnetwork];
    if ([[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
    {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:SSRectEdgeBottom | SSRectEdgeLeft | SSRectEdgeRight];
    }

    _shareTypeArray = [[NSMutableArray alloc] initWithObjects:@"QQ（未绑定）", @"微信（未绑定）", @"微博（未绑定）", @"人人（未绑定）", nil];
    
    typeArray = [[NSArray alloc] initWithObjects:@"qq", @"weixin", @"weibo", @"renren", nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(2.0, 0.0, self.view.width-4, self.view.height)
                                               style:UITableViewStylePlain];
    _tableView.rowHeight = 50.0;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.layer.cornerRadius = 1;
    _tableView.layer.borderWidth = 2;
    _tableView.layer.borderColor = [UIColor colorWithWhite:0.864 alpha:1.000].CGColor;
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDataSource

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
        NSString * typeName = [_shareTypeArray objectAtIndex:indexPath.row];
        cell.textLabel.text = typeName;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
        NSLog(@"agautest");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSString * type in requestTypeArray) {
        if ([type isEqualToString:[typeArray objectAtIndex:indexPath.row]]) {
            
            NSString * str = [NSString stringWithFormat:@"确定要解除%@的绑定？", [_shareTypeArray objectAtIndex:indexPath.row]];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            return;
        }
    }
    
    NSLog(@"绑定");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSLog(@"解除绑定");
    }
}

#pragma mark - Private

- (void)userInfoUpdateHandler:(NSNotification *)notif
{
    NSInteger plat = [[[notif userInfo] objectForKey:SSK_PLAT] integerValue];
    id<ISSPlatformUser> userInfo = [[notif userInfo] objectForKey:SSK_USER_INFO];
    
    for (int i = 0; i < [_shareTypeArray count]; i++)
    {
        NSMutableDictionary *item = [_shareTypeArray objectAtIndex:i];
        ShareType type = (ShareType)[[item objectForKey:@"type"] integerValue];
        if (type == plat)
        {
            [item setObject:[userInfo nickname] forKey:@"username"];
            [_tableView reloadData];
        }
    }
}




@end

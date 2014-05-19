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
        //监听用户信息变更
        [ShareSDK addNotificationWithName:SSN_USER_INFO_UPDATE
                                   target:self
                                   action:@selector(userInfoUpdateHandler:)];
        
        _shareTypeArray = [[NSMutableArray alloc] init];

        NSArray *shareTypes = [ShareSDK connectedPlatformTypes];
        for (int i = 0; i < [shareTypes count]; i++)
        {
            NSNumber *typeNum = [shareTypes objectAtIndex:i];
            ShareType type = (ShareType)[typeNum integerValue];
            id<ISSPlatformApp> app = [ShareSDK getClientWithType:type];
            
            if ([app isSupportOneKeyShare] || type == ShareTypeInstagram || type == ShareTypeGooglePlus || type == ShareTypeQQSpace)
            {
                [_shareTypeArray addObject:[NSMutableDictionary dictionaryWithObject:[shareTypes objectAtIndex:i]
                                                                              forKey:@"type"]];
            }
        }
        
        NSArray *authList = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
        if (authList == nil)
        {
            [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
        }
        else
        {
            for (int i = 0; i < [authList count]; i++)
            {
                NSDictionary *item = [authList objectAtIndex:i];
                for (int j = 0; j < [_shareTypeArray count]; j++)
                {
                    if ([[[_shareTypeArray objectAtIndex:j] objectForKey:@"type"] integerValue] == [[item objectForKey:@"type"] integerValue])
                    {
                        [_shareTypeArray replaceObjectAtIndex:j withObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                        break;
                    }
                }
            }
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)dealloc
{
    [ShareSDK removeNotificationWithName:SSN_USER_INFO_UPDATE target:self];

}

-(void)initData
{
    //监听用户信息变更
    [ShareSDK addNotificationWithName:SSN_USER_INFO_UPDATE
                               target:self
                               action:@selector(userInfoUpdateHandler:)];
    
    _shareTypeArray = [[NSMutableArray alloc] init];
    
    NSArray *shareTypes = [ShareSDK connectedPlatformTypes];
    for (int i = 0; i < [shareTypes count]; i++)
    {
        NSNumber *typeNum = [shareTypes objectAtIndex:i];
        ShareType type = (ShareType)[typeNum integerValue];
        id<ISSPlatformApp> app = [ShareSDK getClientWithType:type];
        
        if ([app isSupportOneKeyShare] || type == ShareTypeInstagram || type == ShareTypeGooglePlus || type == ShareTypeQQSpace)
        {
            [_shareTypeArray addObject:[NSMutableDictionary dictionaryWithObject:[shareTypes objectAtIndex:i]
                                                                          forKey:@"type"]];
        }
    }
    
    NSArray *authList = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
    if (authList == nil)
    {
        [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
    }
    else
    {
        for (int i = 0; i < [authList count]; i++)
        {
            NSDictionary *item = [authList objectAtIndex:i];
            for (int j = 0; j < [_shareTypeArray count]; j++)
            {
                if ([[[_shareTypeArray objectAtIndex:j] objectForKey:@"type"] integerValue] == [[item objectForKey:@"type"] integerValue])
                {
                    [_shareTypeArray replaceObjectAtIndex:j withObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                    break;
                }
            }
        }
    }

}

- (void)loadView
{
    [super loadView];
    
    [self initData];
    if ([[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
    {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:SSRectEdgeBottom | SSRectEdgeLeft | SSRectEdgeRight];
    }

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

- (void)authSwitchChangeHandler:(UISwitch *)sender
{
    NSInteger index = sender.tag - BASE_TAG;
    
    if (index < [_shareTypeArray count])
    {
        NSMutableDictionary *item = [_shareTypeArray objectAtIndex:index];
        if (sender.on)
        {
            //MAKR:绑定分享平台
            //用户用户信息
            ShareType type = (ShareType)[[item objectForKey:@"type"] integerValue];
            
            id<ISSAuthOptions> authOptions = nil;
            id<ISSPlatformApp> app = [ShareSDK getClientWithType:type];
            if ([app isSupportOneKeyShare] || type == ShareTypeInstagram || type == ShareTypeGooglePlus || type == ShareTypeQQSpace)
            {
                authOptions   = [ShareSDK authOptionsWithAutoAuth:YES
                                                    allowCallback:YES
                                                    authViewStyle:SSAuthViewStylePopup
                                                     viewDelegate:nil
                                          authManagerViewDelegate:nil];
                
                //在授权页面中添加关注官方微博
                [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                                SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                                [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                                SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                                nil]];
                
            }
            
            [ShareSDK getUserInfoWithType:type
                              authOptions:authOptions
                                   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                       if (result)
                                       {
                                           [item setObject:[userInfo nickname] forKey:@"username"];
                                           [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
                                       }
                                       NSLog(@"%ld:%@",(long)[error errorCode], [error errorDescription]);
                                       
                                       
                                       [_tableView reloadData];
                                   }];
            
            
            
            
            
            
        }
        else
        {
            //取消授权
            [ShareSDK cancelAuthWithType:(ShareType)[[item objectForKey:@"type"] integerValue]];
            [_tableView reloadData];
        }
        
    }
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
        cell = [[AGShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TARGET_CELL_ID] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISwitch *switchCtrl = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchCtrl sizeToFit];
        [switchCtrl addTarget:self action:@selector(authSwitchChangeHandler:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchCtrl;
    }
    if (indexPath.row < [_shareTypeArray count])
    {
        NSDictionary *item = [_shareTypeArray objectAtIndex:indexPath.row];
        
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:
                                            @"Icon/sns_icon_%ld.png",
                                            (long)[[item objectForKey:@"type"] integerValue]]
                                bundleName:BUNDLE_NAME];
        cell.imageView.image = img;
        
        ((UISwitch *)cell.accessoryView).on = [ShareSDK hasAuthorizedWithType:(ShareType)[[item objectForKey:@"type"] integerValue]];
        ((UISwitch *)cell.accessoryView).tag = BASE_TAG + indexPath.row;
        
        if (((UISwitch *)cell.accessoryView).on)
        {
            cell.textLabel.text = [item objectForKey:@"username"];
        }
        else
        {
            cell.textLabel.text = @"尚未授权";
        }
    }
    
    return cell;
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

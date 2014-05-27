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
        [self loginWithName:authType];
        
    }
}

-(void)loginWithName:(AuthType *)authType
{
    
    NSString *platformName = nil;
    pfname = authType.name;
    switch (authType.tag) {
        case 1:
            platformName = UMShareToQzone;
            pfname = @"qzone";
            break;
        case 2:
            platformName = UMShareToWechatTimeline;
            pfname = @"wechat";
            break;
        case 3:
            platformName = UMShareToSina;
            pfname = @"sina";
            break;
        case 4:
            platformName = UMShareToRenren;
            pfname = @"renren";
            break;
        default:
            platformName = UMShareToQQ;
    }
    __weak AccountBindViewController * weakSelf = self;

    //唤起授权页
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],NO,^(UMSocialResponseEntity *response){
        
        if (response.responseCode!=UMSResponseCodeSuccess ) {
            return ;
        }

        //取得给定平台的username和usid
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *respose){
            NSDictionary *dict = respose.data[@"accounts"][pfname];
            if (dict==nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //TODO: 在主线程跳转,绑定操作
                    [weakSelf handleLoginFailure];
                });
            }
            NSString *username = dict[@"username"];
            NSString *usid = dict[@"usid"];
            
            //判断是否绑定过
            //发起第三方平台的登录
            [User loginWithUMbyOpenid:usid openName:username thirdType:pfname completionHandler:^(bool status, NSString *info) {
                
                NSLog(@"pfname = %@",pfname);
                
                if (status) {
                    AuthType * auth = [_shareTypeArray objectAtIndex:authType.tag - 1];
                    
                    NSLog(@"绑定账户名字：%@", auth.name);
                    auth.type = YES;
                    [self.tableView reloadData];
                }else{
                     [self bindWithOpenid:usid openName:username thirdType:pfname tag:authType.tag];
                }

               

                
//                if (status) {//以前登录过，直接登录成功
//                    //                    dispatch_async(dispatch_get_main_queue(), ^{
//                    //TODO: 在主线程跳转,绑定操作
//                    [weakSelf handleLoginSuccess];
//                    //                    });
//                    
//                }else{//第一次登录，绑定账号或者新注册一个
//                    //                    dispatch_async(dispatch_get_main_queue(), ^{
//                    //TODO: 在主线程跳转,绑定操作
//                    [weakSelf handleBindAccount];
//                    
//                    //                    });
//                }
                
            }];
            
        }];
    });

}

-(void)bindWithOpenid:(NSString *)openid openName:(NSString *)openName thirdType:(NSString *)thirdType tag:(int)tag
{
    
    [User bindThirdAccountByOpenid:openid openName:openName thirdType:thirdType completionHandler:^(bool status, NSString *info) {
        
        NSLog(@"info = %@", info);
        if (status==1 || [info isEqualToString:@"绑定失败"] ) {//绑定失败是已经绑定了
            AuthType * auth = [_shareTypeArray objectAtIndex:tag - 1];
            
            NSLog(@"绑定账户名字：%@", auth.name);
            auth.type = YES;
            [self.tableView reloadData];
        }
        else
        {
            [[iToast makeText:info] show];
        }
        
    }];

}

/**
 *  登录失败
 */
-(void)handleLoginFailure
{
    [TOOL logOut];
    [[iToast makeText:@"登录失败"]show];
}

/**
 *  第一次第三方登录必须绑定一个账号
 */
-(void)handleBindAccount
{
//
//    SelectLoginViewController * selectLoginVC = [[UIStoryboard storyboardWithName:@"ThirdLoginStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"SelectLoginViewController"];//[SelectLoginViewController alloc] init];
//    selectLoginVC.userName = username;
//    selectLoginVC.openID = usid;
//    selectLoginVC.typeName = pfname;
//    selectLoginVC.headPhotoUrl = photoUrl;
//    [self.navigationController pushViewController:selectLoginVC animated:YES];
    
}

/**
 *  登录成功后的操作
 *
 *  @return nil
 */
-(void)handleLoginSuccess
{
//    [TOOL logIn];
//    //    [User saveUserInfo];
//    [[iToast makeText:@"登录成功"] show];
//    if(self.isFromMyViewController==YES){
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    [APService setAlias:[NSString stringWithFormat:@"%ld",(long)[User shareUser].manID]callbackSelector:nil object:nil];
//    SendNoti(kLogInSuccess);

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        AuthType * authType = [_shareTypeArray objectAtIndex:alertView.tag - 1];
        NSLog(@"解除绑定%@", authType.name);
        
        [User unbindThirdAccountWithThirdType:authType.pinyin completionHandler:^(bool status, NSString *info) {
           
            NSLog(@"info = %@", info);
            if (status || [info isEqualToString:@"解除绑定失败"]) {
              AuthType * auth = [_shareTypeArray objectAtIndex:authType.tag - 1];
                auth.type = NO;
                [self.tableView reloadData];
            }
            else
            {
                [[iToast makeText:info] show];
            }
            
        }];
    }
}


@end

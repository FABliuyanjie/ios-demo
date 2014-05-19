//
//  SubLogInViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-1.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubLogInViewController : UITableViewController
@property (nonatomic,copy,readonly) NSString *phoneNum;//电话号码
@property (nonatomic,copy,readonly) NSString *pwd;//密码

@property (nonatomic,assign,readonly) BOOL checkOK;
@property (nonatomic,copy,readonly) NSString *externInfo;

-(BOOL)checkValue;
@end

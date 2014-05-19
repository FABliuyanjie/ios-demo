//
//  BaseTableViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

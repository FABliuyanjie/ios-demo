//
//  RechangViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "CostListViewController.h"
#import "ComboBoxView.h"
#import "PullTableView.h"

//typedef enum : NSUInteger {
//    ThisDay,
//    ThisWeek,
//    ThisMonth,
//    ALL,
//} kFiterType;

@interface RechangViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ComboxDelegate,PullTableViewDelegate>
{
    NSMutableArray *_totalArray;
    NSMutableArray *_fiteredArray;
    
    NSString *_money;
    NSString *_fmoney;
    kFiterType _type;
}
@property (nonatomic,copy) NSString *urlStr;


@property (strong, nonatomic) IBOutlet PullTableView *tableView;
@property (strong, nonatomic) IBOutlet ComboBoxView *timeSelectView;
@property (weak, nonatomic) IBOutlet UILabel *info;

@property (nonatomic,assign) NSInteger segIndex;
@property (nonatomic,assign) NSInteger comIndex;

@end

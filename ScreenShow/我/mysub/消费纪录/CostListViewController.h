//
//  CostListViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBoxView.h"
#import "PullTableView.h"

typedef enum : NSUInteger {
    ThisDay,
    ThisWeek,
    ThisMonth,
    ALL,
} kFiterType;


@interface CostListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ComboxDelegate,PullTableViewDelegate>
{
    NSMutableArray *_totalArray;
    NSMutableArray *_fiteredArray;
    
    NSString *_money;
    NSString *_fb;
    kFiterType _type;
}
@property (nonatomic,copy) NSString *urlStr;


@property (strong, nonatomic) PullTableView *tableView;
@property (strong, nonatomic)  ComboBoxView *timeSelectView;


@property (nonatomic,assign) NSInteger segIndex;
@property (nonatomic,assign) NSInteger comIndex;

@end

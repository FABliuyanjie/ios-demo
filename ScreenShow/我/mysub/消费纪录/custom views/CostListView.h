//
//  CostListView.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "PullTableView.h"

typedef UITableViewCell* (^registerCell)(UITableView *tableView,UITableViewCell *cell);

@interface CostListView : PullTableView<PullTableViewDelegate>
@property (nonatomic,copy) NSString *downloadUrl;
@property (nonatomic,weak) id<PullTableViewDelegate> delegate;
@property (nonatomic) UITableViewCell *registerCell;

@property (nonatomic,weak) registerCell parserCell;

@end

//
//  Altertable.h
//  ScreenShow
//
//  Created by lee on 14-5-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Altertable : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}
@property(nonatomic,strong)NSMutableArray *datasource;
@end

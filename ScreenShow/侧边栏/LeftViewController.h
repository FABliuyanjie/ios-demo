//
//  LeftViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-19.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,strong)NSMutableArray *programArray;
@property(nonatomic,strong)NSMutableArray *topicArray;
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end

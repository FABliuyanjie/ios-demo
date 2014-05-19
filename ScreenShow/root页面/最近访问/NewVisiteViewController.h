//
//  NewVisiteViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "EGORefreshTableHeaderView.h"

@interface NewVisiteViewController : UIViewController<EGORefreshTableHeaderDelegate>

@property(nonatomic,strong)EGORefreshTableHeaderView *header;
@property(nonatomic,strong)NSMutableArray *anchorArray;
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@property(nonatomic,assign)BOOL isloading;
@property (nonatomic, assign) BOOL firstIn;
@property (nonatomic, strong) UILabel * loadingLabel;

@end

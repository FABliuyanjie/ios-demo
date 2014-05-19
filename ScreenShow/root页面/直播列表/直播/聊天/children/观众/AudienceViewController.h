//
//  AudienceViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "Anchor.h"


@interface AudienceViewController : UIViewController<EGORefreshTableHeaderDelegate>

@property(nonatomic,strong)NSMutableArray *anchorarray;//所有主播
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@property(nonatomic,strong)EGORefreshTableHeaderView *header;
@property(nonatomic,assign)BOOL isloading;
@property(nonatomic,strong)Anchor *anchor;
@property(nonatomic,strong)NSMutableArray *audienceArray;
@property (nonatomic, strong) UILabel * loadingLabel;
@property (nonatomic, assign) BOOL hasNext;
@property (nonatomic, assign) NSInteger page;

@end

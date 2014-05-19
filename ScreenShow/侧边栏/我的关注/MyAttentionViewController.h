//
//  MyAttentionViewController.h
//  ScreenShow
//
//  Created by lee on 14-4-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface MyAttentionViewController : UIViewController<EGORefreshTableHeaderDelegate>
{
    NSMutableArray *anchorItems;
}
@property(nonatomic,strong)EGORefreshTableHeaderView *header;
@property(nonatomic,strong)IBOutlet UITableView *table;
@property (nonatomic, assign) BOOL firstIn;
@property(nonatomic, assign)BOOL isloading;
@property (nonatomic, strong) UILabel * loadingLabel;

@end

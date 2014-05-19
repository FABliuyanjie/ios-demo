//
//  RootViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullPsCollectionView.h"
#import "ScreenPortaitViewController.h"
#import "ScreenLandViewController.h"



@interface RootViewController : UIViewController<PullPsCollectionViewDelegate,PSCollectionViewDataSource,PSCollectionViewDelegate>
{
    PullPsCollectionView *collectionView;
    NSMutableArray *heightArray;
    int onlinecount;
    int datatype;//-1标记全部主播列表  其他表示相对应话题的主播列表
    int page;
    BOOL hasNext;
    BOOL isloading;
    UILabel *loadingLabel;
    BOOL moisloadmore;
}
@property(nonatomic,strong)NSMutableArray *anchorItems;
@property(nonatomic,assign)int tag;//区别产生的对象  1.列表  2.我的关注
@end

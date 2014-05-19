//
//  BigPresentViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "Present.h"
#import "Delegatechain.h"

@interface BigPresentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int  totalcolland;
    int  totalcolportait;
    Delegatechain *delegatechain;
}
@property(nonatomic,assign)BOOL isportrait;
@property(nonatomic,strong)NSMutableArray *presentArray;
@property(nonatomic,strong)Anchor *anchor;
@property(nonatomic,strong)Present *presenttosend;
@end

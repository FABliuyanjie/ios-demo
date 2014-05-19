//
//  MyCostListViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFlatSegmentedControl.h"
#import "STSegmentedControl.h"


@interface MyCostListViewController : BaseViewController
@property (strong, nonatomic)  STSegmentedControl *segment;

@property (nonatomic,strong) NSArray *viewControllers;

-(id)initWithViewControllers:(NSArray*)vcs;
@end

//
//  ReportViewController.h
//  ScreenShow
//
//  Created by lee on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"

@interface ReportViewController : UIViewController
{
    IBOutlet UITableView *table;
}
@property(nonatomic,strong)NSMutableArray *arrayContent;
@property(nonatomic,strong)Anchor *anchor;
-(IBAction)btnbackClicked:(id)sender;
@end

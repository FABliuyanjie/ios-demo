//
//  FansTableViewCell.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *imgview;
@property(nonatomic,strong)IBOutlet UIImageView *imgview1;
@property(nonatomic,strong)IBOutlet UIImageView *imgview2;
@property(nonatomic,strong)IBOutlet UILabel *labelnum;
@property(nonatomic,strong)IBOutlet UILabel *labelname;
@property(nonatomic,strong)IBOutlet UILabel *labelcostmoney;

@end

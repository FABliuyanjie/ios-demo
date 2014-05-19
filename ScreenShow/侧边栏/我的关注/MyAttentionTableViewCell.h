//
//  MyAttentionTableViewCell.h
//  ScreenShow
//
//  Created by lee on 14-4-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAttentionTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *imgview;
@property(nonatomic,strong)IBOutlet UIImageView *imgview1;
@property(nonatomic,strong)IBOutlet UILabel *labelname;
@property(nonatomic,strong)IBOutlet UILabel *labelrank;
@property(nonatomic,strong)IBOutlet UILabel *labelnum;
@property(nonatomic,strong)IBOutlet UILabel *labelonline;
@property(nonatomic,strong)IBOutlet UIButton *btndelete;
@end

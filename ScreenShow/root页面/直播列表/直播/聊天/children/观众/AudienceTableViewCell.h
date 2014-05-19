//
//  AudienceTableViewCell.h
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudienceTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView * imgview;
@property(nonatomic,strong)IBOutlet UILabel *labelrank;
@property(nonatomic,strong)IBOutlet UILabel *labelname;
@property(nonatomic,strong)IBOutlet UIButton * audienceImageView;
@end

//
//  Personalinfo.h
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Personalinfo : UIView
@property(nonatomic,strong)IBOutlet UILabel *labelname;
@property(nonatomic,strong)IBOutlet UILabel *labelranknum;
@property(nonatomic,strong)IBOutlet UILabel *labelaudiencenum;

@property(nonatomic,strong)IBOutlet UIImageView *imgtou;
@property(nonatomic,strong)IBOutlet UIImageView *imgrank;
@property(nonatomic,strong)IBOutlet UIButton *btnx;

@end

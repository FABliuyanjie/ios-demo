//
//  SelectLoginViewController.h
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-22.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "PopUpBox.h"

@interface SelectLoginViewController : BaseViewController

@property (strong, nonatomic) PopUpBox * popUpBox;
@property (copy, nonatomic) NSString * openID;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * typeName;
@property (copy, nonatomic) NSString * headPhotoUrl;

- (IBAction)NoAccountLogin:(UIButton *)sender;

- (IBAction)haveAccountLogin:(UIButton *)sender;

@end

//
//  SubChangEmailViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"

@interface SubChangEmailViewController : BaseViewController
@property (nonatomic,strong) NSString *email;
@property (weak, nonatomic) IBOutlet UILabel *notification;
- (IBAction)returnBtn:(UIButton *)sender;

@end

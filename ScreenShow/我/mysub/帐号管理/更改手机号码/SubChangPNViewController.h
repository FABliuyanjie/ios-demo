//
//  SubChangPNViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-2.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"

@interface SubChangPNViewController : BaseViewController

@property (nonatomic,copy) NSString *mPhoneNum;
@property (nonatomic, copy) NSString * verifyCode;
@property (nonatomic, weak) IBOutlet UITextField * verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UILabel *notification;

- (IBAction)reSendVerifyCode:(UIButton *)sender;
- (IBAction)EnVerifyCode:(id)sender;

@end

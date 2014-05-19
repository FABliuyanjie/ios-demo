//
//  LogInViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : BaseViewController
@property (nonatomic,assign) BOOL isFromMyViewController;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headImageBackView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwdTf;



- (IBAction)logIn:(UIButton *)sender;

@end

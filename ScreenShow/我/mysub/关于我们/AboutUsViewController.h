//
//  AboutUsViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * yearLabel;
@property (nonatomic, weak) IBOutlet UILabel * versionLabel;
@property (nonatomic, weak) IBOutlet UIButton * checkVersionBtn;

- (IBAction)onCheckVersion:(UIButton *)sender;

@end

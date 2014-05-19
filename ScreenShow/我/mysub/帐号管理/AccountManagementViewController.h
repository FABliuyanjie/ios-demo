//
//  AccountManagementViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFlatButton.h"
@interface AccountManagementViewController : BaseViewController<UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet PBFlatButton *phoneNumberBtn;
@property (weak, nonatomic) IBOutlet PBFlatButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;


//新加的等级
@property (weak, nonatomic) IBOutlet UIImageView *level1Image;
@property (weak, nonatomic) IBOutlet UILabel *level1Lb;
@property (weak, nonatomic) IBOutlet UIImageView *level2Image;
@property (weak, nonatomic) IBOutlet UILabel *level2Lb;

- (IBAction)changHeadPhoto:(UITapGestureRecognizer *)sender;

- (IBAction)LogOut:(id)sender;


@end

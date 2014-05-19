//
//  FindPassWordViewController.h
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-7.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "PopUpBox.h"

@interface FindPassWordViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton * phoneNumBtn;
@property (nonatomic, weak) IBOutlet UIButton * emailBtn;
@property (nonatomic, strong) PopUpBox * popUpBox;

-(IBAction)phoneNumBtnClick:(id)sender;
-(IBAction)emailBtnClick:(id)sender;

@end

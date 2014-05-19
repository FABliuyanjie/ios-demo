//
//  PopUpBox.h
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemClickedBlock)(NSString *);
typedef void(^ClickedBlock)(id);
typedef void(^AllClickedBlock)(NSString *, NSString *, id);


@interface PopUpBox : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * upTextField;;
@property (nonatomic, strong) UITextField * downTextField;
@property (nonatomic, weak) UIButton * upButton;
@property (nonatomic, weak) UIButton * downButton;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, copy) ItemClickedBlock upBtnClickBlock;
@property (nonatomic, copy) AllClickedBlock downClickBlock;
@property (nonatomic, copy) ClickedBlock closeClickBlock;
@property (nonatomic, strong) UILabel * tipsLabel;

-(void)setUpButtonWithTop:(CGFloat)top;
-(void)setDownButtonWithTop:(CGFloat)top;
-(void)setUpTextFieldWithTop:(CGFloat)top;
-(void)setDownTextFieldWithTop:(CGFloat)top;
-(void)closeBtnClick;

@end

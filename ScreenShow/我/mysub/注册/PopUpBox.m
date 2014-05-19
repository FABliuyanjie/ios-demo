//
//  PopUpBox.m
//  ScreenShow
//
//  Created by 刘艳杰 on 14-5-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "PopUpBox.h"

@implementation PopUpBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialUI];
    }
    return self;
}

-(void)initialUI
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.width - 10, self.height - 10)];
    self.imageView.image = [UIImage imageNamed:@"popUpBox_backgroundImage.png"];
    self.imageView.userInteractionEnabled= YES;
    [self addSubview:self.imageView];
    
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.width - 10, 30)];
    self.tipsLabel.backgroundColor = [UIColor clearColor];
    self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
    self.tipsLabel.textColor = [UIColor whiteColor];
    self.tipsLabel.hidden = YES;
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:self.tipsLabel];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * closeBackImge = [UIImage imageNamed:@"popUpBox_closeBtnImage.png"];
    closeBtn.frame = CGRectMake(0, 0, closeBackImge.size.width, closeBackImge.size.height);
    [closeBtn setBackgroundImage:closeBackImge forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    self.upTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, self.imageView.frame.size.width - 20, 25)];
    self.upTextField.font = [UIFont systemFontOfSize:16.0f];
    [self.upTextField becomeFirstResponder];
    self.upTextField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.upTextField.borderStyle = UITextBorderStyleNone;
    self.upTextField.backgroundColor = [UIColor whiteColor];
    self.upTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.upTextField.userInteractionEnabled = YES;
    self.upTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.upTextField.hidden = YES;
    [self.imageView addSubview:self.upTextField];
    
    self.downTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, self.imageView.frame.size.width - 20, 25)];
    self.downTextField.font = [UIFont systemFontOfSize:16.0f];
    self.downTextField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.downTextField.backgroundColor = [UIColor whiteColor];
    self.downTextField.borderStyle = UITextBorderStyleBezel;
    self.downTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.downTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.downTextField.hidden = YES;
    [self.imageView addSubview:self.downTextField];
    
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.upButton.frame = CGRectMake(10, 70, self.imageView.width - 20, 40);
    self.upButton.titleLabel.textColor = [UIColor whiteColor];
    [self.upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.upButton.hidden = YES;
    [self.upButton addTarget:self action:@selector(upButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.upButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];

    [self.imageView addSubview:self.upButton];
    
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = CGRectMake(10, 70, self.imageView.width - 20, 40);
    [self.downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.downButton.titleLabel.textColor = [UIColor whiteColor];
    self.downButton.hidden = YES;
    self.downButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [self.imageView addSubview:self.downButton];
    

    
}

-(void)setUpButtonWithTop:(CGFloat)top
{
    self.upButton.frame = CGRectMake(10, top - 10, self.imageView.width - 20, 55);
    UIImage * normalImage = [[UIImage imageNamed:@"popUpBox_Btn_normal.png"] stretchableImageWithLeftCapWidth:self.upButton.width / 2.0f topCapHeight:self.upButton.height / 2.0f];
    [self.upButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    UIImage * selectedImage = [[UIImage imageNamed:@"popUpBox_Btn_selected.png"] stretchableImageWithLeftCapWidth:self.upButton.width / 2.0f topCapHeight:self.downButton.height / 2.0f];
    [self.upButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.upButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self reloadInputViews];
}

-(void)setDownButtonWithTop:(CGFloat)top
{
    
    self.downButton.frame = CGRectMake(10, top - 10, self.imageView.width - 20, 55);
    UIImage * normalImage = [[UIImage imageNamed:@"popUpBox_Btn_normal.png"] stretchableImageWithLeftCapWidth:self.downButton.width / 2.0f topCapHeight:self.downButton.height / 2.0f];
    [self.downButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    UIImage * selectedImage = [[UIImage imageNamed:@"popUpBox_Btn_selected.png"] stretchableImageWithLeftCapWidth:self.downButton.width / 2.0f topCapHeight:self.downButton.height / 2.0f];
    [self.downButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.downButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];

    [self reloadInputViews];
}

-(void)setUpTextFieldWithTop:(CGFloat)top
{
    self.upTextField.frame = CGRectMake(15, top - 10, self.imageView.width - 30, 30);
    [self reloadInputViews];
}

-(void)setDownTextFieldWithTop:(CGFloat)top
{
    self.downTextField.frame = CGRectMake(15, top - 10, self.imageView.width - 30, 30);
    [self reloadInputViews];

}

-(void)upButtonClick
{
    NSLog(@"上面按钮点击响应");
    _upBtnClickBlock(self.upTextField.text);
}


-(void)downButtonClick
{
    NSLog(@"下面按钮点击响应");
    _downClickBlock(self.downTextField.text, self.upTextField.text, self);
}

-(void)closeBtnClick
{
    NSLog(@"关闭按钮点击响应");
    _closeClickBlock(self);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

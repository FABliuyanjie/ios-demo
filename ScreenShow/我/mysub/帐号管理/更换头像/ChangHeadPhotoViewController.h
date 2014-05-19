//
//  ChangHeadPhotoViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-4-2.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageCropperView.h"
@interface ChangHeadPhotoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet ImageCropperView *cropperView;
@property (nonatomic,strong) UIImage *originImage;

//
- (IBAction)verifyImage:(UIButton *)sender;

@end

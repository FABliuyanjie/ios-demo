//
//  ChangHeadPhotoViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-2.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "ChangHeadPhotoViewController.h"

@interface ChangHeadPhotoViewController ()

@end

@implementation ChangHeadPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.cropperView.layer.borderWidth = 1.0;
    self.cropperView.layer.borderColor = [UIColor blueColor].CGColor;
    [ self.cropperView setup];
    self.cropperView.image = self.originImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)verifyImage:(UIButton *)sender {
    [self.cropperView finishCropping];
    [MBProgressHUD showMessag:@"" toView:self.view];
    
}
@end

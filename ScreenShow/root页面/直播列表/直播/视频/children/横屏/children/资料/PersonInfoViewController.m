//
//  PersonInfoViewController.m
//  ScreenShow
//
//  Created by lee on 14-3-12.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "PersonInfoViewController.h"


@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

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
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *singTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singTapped:)];
    singTap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:singTap];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gaoqing" ofType:@"jpeg"];
    self.imageview.image=[UIImage imageWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)singTapped:(id)sender
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

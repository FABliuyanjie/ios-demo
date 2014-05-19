//
//  WritenumViewController.m
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "WritenumViewController.h"

@interface WritenumViewController ()

@end

@implementation WritenumViewController

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
    [self.textfield becomeFirstResponder];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclicked:)];
    [self.view addGestureRecognizer:tap];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tapclicked:(id)sender
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
#pragma mark-
#pragma mark keyboadr notification
-(void)keyboardWillShow:(NSNotification*)notification{
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    CGRect rect=self.view.frame;
    if (self.view.frame.size.width==320) {
        rect.origin.y=0;
        rect.size.height=SCREEN_FRAME_HEIGHT-kbSize.height-STATUSBAR_HEIGHT_IOS7;
    }
    else
    {
        rect.origin.y=0;
        rect.size.height=320-kbSize.width-STATUSBAR_HEIGHT_IOS7;
    }
    self.view.frame=rect;
}
-(IBAction)btnsendClicked:(id)sender
{
    [_delegate didwritenum:[_textfield.text intValue]];
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

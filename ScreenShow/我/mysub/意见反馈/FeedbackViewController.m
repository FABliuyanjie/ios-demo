//
//  FeedbackViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "FeedbackViewController.h"

#define PLACEHOLDER         (@"觉得哪里不爽，给点意见～")

#define TableViewSeparatorColor		RGBCOLOR(207.0, 207.0, 207.0)


@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
{
    UMFeedback * umFeedback;
}

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
    self.title = @"感谢您的宝贵意见";
    
    umFeedback = [UMFeedback sharedInstance];
    [umFeedback setAppkey:@"5373474456240b1cbc020bde" delegate:self];
    
    self.textView = [[TComposeView alloc] init];
    self.textView.frame = CGRectMake(5, 15, SCREEN_WIDTH - 10, 160);
    self.textView.backgroundColor = [UIColor clearColor];
    
//     self.textView.contentView.layer.cornerRadius = 4;
	 self.textView.tipsLabel.hidden = YES;
     self.textView.placeholder = PLACEHOLDER;
     self.textView.contentView.font = [UIFont systemFontOfSize:16.0f];
     self.textView.contentView.backgroundColor = [UIColor colorWithHex:@"#fafafa"];
     self.textView.contentView.layer.borderColor = TableViewSeparatorColor.CGColor;
    
    [self.view addSubview:self.textView];

    
    self.commitBtn.backgroundColor = [UIColor colorWithRed:154 / 255.0f green:60 / 255.0f blue:80 / 255.0f alpha:1];
    [self.commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    self.commitBtn.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame) + 10, SCREEN_WIDTH - 20, 45);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapClick
{
    [self.textView resignFirstResponder];
}

-(IBAction)commit:(id)sender
{
    NSLog(@"提交");
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"female" forKey:@"gender"];
    [dictionary setObject:@"2" forKey:@"age_group"];
    [dictionary setObject:self.textView.text forKey:@"content"];
    
    NSDictionary *remark = [NSDictionary dictionaryWithObject:@"备注" forKey:@"name"];
    [dictionary setObject:remark forKey:@"remark"];
    NSDictionary *contact = [NSDictionary dictionaryWithObject:@"联系方式" forKey:@"email"];
    [dictionary setObject:contact forKey:@"contact"];
    [umFeedback post:dictionary];
}

-(void)postFinishedWithError:(NSError *)error
{
    if (error == nil) {
        [[iToast makeText:@"提交成功"] show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

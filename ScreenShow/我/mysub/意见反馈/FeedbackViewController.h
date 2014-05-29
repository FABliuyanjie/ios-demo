//
//  FeedbackViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TComposeView.h"
#import "UMFeedback.h"

@interface FeedbackViewController : BaseViewController<UMFeedbackDataDelegate>

@property (weak, nonatomic) IBOutlet UIButton * commitBtn;
@property (strong, nonatomic) TComposeView * textView;

-(IBAction)commit:(id)sender;

@end

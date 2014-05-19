//
//  ShareViewController.h
//  ScreenShow
//
//  Created by lee on 14-5-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareViewController : UIViewController
{
    IBOutlet UITextView *textview;
}
-(IBAction)btnbackClicked:(id)sender;
-(IBAction)shareClicked:(id)sender;
@end

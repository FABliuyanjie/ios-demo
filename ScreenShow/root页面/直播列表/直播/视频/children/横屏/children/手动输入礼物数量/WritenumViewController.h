//
//  WritenumViewController.h
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol writenumvcprotocal <NSObject>
-(void)didwritenum:(int)num;
@end
@interface WritenumViewController : UIViewController
{
    
}
@property(nonatomic,assign)id<writenumvcprotocal>delegate;
@property(nonatomic,weak)IBOutlet UITextField *textfield;
-(IBAction)btnsendClicked:(id)sender;
@end

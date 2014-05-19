//
//  ScreenPortaitViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
@interface ScreenPortaitViewController : UIViewController
{
    BOOL isControlhide;
    BOOL isMiddlehide;
    NSMutableArray *controlArray;
    IBOutlet UIButton *btnBack;
    IBOutlet UIView *viewtransparent;
    IBOutlet UIView *viewtransparent1;
    IBOutlet UIImageView *imgrank;
    IBOutlet UILabel *labelrank;
    IBOutlet UIButton *btnleft;
    IBOutlet UIButton *btnright;
}
@property(nonatomic,strong)NSMutableArray *anchorarray;//所有主播
@property(nonatomic,strong)IBOutlet UIView *topbar;
@property(nonatomic,strong)IBOutlet UIView *bottombar;
@property(nonatomic,strong)IBOutlet UIView *middle;
@property(nonatomic,strong)IBOutlet UIView *btnControl;
@property(nonatomic,strong)Anchor *anchor;
@property(nonatomic,strong)Anchor *anchor1;
@property(nonatomic,strong)IBOutlet  UILabel *labelname;
@property(nonatomic,strong)IBOutlet UILabel *labelname1;
@property(nonatomic,strong)IBOutlet UIImageView *imgtou;
@property(nonatomic,strong)IBOutlet UILabel *labelredbag;
@property(nonatomic,strong)IBOutlet UILabel *labelstarttime;
@property(nonatomic,strong)IBOutlet UIButton *btnattention;
@property(nonatomic,strong)IBOutlet UILabel *labelaudiencecount;
@property(nonatomic,strong)IBOutlet UIImageView *imgviewaudience;



-(IBAction)btnControlClicked:(id)sender;
-(IBAction)btnBackClicked:(id)sender;
-(IBAction)moreClicked:(id)sender;
-(IBAction)btnFullScreenClicked:(id)sender;
-(IBAction)btn6Clicked:(UIButton *)sender;
-(IBAction)btnAttentionClicked:(UIButton *)sender;
-(IBAction)btnleftorrightClicked:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil obj:(Anchor *)anchor;
@end

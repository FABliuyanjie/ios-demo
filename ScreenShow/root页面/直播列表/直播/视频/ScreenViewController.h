//
//  ScreenViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "Anchor.h"


@interface ScreenViewController : UIViewController

@property(nonatomic,strong)UIViewController *protraitVC;
@property(nonatomic,strong)UIViewController *landVC;
@property(nonatomic,strong) AVPlayerLayer *playerLayer;
@property(nonatomic,strong) AVPlayer *player;

@property(nonatomic,assign)int isgzofcurrentanchor;//当前直播室主播是不是被关注  1关注  0未关注
@property(nonatomic,strong)Anchor *anchor;

- (id)initWithsportaitController:(UIViewController*)protraitVC
                  landController:(UIViewController*)landVC;
@end

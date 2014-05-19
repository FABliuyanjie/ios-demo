//
//  LiveStudioViewController.h
//  ScreenShow
//
//  Created by lee on 14-3-5.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMotion/CoreMotion.h>

@interface LiveStudioViewController : UIViewController
{
    SystemSoundID                 soundID;
    CMMotionManager *motionManager;
}
@property(nonatomic,strong)UIViewController *screenVC;
@property(nonatomic,strong)UIViewController *mysegmentVC;
- (id)initWithscreenController:(UIViewController*)screenController
                       mysegmentController:(UIViewController*)mysegmentController;

@end

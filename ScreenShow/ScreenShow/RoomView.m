//
//  RoomView.m
//  ScreenShow
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "RoomView.h"

@implementation RoomView
@synthesize bottomView;
@synthesize imageview;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%@",self.superview);
    self.bottomView.frame=CGRectMake(0, self.frame.size.height-self.bottomView.frame.size.height, self.frame.size.width, self.bottomView.frame.size.height);
    self.imageview.frame=CGRectMake(5, 5, self.frame.size.width-2*5, self.frame.size.width-2*5);
}



@end

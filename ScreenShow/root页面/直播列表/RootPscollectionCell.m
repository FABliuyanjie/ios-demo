//
//  CellView.m
//  PSCollectionViewDemo
//
//  Created by Eric on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootPscollectionCell.h"

@implementation RootPscollectionCell
@synthesize picView;

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
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    NSLog(@"%f",self.frame.size.height);
////    CGRect rect=self.frame;
////    self.view1.frame=CGRectMake(0, rect.size.height-self.view1.frame.size.height, rect.size.width, self.view1.frame.size.height);
////    CGRect rectoflabelaudicecount=self.labelaudicecount.frame;
////    self.labelaudicecount.frame=CGRectMake(self.picViewAudience.frame.origin.x+10, 0, rectoflabelaudicecount.size.width, rectoflabelaudicecount.size.height);
////    CGRect rectoflabenickname=self.labenickname.frame;
////    self.labenickname.frame=CGRectMake(rect.size.width-rectoflabenickname.size.width, 0, rectoflabenickname.size.width, rectoflabenickname.size.height);
////    picView.frame=CGRectMake(0, 0, rect.size.width, rect.size.height);
//}
@end

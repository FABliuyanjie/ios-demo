//
//  EmotionScroller.m
//  ScreenShow
//
//  Created by lee on 14-4-21.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "EmotionScroller.h"

@implementation EmotionScroller

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pagingEnabled=YES;
        self.scrollEnabled=YES;
        self.bounces=NO;
        self.showsHorizontalScrollIndicator=YES;
        self.showsVerticalScrollIndicator=YES;
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
-(void)setColnum:(int)colnum
{
    _colnum=colnum;
    int totalpage=0;
    if (self.imgarray.count%(self.colnum*3)==0) {
        totalpage=(int)self.imgarray.count/(self.colnum*3);
    }
    else
    {
        totalpage=(int)self.imgarray.count/(self.colnum*3)+1;
    }
    self.contentSize=CGSizeMake(self.frame.size.width*totalpage, self.frame.size.height);
    for (int i=0; i<totalpage; i++) {
        UIView *aview=[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.width)];
        aview.backgroundColor=[UIColor lightGrayColor];
        for (int j=0;j<3; j++) {
            for (int k=0; k<colnum; k++) {
                if ((i*3*colnum+colnum*j+k)<self.imgarray.count) {
                    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(k*(self.frame.size.width/colnum), j*(self.frame.size.height/3), self.frame.size.width/colnum, self.frame.size.height/3)];
                    [btn setImage:[self.imgarray objectAtIndex:i*3*colnum+colnum*j+k] forState:UIControlStateNormal];
                    [aview addSubview:btn];
                    btn.tag=i*3*colnum+colnum*j+k;
                    [btn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchDown];
                }
            }
        }
        [self addSubview:aview];
    }
}
-(void)btnclicked:(UIButton *)sender
{
    [self.delegate1 didselectemotion:sender.tag];
}
@end

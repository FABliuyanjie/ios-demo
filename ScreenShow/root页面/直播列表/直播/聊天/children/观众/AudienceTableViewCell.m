//
//  AudienceTableViewCell.m
//  ScreenShow
//
//  Created by lee on 14-3-13.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AudienceTableViewCell.h"

@implementation AudienceTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.audienceImageView.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

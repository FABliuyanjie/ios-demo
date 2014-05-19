//
//  TComposeView.h
//  TMarket
//
//  Created by ZhangAo on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TComposeView : UIControl
<UITextViewDelegate>

@property (nonatomic, assign) int maxWordNumber;	//defaut is 140.
@property (nonatomic, assign) BOOL wordNumberInBounds;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, readonly) UITextView *contentView;
@property (nonatomic, readonly) UILabel    *tipsLabel;

@end

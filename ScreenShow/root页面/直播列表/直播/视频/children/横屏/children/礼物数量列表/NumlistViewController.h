//
//  NumlistViewController.h
//  ScreenShow
//
//  Created by lee on 14-5-15.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegatechain.h"

@protocol numdidselect <NSObject>
-(void)numdidselect:(int)sender;
@end

@interface NumlistViewController : UIViewController<UITableViewDelegate>
{
    NSMutableArray *dataarray;
}
@property(nonatomic,assign)id<numdidselect> delegate;
@property(nonatomic,strong)Delegatechain *delegatechain;
@end

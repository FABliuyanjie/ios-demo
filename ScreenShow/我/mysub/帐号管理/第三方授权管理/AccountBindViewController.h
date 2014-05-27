//
//  AccountBindViewController.h
//  ScreenShow
//
//  Created by 李正峰 on 14-5-22.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "BaseTableViewController.h"
@protocol DetailsViewControllerDelegate
- (void)didSelectPhotoAttributeWithKey:(NSString *)key;
@end
@interface AccountBindViewController : BaseTableViewController<UIAlertViewDelegate>
{
    NSMutableArray *_shareTypeArray;
    NSArray * typeArray;
    NSMutableArray * requestTypeArray;
    NSString * pfname;
}

/**
 *  从新从服务器请求绑定的用户信息
 */
//-(void)refreshInfo;



@end


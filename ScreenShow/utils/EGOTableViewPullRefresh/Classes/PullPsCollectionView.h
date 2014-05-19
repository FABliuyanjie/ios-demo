//
//  PullPsCollectionView.h
//  PSCollectionViewDemo
//
//  Created by Eric on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PSCollectionView.h"
#import <UIKit/UIKit.h>
#import "MessageInterceptor.h"
#import "EGORefreshTableHeaderView.h"

@class PullPsCollectionView;
@protocol PullPsCollectionViewDelegate <NSObject>

/* After one of the delegate methods is invoked a loading animation is started, to end it use the respective status update property */
- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView*)pullTableView;
- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView*)pullTableView;
- (void)didscrolltobottom;
@end
@interface PullPsCollectionView : PSCollectionView<EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *refreshView;
    // Since we use the contentInsets to manipulate the view we need to store the the content insets originally specified.
    UIEdgeInsets realContentInsets;
    
    // For intercepting the scrollView delegate messages.
    MessageInterceptor * delegateInterceptor;
    
    // Config
    UIImage *pullArrowImage;
    UIColor *pullBackgroundColor;
    UIColor *pullTextColor;
    NSDate *pullLastRefreshDate;
    
    // Status
    BOOL pullTableIsRefreshing;
    BOOL pullTableIsLoadingMore;
    
    // Delegate
}
/* The configurable display properties of PullTableView. Set to nil for default values */
@property (nonatomic, retain) UIImage *pullArrowImage;
@property (nonatomic, retain) UIColor *pullBackgroundColor;
@property (nonatomic, retain) UIColor *pullTextColor;

/* Set to nil to hide last modified text */
@property (nonatomic, retain) NSDate *pullLastRefreshDate;

/* Properties to set the status of the refresh/loadMore operations. */
/* After the delegate methods are triggered the respective properties are automatically set to YES. After a refresh/reload is done it is necessary to set the respective property to NO, otherwise the animation won't disappear. You can also set the properties manually to YES to show the animations. */
@property (nonatomic, assign) BOOL pullTableIsRefreshing;

/* Delegate */
@property (nonatomic, assign) IBOutlet id<PullPsCollectionViewDelegate,NSObject> pullDelegate;
@end

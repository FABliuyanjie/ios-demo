//
//  PullPsCollectionView.m
//  PSCollectionViewDemo
//
//  Created by Eric on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PullPsCollectionView.h"
@interface PullPsCollectionView (Private) <UIScrollViewDelegate>
- (void) config;
- (void) configDisplayProperties;
@end
@implementation PullPsCollectionView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}
# pragma mark - Custom view configuration

- (void) config
{
    /* Message interceptor to intercept scrollView delegate messages */
    delegateInterceptor = [[MessageInterceptor alloc] init];
    delegateInterceptor.middleMan = self;
    delegateInterceptor.receiver = self.delegate;
    super.delegate = (id)delegateInterceptor;
    
    
    /* Status Properties */
    pullTableIsRefreshing = NO;
    pullTableIsLoadingMore = NO;
    
    /* Refresh View */
    refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    refreshView.delegate = self;
    [self addSubview:refreshView];
}
# pragma mark - View changes

- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark - Preserving the original behaviour

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if(delegateInterceptor) {
        super.delegate = nil;
        delegateInterceptor.receiver = delegate;
        super.delegate = (id)delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}

- (void)reloadData
{
    [super reloadData];
    // Give the footers a chance to fix it self.
}

#pragma mark - Status Propreties

@synthesize pullTableIsRefreshing;

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    if(!pullTableIsRefreshing && isRefreshing) {
        // If not allready refreshing start refreshing
        [refreshView startAnimatingWithScrollView:self];
        pullTableIsRefreshing = YES;
    } else if(pullTableIsRefreshing && !isRefreshing) {
        [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        pullTableIsRefreshing = NO;
    }
}
#pragma mark - Display properties

@synthesize pullArrowImage;
@synthesize pullBackgroundColor;
@synthesize pullTextColor;
@synthesize pullLastRefreshDate;

- (void)configDisplayProperties
{
    [refreshView setBackgroundColor:self.pullBackgroundColor textColor:self.pullTextColor arrowImage:self.pullArrowImage];
}

- (void)setPullArrowImage:(UIImage *)aPullArrowImage
{
    if(aPullArrowImage != pullArrowImage) {
        [self configDisplayProperties];
    }
}

- (void)setPullBackgroundColor:(UIColor *)aColor
{
    if(aColor != pullBackgroundColor) {
        [self configDisplayProperties];
    } 
}

- (void)setPullTextColor:(UIColor *)aColor
{
    if(aColor != pullTextColor) {
        [self configDisplayProperties];
    } 
}

- (void)setPullLastRefreshDate:(NSDate *)aDate
{
    if(aDate != pullLastRefreshDate) {
        [refreshView refreshLastUpdatedDate];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [refreshView egoRefreshScrollViewDidScroll:scrollView];
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    if (scrollView.contentOffset.y + scrollView.height >= scrollView.contentSize.height+60) {
         [self.pullDelegate didscrolltobottom];
	}
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewWillBeginDragging:scrollView];
    
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [delegateInterceptor.receiver scrollViewWillBeginDragging:scrollView];
    }
}
#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    pullTableIsRefreshing = YES;
    [self.pullDelegate pullPsCollectionViewDidTriggerRefresh:self];
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return self.pullLastRefreshDate;
}
@end

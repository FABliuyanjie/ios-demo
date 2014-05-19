//
//  ComboBoxView.h
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ComboxDelegate;
@interface ComboBoxView : UIView < UITableViewDelegate, UITableViewDataSource > {
	UILabel			*_selectContentLabel;
	UIButton		*_pulldownButton;
	UIButton		*_hiddenButton;
	UITableView		*_comboBoxTableView;
	NSArray			*_comboBoxDatasource;
	BOOL			_showComboBox;
}
@property (nonatomic,strong) NSIndexPath *selectedIndex;
@property (nonatomic, strong)  NSArray *comboBoxDatasource;
@property (nonatomic,weak)  id<ComboxDelegate> delegate;
@property (nonatomic,assign) BOOL isSelectedLastObject;
@property (nonatomic) CGRect showFrame;
- (void)initVariables;
- (void)initCompentWithFrame:(CGRect)frame;
- (void)setContent:(NSString *)content;
- (void)show;
- (void)hidden;
- (void)drawListFrameWithFrame:(CGRect)frame withContext:(CGContextRef)context;

@end


@protocol ComboxDelegate<NSObject>
-(void)comboxCellDidSelected:(ComboBoxView*)combox atIndex:(NSIndexPath*)index;
- (void)comboxCellWillSelected;

@end
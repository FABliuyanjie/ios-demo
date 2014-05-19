//
//  Altertable.m
//  ScreenShow
//
//  Created by lee on 14-5-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "Altertable.h"
#import "AltertableCell.h"

static float altertablecellheight=30;

@implementation Altertable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        table.delegate=self;
        table.dataSource=self;
        [self addSubview:table];
    }
    return self;
}
-(void)setDatasource:(NSMutableArray *)datasource
{
    _datasource=datasource;
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSections
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AltertableCell";
    AltertableCell *cell = (AltertableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AltertableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.labeltext.text=[_datasource objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return altertablecellheight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidden=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

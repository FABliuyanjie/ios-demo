//
//  ComboBoxView.m
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ComboBoxView.h"


@implementation ComboBoxView

@synthesize comboBoxDatasource = _comboBoxDatasource;

-(void)awakeFromNib
{

    [self initVariables];
    @synchronized(self)
    {
        _showFrame = self.frame;
        
        self.frame = CGRectMake(self.right, self.top, self.width, 25);
        [self initCompentWithFrame:self.frame];
    }
}
- (id)initWithFrame:(CGRect)frame {
    _showFrame = frame;
    frame.size.height=25;
    if ((self = [super initWithFrame:frame])) {
		[self initVariables];
		[self initCompentWithFrame:frame];
    }
    return self;
}

#pragma mark -
#pragma mark custom methods

- (void)initVariables {
	_showComboBox = NO;
}

- (void)initCompentWithFrame:(CGRect)frame {
	_selectContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 45, 25)];
	_selectContentLabel.font = [UIFont systemFontOfSize:14.0f];
	_selectContentLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:_selectContentLabel];

	
	_pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_pulldownButton setFrame:CGRectMake(frame.size.width - 25, 0, 25, 25)];
	[_pulldownButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list_ico_d" ofType:@"png"]]
							   forState:UIControlStateNormal];
    
//    [_pulldownButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	[_pulldownButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_pulldownButton];
	
	_hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_hiddenButton setFrame:CGRectMake(0, 0, frame.size.width - 25, 25)];
	_hiddenButton.backgroundColor = [UIColor clearColor];
	[_hiddenButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_hiddenButton];
	
	_comboBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(1, 26, _showFrame.size.width -2, _showFrame.size.height - 27)];
    _comboBoxTableView.bounces = NO;
    if (IsIOS7) {
        _comboBoxTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
	_comboBoxTableView.dataSource = self;
	_comboBoxTableView.delegate = self;
	_comboBoxTableView.backgroundColor = [UIColor whiteColor];
	_comboBoxTableView.separatorColor = [UIColor blackColor];
	_comboBoxTableView.hidden = YES;
	[self addSubview:_comboBoxTableView];

}

- (void)setContent:(NSString *)content {
	_selectContentLabel.text = content;
}

- (void)show {
    self.frame = _showFrame;
    [_comboBoxTableView reloadData];
    _comboBoxTableView.hidden = NO;
	_showComboBox = YES;
	[self setNeedsDisplay];
}

- (void)hidden {
    self.frame = CGRectMake(_showFrame.origin.x,_showFrame.origin.y, _showFrame.size.width, 25);
	_comboBoxTableView.hidden = YES;
 
	_showComboBox = NO;
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark custom event methods

- (void)pulldownButtonWasClicked:(id)sender {
	if (_showComboBox == YES) {
		[self hidden];
	}else {
		[self show];
	}
    
    if (self.delegate && [self.delegate conformsToProtocol:NSProtocolFromString(@"ComboxDelegate")]){
        [self.delegate performSelector:@selector(comboxCellWillSelected) withObject:self withObject:nil];
    }

}

#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_comboBoxDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [_comboBoxTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
	}
	cell.textLabel.text = (NSString *)[_comboBoxDatasource objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 25.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self hidden];
    self.selectedIndex = indexPath;
    if (indexPath.row==_comboBoxDatasource.count-1) {
        _isSelectedLastObject = YES;
    }else{
        _isSelectedLastObject = NO;
    }
	_selectContentLabel.text = (NSString *)[_comboBoxDatasource objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate conformsToProtocol:NSProtocolFromString(@"ComboxDelegate")]){
        [self.delegate performSelector:@selector(comboxCellDidSelected:atIndex:) withObject:self withObject:indexPath];
    }
}

- (void)drawListFrameWithFrame:(CGRect)frame withContext:(CGContextRef)context {
	CGContextSetLineWidth(context, 2.0f);
	CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
	if (_showComboBox == YES) {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height));
		
	}else {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, frame.size.width, 25.0f));
	}
	CGContextDrawPath(context, kCGPathStroke);	
	CGContextMoveToPoint(context, 0.0f, 25.0f);
	CGContextAddLineToPoint(context, frame.size.width, 25.0f);
	CGContextMoveToPoint(context, frame.size.width - 25, 0);
	CGContextAddLineToPoint(context, frame.size.width - 25, 25.0f);
	
	CGContextStrokePath(context);
}


#pragma mark -
#pragma mark drawRect methods

- (void)drawRect:(CGRect)rect {
	[self drawListFrameWithFrame:self.frame withContext:UIGraphicsGetCurrentContext()];
}


#pragma mark -
#pragma mark dealloc memery methods

- (void)dealloc {
	_comboBoxTableView.delegate		= nil;
	_comboBoxTableView.dataSource	= nil;
	_comboBoxDatasource				= nil;
	
  
}


@end

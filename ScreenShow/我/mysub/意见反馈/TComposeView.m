//
//  TComposeView.m
//  TMarket
//
//  Created by ZhangAo on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "TComposeView.h"

@interface TComposeView ()

@end

@implementation TComposeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_maxWordNumber = 140;
        _wordNumberInBounds = NO;
        
        _contentView = [[UITextView alloc] init];
        _contentView.delegate = self;
        _contentView.font = [UIFont systemFontOfSize:16.0f];
        _contentView.delegate = self;
        _contentView.layer.borderWidth = 1;
//        _contentView.layer.cornerRadius = 8;
        [_contentView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_contentView setAutocorrectionType:UITextAutocorrectionTypeNo];
        _contentView.layer.borderColor = [UIColor blackColor].CGColor;

        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = [UIFont systemFontOfSize:16];
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_contentView];
        [self addSubview:_tipsLabel];
        
        [self addTarget:self action:@selector(transferToNext) forControlEvents:UIControlEventAllTouchEvents];
    }
    return self;
}

-(void)transferToNext{
    if ([self.nextResponder isMemberOfClass:[UIControl class]]) {
        [(UIControl *)self.nextResponder sendActionsForControlEvents:UIControlEventAllTouchEvents];
    }
}

//-(NSString *)text{
//    return [_contentView.text replaceOldString:@"\u2006" WithNewString:@""];
//}

-(void)setText:(NSString *)text{
	MY_OBJ_RELEASE(_text);
    _text = @"";
	if ([NSString isBlank:text]) return;
	_text = [text copy];
    _contentView.text = text;
//    _tipsLabel.text = [NSString stringWithFormat:@"%d",_maxWordNumber - text.length];
}

-(void)clearsText{
	_contentView.text = @"";
	_tipsLabel.text = [NSString stringWithFormat:@"%d",_maxWordNumber -_contentView.text.length];
}

-(void)setPlaceholder:(NSString *)placeholder{
	MY_OBJ_RELEASE(_placeholder);
    if ([NSString isBlank:placeholder]) return;
    MY_OBJ_RELEASE(_placeholder);
    _placeholder = [placeholder copy];
	if ([NSString isBlank:self.text]) {
		self.contentView.text = _placeholder;
		self.contentView.textColor = [UIColor grayColor];
	}
}

-(BOOL)becomeFirstResponder{
    return [_contentView becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    return [_contentView resignFirstResponder];
}

-(void)setMaxWordNumber:(int)maxWordNumber{
    _maxWordNumber = maxWordNumber;
    NSString *number = [NSString stringWithFormat:@"%d",_maxWordNumber - self.text.length];
    _tipsLabel.text = number;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _tipsLabel.frame = CGRectMake(10, CGRectGetHeight(self.bounds) - 20, CGRectGetWidth(self.bounds) - 10, 20);
    
    if (_wordNumberInBounds) {
        _contentView.frame = self.bounds;
    } else {
        _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(_tipsLabel.bounds));
    }
}

- (void)dealloc {
    [_contentView release];
    [_tipsLabel release];
    [_placeholder release];
    
    [super dealloc];
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [NSObject cancelPreviousPerformRequestsWithTarget:textView];
    
    if (_tipsLabel.text.intValue > _maxWordNumber) {
        return NO;
    }
    NSString *replacableText = [[textView.text substringWithRange:range] replaceOldString:@"\u2006" WithNewString:@""];
	
	if ([self.contentView.text isEqualToString:_placeholder] && [NSString isBlank:self.text]) {
		[self clearsText];
		self.contentView.textColor = [UIColor blackColor];
	}
    
    if ([replacableText isEqualToString:text]) {
        return YES;
    }
    if (range.length != 0) {
        if (replacableText.length >= text.length) {
            return YES;
        }
    }
    if ([_tipsLabel.text intValue] < text.length){
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{ 
    NSMutableString *str = [textView.text mutableCopy];
    _tipsLabel.text = [NSString stringWithFormat:@"%d",_maxWordNumber - [str replaceOldString:@"\u2006" WithNewString:@""].length];
    [str release];
	self.text = textView.text;
	if ([NSString isBlank:self.text]) {
		self.placeholder = _placeholder;
	}
}

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    self.tipsLabel.text = @"";
//    self.placeholder = @"";
//    self.contentView.text = @"";
//}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([NSString isBlank:_placeholder]) {
        return;
    }
    if (![self.contentView hasText]) {
		self.placeholder = _placeholder;
//        self.text = _placeholder;
//        self.contentView.textColor = [UIColor grayColor];
    }
}

@end

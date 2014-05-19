//
//  PBFlatButton.m
//  FlatUIlikeiOS7
//
//  Created by Piotr Bernad on 11.06.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "PBFlatButton.h"


@implementation PBFlatButton {
    UIColor *_backgroundColor;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self appearanceButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self appearanceButton];
    }
    return self;
}

- (void)appearanceButton {
    _backgroundColor = [UIColor clearColor];
    _mainColor = [[PBFlatSettings sharedInstance] mainColor];
    _secondColor = [[PBFlatSettings sharedInstance] secondColor];
    
    [self setBackgroundColor:_backgroundColor];
    [self setTitleColor:_mainColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.titleLabel setFont:[[PBFlatSettings sharedInstance] font]];
}

- (void)setHighlighted:(BOOL)highlighted {
        [super setHighlighted:highlighted];
    if (highlighted) {
        _mainColor = [UIColor colorWithWhite:1.000 alpha:1.000];
        _backgroundColor = [UIColor colorWithRed:0.587 green:0.229 blue:0.315 alpha:1.000];
        
       
    }else{
        _backgroundColor = [UIColor clearColor];
        _mainColor = [[PBFlatSettings sharedInstance] mainColor];
        _secondColor = [[PBFlatSettings sharedInstance] secondColor];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectInset(rect,1,1) cornerRadius: 1];
    [_backgroundColor setFill];
    [roundedRectanglePath fill];
    [_secondColor setStroke];
    roundedRectanglePath.lineWidth = 1;
  
    [roundedRectanglePath stroke];
}

@end

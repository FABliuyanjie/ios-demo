//
//  PBFlatSettings.m
//  FlatUIlikeiOS7
//
//  Created by Piotr Bernad on 11.06.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "PBFlatSettings.h"
#import "PBFlatSegmentedControl.h"

@implementation PBFlatSettings

+ (PBFlatSettings *)sharedInstance
{
    static dispatch_once_t once;
    static PBFlatSettings *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[PBFlatSettings alloc] init];
    });
 
    return sharedInstance;
}
- (id)init {
    self = [super init];
    if (self) {
        _mainColor = [UIColor blackColor];
        _backgroundColor = [UIColor whiteColor];
        _textFieldPlaceHolderColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        _secondColor = [UIColor colorWithWhite:0.779 alpha:1.000];
        _font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        _iconImageColor = [UIColor whiteColor];
    }
    return self;
}

- (void)navigationBarApperance {
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *_titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor],
                                    UITextAttributeTextShadowColor : [UIColor clearColor],
                                            UITextAttributeFont : [_font fontWithSize:20.0f]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:_titleTextAttributes];
    // remove shadow
    [[UINavigationBar appearance]setShadowImage:[UIImage imageWithColor:_textFieldPlaceHolderColor]];
}
@end

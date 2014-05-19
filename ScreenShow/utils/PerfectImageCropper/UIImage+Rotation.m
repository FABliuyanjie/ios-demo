//
//  UIImage+Rotation.m
//  PerfectImageCropper
//
//  Created by Jin Huang on 5/29/13.
//  Copyright (c) 2013 Jin Huang. All rights reserved.
//

#import "UIImage+Rotation.h"

extern CGFloat iDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
extern CGFloat iRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (Rotation)

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:iRadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(iDegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
  
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, iDegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;  
}

@end;

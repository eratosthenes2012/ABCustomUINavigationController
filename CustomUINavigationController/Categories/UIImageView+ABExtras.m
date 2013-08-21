//
//  UIImageView+ABExtras.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 8/8/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "UIImageView+ABExtras.h"
#import <QuartzCore/QuartzCore.h>
#import "UINavigationController+ABExtras.h"

@implementation UIImageView (ABExtras)

/* ME : cropRect's coordinates are based on self.superview's coordinateds */
- (UIImageView *) createCrop: (CGRect) crop
{
    /* ME: Creates a bitmap image using the data contained within a subregion of an existing bitmap image.
     Quartz performs these tasks to create the subimage:
     Adjusts the area specified by the rect parameter to integral bounds by calling the function CGRectIntegral.
     Intersects the result with a rectangle whose origin is (0,0) and size is equal to the size of the image specified by the image parameter.
     References the pixels within the resulting rectangle, treating the first pixel within the rectangle as the origin of the subimage.
     */
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.image.CGImage, crop);
    UIImageView *imageViewCropped = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    [imageViewCropped setFrame:crop];
    
    /* ME:  why imageViewCropped.frame.origin.y+self.frame.origin.y ? */
    [imageViewCropped setFrame:CGRectMake(imageViewCropped.frame.origin.x,
                                          imageViewCropped.frame.origin.y+self.frame.origin.y,
                                          imageViewCropped.frame.size.width,
                                          imageViewCropped.frame.size.height)];
    CGImageRelease(imageRef);
    return imageViewCropped;
}

- (UIView *)createView
{
    UIView *newView = [[UIView alloc] initWithFrame:self.frame];
    [self setTag:TAG_IMAGE_VIEW];
    [self setFrame:self.bounds];
    [newView addSubview:self];
    
    return newView;
}

@end

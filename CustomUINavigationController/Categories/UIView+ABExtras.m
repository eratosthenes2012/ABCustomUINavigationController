//
//  UIView+ABExtras.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 8/8/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "UIView+ABExtras.h"
#import "UINavigationController+ABExtras.h"

@implementation UIView (ABExtras)

- (CAGradientLayer *)addLinearGradientWithColor:(UIColor *)theColor transparentToOpaque:(BOOL)transparentToOpaque
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //the gradient layer must be positioned at the origin of the view
    CGRect gradientFrame = self.frame;
    gradientFrame.origin.x = 0;
    gradientFrame.origin.y = 0;
    gradient.frame = gradientFrame;
    
    //build the colors array for the gradient
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[theColor CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.9f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.6f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.4f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.3f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.1f] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       nil];
    
    //reverse the color array if needed
    if(transparentToOpaque) {
        colors = [[colors reverseObjectEnumerator] allObjects];
    }
    
    //apply the colors and the gradient to the view, startPoint: (0.5, 0.0), endPoint:(0.5, 1.0)
    gradient.colors = colors;
    
    [self.layer insertSublayer:gradient atIndex:[self.layer.sublayers count]];
    
    return gradient;
}

- (UIView *)addOpacityWithColor:(UIColor *)theColor
{
    UIView *shadowView = [[UIView alloc] initWithFrame:self.bounds];
    
    [shadowView setBackgroundColor:[theColor colorWithAlphaComponent:0.8]];
    
    [self addSubview:shadowView];
    
    return shadowView;
}

- (UIImageView *) imageInNavController: (UINavigationController *) navController
{   /* ME: first to consider: */
    [self.layer setContentsScale:[[UIScreen mainScreen] scale]];
    
    /* paras: size-- The size (measured in points) of the new bitmap context. 
     * discussion: 
     * The environment also uses the default coordinate system for UIKit views, where the origin is in the upper-left corner and the positive axes extend down and to the right of the origin. The supplied scale factor is also applied to the coordinate system and resulting images. The drawing environment is pushed onto the graphics context stack immediately.
     
     While the context created by this function is the current context, you can call the UIGraphicsGetImageFromCurrentImageContext function to retrieve an image object based on the current contents of the context. When you are done modifying the context, you must call the UIGraphicsEndImageContext function to clean up the bitmap drawing environment and remove the graphics context from the top of the context stack. You should not use the UIGraphicsPopContext function to remove this type of context from the stack.
     
     In most other respects, the graphics context created by this function behaves like any other graphics context. You can change the context by pushing and popping other graphics contexts. You can also get the bitmap context using the UIGraphicsGetCurrentContext function.
     */
    //ME:  convenient way to create a bitmap context, like defining a integer variable. 
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 1.0);
    /* ME: layer drawn onto context */
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationHigh);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *currentView = [[UIImageView alloc] initWithImage: img];
    
    //Fix the position to handle status bar and navigation bar
    float yPosition = [navController calculateYPosition];
    [currentView setFrame:CGRectMake(0, yPosition, currentView.frame.size.width, currentView.frame.size.height)];
    
    return currentView;
}

@end

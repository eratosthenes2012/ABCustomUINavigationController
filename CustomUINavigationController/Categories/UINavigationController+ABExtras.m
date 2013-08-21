//
//  UINavigationController+ABExtras.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 8/8/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "UINavigationController+ABExtras.h"

@implementation UINavigationController (ABExtras)

/* ME : height in portrait , then 对应变化后的 width in landscape ？  */
- (float) calculateYPosition
{
    float yPosition=0;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (!self.navigationBarHidden) {
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)){
            yPosition += self.navigationBar.frame.size.height;
        }else{
            yPosition += self.navigationBar.frame.size.width;
        }
    }
    
    if (![UIApplication sharedApplication].statusBarHidden){
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)){
            yPosition += [UIApplication sharedApplication].statusBarFrame.size.height;
        }else{
            yPosition += [UIApplication sharedApplication].statusBarFrame.size.width;
        }
    }
    
    return yPosition;
    
}

@end

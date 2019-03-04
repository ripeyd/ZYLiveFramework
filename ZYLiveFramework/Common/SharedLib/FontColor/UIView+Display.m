//
//  UIView+Display.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "UIView+Display.h"

@implementation UIView (Display)


- (void)addBlurEffect
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
}



@end

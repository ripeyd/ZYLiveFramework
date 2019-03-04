//
//  ZYBaseNavigationController.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYBaseNavigationController.h"

@interface ZYBaseNavigationController ()

@end

@implementation ZYBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController* ctrl = [super popViewControllerAnimated:animated];
    
    return ctrl;
}




@end

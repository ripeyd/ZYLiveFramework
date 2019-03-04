//
//  ZYLiveStreamInteractor.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamInteractor.h"

@implementation ZYLiveStreamInteractor

- (void)gotoHomeController{
    
    KC(self.context.presenter, ZYLiveStreamPresenterDeleagte, stopLikeAnimating);

    [self.baseController dismissViewControllerAnimated:YES completion:^{
        KCLog(@"退出直播间");
    }];
}
@end

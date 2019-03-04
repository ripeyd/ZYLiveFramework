//
//  ZYHomeInteractor.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYHomeInteractor.h"

@implementation ZYHomeInteractor

- (void)gotoLiveStream{
    
    [self.baseController presentViewController:[[ZYLiveStreamViewController alloc] init] animated:YES completion:^{
       
        KCLog(@"进入直播间");
    }];
    
    
}

@end

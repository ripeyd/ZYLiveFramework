//
//  ZYHomePresent.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYHomePresenter.h"
#import "ZYChannelProfile.h"
#import "ZYHomeAdapter.h"

@implementation ZYHomePresenter


- (void)loadDataWithAdapter:(ZYBaseAdapter *)adapter{
    //prepare test data

    for (int i = 0; i < 20; i ++) {
        ZYChannelProfile* channel = [ZYChannelProfile new];
        channel.ownerName       = @"Logic";
        channel.title           = @"中国制造、中国创造";
        channel.ownerLocation   = @"中国好声音";
        channel.userCount       = @(25000);
        
        if (i%3 == 0) {
            channel.ownerCover  = @"publicPicture";
        }else if (i%3 == 1){
            channel.ownerCover  = @"adance";
        }else{
            channel.ownerCover  = @"reverse";
        }
        [self.dataArray addObject:channel];
    }
    
    [adapter setAdapterArray:self.dataArray];
    
    KC(self.view, ZYHomePresentDelegate, reloadUIWithData);
}

#pragma mark - lazy

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

@end

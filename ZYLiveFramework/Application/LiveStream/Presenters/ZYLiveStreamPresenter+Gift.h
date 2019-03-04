//
//  ZYLiveStreamPresenter+Gift.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/24.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamPresenter.h"
#import "ZYLiveStreamChannelMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYLiveStreamPresenter (Gift)
- (void)prepareGiftQueue;
- (void)destroyGiftQueue;

- (void)onReceiveGiftMsg:(ZYLiveStreamChannelMessage*)gift;

@end

NS_ASSUME_NONNULL_END

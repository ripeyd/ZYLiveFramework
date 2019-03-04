//
//  ZYLiveStreamGiftView.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftChannelMessage;
@class ZYLiveStreamGiftBanner;

@interface ZYLiveStreamGiftView : UIView

- (void)initCustomView;

- (void)showGeneralGiftAnimation:(GiftChannelMessage*)giftMsg;
- (ZYLiveStreamGiftBanner *)getTopBanner;
- (ZYLiveStreamGiftBanner *)getBottomBanner;

- (BOOL)hasFreeSpace;


@end

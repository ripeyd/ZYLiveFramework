//
//  ZYLiveStreamGiftBanner.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLiveStreamGiftChannelMessage.h"

typedef void (^GiftBannerAnimationBlock)(int line);

@interface ZYLiveStreamGiftBanner : UIView

@property (nonatomic, strong) ZYLiveStreamGiftChannelMessage *currentGiftMsg;
@property (nonatomic, strong) ZYLiveStreamGiftChannelMessage *nextGiftMsg;

- (void)initWithGiftMsg:(ZYLiveStreamGiftChannelMessage*)msg showLine:(int)line;

- (void)showWithAnimationFinishBlock:(GiftBannerAnimationBlock)block;
- (void)playNumberAnimationWithCount:(int)count;
- (void)hide;

- (void)btnAvatarClicked;

- (BOOL)isHiding;

+ (CGFloat)bannerHeight;
+ (CGFloat)bannerWidth;

@end

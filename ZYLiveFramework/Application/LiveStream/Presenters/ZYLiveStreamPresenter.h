//
//  ZYLiveStreamPresenter.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYBasePresenter.h"

NS_ASSUME_NONNULL_BEGIN
@class MSWeakTimer;
@class ZYLiveStreamAdapter;
@class ZYLiveStreamGiftBanner;
@class ZYLiveStreamGiftChannelMessage;

@protocol ZYLiveStreamPresenterDeleagte <NSObject>

@optional
// 构建视图
- (void)buildLiveStreamViewWithAdapter:(ZYLiveStreamAdapter *)adpter;


- (ZYLiveStreamGiftBanner *)getTopBanner;
- (ZYLiveStreamGiftBanner *)getBottomBanner;
- (BOOL)hasFreeSpaceToPlayNormalGift;
- (void)playGiftAnimation:(ZYLiveStreamGiftChannelMessage *)giftMsg;
- (void)fireHeartWithColorId:(NSNumber *)colorId;


- (void)showGiftSelectionView:(BOOL)show;
- (void)showShareView:(BOOL)show;
- (void)showInputView:(BOOL)show;

- (void)startLikeAnimating;
- (void)stopLikeAnimating;
// 发送礼物
- (void)sendGiftWithIndex:(int)index;
- (void)didClickAvatarImageToQQKe;
// 返回首页
- (void)gotoHomeController;

// 键盘出现 or 消失
- (void)adjustTalkViewOnKeyboardHide:(NSNotification *)notification;
- (void)adjustTalkViewOnKeyboardShow:(NSNotification *)notification;

@end

@interface ZYLiveStreamPresenter : ZYBasePresenter
//for gift category
@property (nonatomic, strong) MSWeakTimer               *giftReceiveTimer;
@property (nonatomic, strong) NSMutableArray            *giftQueue;
@end

NS_ASSUME_NONNULL_END

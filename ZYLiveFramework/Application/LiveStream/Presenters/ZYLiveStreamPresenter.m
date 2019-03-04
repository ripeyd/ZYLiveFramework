//
//  ZYLiveStreamPresenter.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//


#import "DBConst.h"
#import "ZYLiveStreamChannelMessage.h"
#import "ZYLiveStreamGiftChannelMessage.h"
#import "ZYLiveStreamPresenter+Gift.h"
#import "ZYLiveStreamLikeChannelMessage.h"
#import "ZYServiceEventUntil.h"
#import "ZYLiveViewController.h"

@interface ZYLiveStreamPresenter ()
@property (nonatomic, strong) NSTimer*                              testTimer;
@property (nonatomic, strong) NSMutableDictionary*                  giftDic;

@end

@implementation ZYLiveStreamPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self observeTable:Table_ChannelMessage event:Event_RowInsert selector:@selector(detectTableChannelMessageInsert:)];
        
        [self prepareGiftQueue];
        
        self.giftDic = @{}.mutableCopy;
    }
    return self;
}

#pragma mark- detect db table changes

- (void)detectTableChannelMessageInsert:(id)data
{
    ZYLiveStreamChannelMessage* msg = data;
    if (msg == nil) {
        return;
    }
    // 播放礼物动画效果
    if (msg.msgtype.intValue == kChannelMsgType_Gift) {
        [self onReceiveGiftMsg:msg];
        return;
    }
    // 心心动画效果
    if (msg.msgtype.intValue == kChannelMsgType_Like) {
        ZYLiveStreamLikeChannelMessage *likeMsg = (ZYLiveStreamLikeChannelMessage *)msg;
        KC(self.context.view, ZYLiveStreamPresenterDeleagte, fireHeartWithColorId:likeMsg.colorId);
        return;
    }
}

static int tapACount = 0;
static int tapBCount = 0;

- (void)startLikeAnimating
{
    //test receive gift
    tapACount = 0;
    tapBCount = 0;
    self.testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTestTimerTimeout) userInfo:nil repeats:true];
}

- (void)stopLikeAnimating
{
    [self.testTimer invalidate];
    self.testTimer = nil;
}



- (void)onTestTimerTimeout
{
    //    //test gift
    //    GiftChannelMessage* channelMsg = [GiftChannelMessage new];
    //    channelMsg.msgtype = @(kChannelMsgType_Gift);
    //    channelMsg.giftType = GiftChannelMessage_Star;
    //
    //    static int uid = 0;
    //    uid = uid%2;
    //    uid++;
    //
    //    channelMsg.fromuid = @(uid);
    //    channelMsg.fromnickname = [NSString stringWithFormat:@"User %d", uid];
    //    if (uid == 0) {
    //        channelMsg.tapCount = tapACount++;
    //    }
    //    else
    //    {
    //        channelMsg.tapCount = tapBCount++;
    //    }
    //    [EServiceEventUtil postNotification:Table_ChannelMessage withEvent:Event_RowInsert withData:channelMsg];
    
    
    //test heart
    ZYLiveStreamLikeChannelMessage *likeMsg = [ZYLiveStreamLikeChannelMessage new];
    likeMsg.fromuid = @(0);
    
    static int colorId = 0;
    colorId ++;
    colorId = colorId % 6;
    likeMsg.colorId = @(colorId);
    
    [ZYServiceEventUntil postNotification:Table_ChannelMessage withEvent:Event_RowInsert withData:likeMsg];
}

- (void)sendGiftWithIndex:(int)index
{
    
    // 增删改查
    ZYLiveStreamGiftChannelMessage *channelMsg = [ZYLiveStreamGiftChannelMessage new];
    channelMsg.msgtype = @(kChannelMsgType_Gift);
    channelMsg.giftType = index;
    channelMsg.fromuid = @(_OwnerID);
    channelMsg.fromnickname = [NSString stringWithFormat:@"User %d", _OwnerID];
    
    int tap = 0;
    if ([_giftDic objectForKey:@(index).stringValue] == nil) {
        [_giftDic setObject:@(0) forKey:@(index).stringValue];
    }
    tap = [[_giftDic objectForKey:@(index).stringValue] intValue];
    tap ++;
    [_giftDic setObject:@(tap) forKey:@(index).stringValue];
    
    channelMsg.tapCount = tap;
  
    // UI  ---> 状态
    // 数据 ---> 视图
    // 视图 ---> 监听  ---> 改变UI
    [ZYServiceEventUntil postNotification:Table_ChannelMessage withEvent:Event_RowInsert withData:channelMsg];
}

- (void)didClickAvatarImageToQQKe{
    
    [self.baseController presentViewController:[ZYLiveViewController new] animated:YES completion:^{
        KCLog(@"打开直播间");
    }];
}

@end

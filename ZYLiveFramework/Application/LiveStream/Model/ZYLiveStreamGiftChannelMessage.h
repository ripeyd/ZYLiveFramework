//
//  ZYLiveStreamGiftChannelMessage.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamChannelMessage.h"


#define Notif_GiftBanner_ConsumedMsgs @"Notif_GiftBanner_ConsumedMsgs"

typedef enum : NSUInteger {
    GiftChannelMessage_Star = 1,
    GiftChannelMessage_Donut = 2,
    GiftChannelMessage_Banana = 3,
    GiftChannelMessage_Kiss = 4,
    GiftChannelMessage_Champagne = 5,
    GiftChannelMessage_Perfume = 6,
    GiftChannelMessage_Watch = 7,
    GiftChannelMessage_Car = 8,
    GiftChannelMessage_Unicorn = 9,
    GiftChannelMessage_Cupcake = 10,
    GiftChannelMessage_Lollipop = 11,
    GiftChannelMessage_Chocolates = 12,
    GiftChannelMessage_Handcuffs = 13,
    GiftChannelMessage_Shoes = 14,
    GiftChannelMessage_Handbag = 15,
    GiftChannelMessage_Ship = 16
} GiftChannelMessageGiftType;

typedef NS_ENUM(NSInteger, EGiftDiamondValue)
{
    EGiftDiamondValue_Star = 1,
    EGiftDiamondValue_Donut = 1,
    EGiftDiamondValue_Banana = 1,
    EGiftDiamondValue_Kiss = 4,
    EGiftDiamondValue_Champagne = 50,
    EGiftDiamondValue_Perfume = 120,
    EGiftDiamondValue_Watch = 500,
    EGiftDiamondValue_Car = 3000,
    EGiftDiamondValue_Unicorn = 1,
    EGiftDiamondValue_Cupcake = 1,
    EGiftDiamondValue_Lollipop = 1,
    EGiftDiamondValue_Chocolates = 2,
    EGiftDiamondValue_Handcuffs = 5,
    EGiftDiamondValue_Shoes = 150,
    EGiftDiamondValue_Handbag = 500,
    EGiftDiamondValue_Ship = 5000
};


@interface ZYLiveStreamGiftChannelMessage : ZYLiveStreamChannelMessage

@property (nonatomic, assign) GiftChannelMessageGiftType                 giftType;
@property (nonatomic, assign) BOOL isTap;
@property (nonatomic, assign) int tapCount;

- (NSString*)getGiftName;
- (UIImage*)getGiftImageForBarrage:(BOOL)forBarrage;

@end

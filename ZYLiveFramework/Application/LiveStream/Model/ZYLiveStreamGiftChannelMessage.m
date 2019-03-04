//
//  ZYLiveStreamGiftChannelMessage.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamGiftChannelMessage.h"

@implementation ZYLiveStreamGiftChannelMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgtype = @(kChannelMsgType_Gift);
    }
    return self;
}

- (BOOL)isSpecialGift
{
    if (_giftType == GiftChannelMessage_Car || _giftType == GiftChannelMessage_Ship) {
        return YES;
    }
    return NO;
}

- (TYTextContainer*)getRichTextContainer
{
    TYTextContainer *textContainer = [self createRichTextContainer];
    
    NSString* strName = @"Somebody";
    NSString* strGift = [self getGiftName];
    
    NSString* strCombined = [NSString stringWithFormat:@"%@ 送了 %@",strName,strGift];
   
    textContainer.text = strCombined;
    
    TYTextStorage* textStorage = nil;
    textStorage = [[TYTextStorage alloc] init];
    if (strCombined.length > 0) {
        textStorage.range = NSMakeRange(0, strCombined.length);
    }
    textStorage.textColor = [UIColor themeSubColor];
    textStorage.font = [self getContentFont];
    [textContainer addTextStorage:textStorage];
    
    textStorage = [[TYTextStorage alloc] init];
    if (strName.length > 0) {
        textStorage.range = [strCombined rangeOfString:strName];
    }
    textStorage.textColor = [UIColor colorWithHex:0xe4aa1e];
    textStorage.font = [self getNameFont];
    [textContainer addTextStorage:textStorage];
    [textContainer addLinkWithLinkData:strName linkColor:nil underLineStyle:kCTUnderlineStyleNone range:[strCombined rangeOfString:strName]];
    
    UIImage* giftImage = [self getGiftImageForBarrage:NO];
    
    CGSize giftSize = CGSizeMake(20, 20);
    if (_giftType == GiftChannelMessage_Car || _giftType == GiftChannelMessage_Ship) {
        giftSize = CGSizeMake(26, 20);
    }
    [textContainer appendText:@" "];
    [textContainer appendImage:giftImage size:giftSize alignment:TYDrawAlignmentCenter];
    
    return textContainer;
}

- (NSString*)getGiftName
{
    NSString* strGift = @"";
    
    switch (_giftType) {
        case GiftChannelMessage_Star:
            strGift = @"星星";
            break;
            
        default:
            break;
    }
    return strGift;
}

- (UIImage*)getGiftImageForBarrage:(BOOL)forBarrage
{
    NSString *imageName = @"";
    switch (_giftType) {
        case GiftChannelMessage_Star:
            if (forBarrage) {
                imageName = @"ic_shooting_star_barrage";
            }
            else
            {
                imageName = @"ic_shooting_star_message";
            }
            break;
            
        default:
            break;
    }
    UIImage *img = [UIImage imageNamed:imageName];
    return img;
}

- (NSNumber *)getDiamondValue
{
    switch (_giftType) {
        case GiftChannelMessage_Star:
            return @(EGiftDiamondValue_Star);
        default:
            break;
    }
    return @(EGiftDiamondValue_Star);
}

@end

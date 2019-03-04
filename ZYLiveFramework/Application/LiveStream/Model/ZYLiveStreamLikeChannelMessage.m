//
//  ZYLiveStreamLikeChannelMessage.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamLikeChannelMessage.h"


@implementation ZYLiveStreamLikeChannelMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgtype = @(kChannelMsgType_Like);
    }
    return self;
}

- (TYTextContainer*)getRichTextContainer {
    TYTextContainer *textContainer = [self createRichTextContainer];
    
    NSString* strName = @"User";
    NSString* strContent = self.content;
    
    textContainer.text = strContent;
    
    TYTextStorage* textStorage = nil;
    
    textStorage = [[TYTextStorage alloc] init];
    if (strContent.length > 0) {
        textStorage.range = NSMakeRange(0, strContent.length);
    }
    textStorage.textColor = [UIColor whiteColor];
    textStorage.font = [self getContentFont];
    [textContainer addTextStorage:textStorage];
    
    textStorage = [[TYTextStorage alloc] init];
    if (strName.length > 0) {
        textStorage.range = [strContent rangeOfString:strName];
    }
    textStorage.textColor = [UIColor colorWithHex:0xe4aa1e];
    textStorage.font = [self getNameFont];
    [textContainer addTextStorage:textStorage];
    [textContainer addLinkWithLinkData:strName linkColor:nil underLineStyle:kCTUnderlineStyleNone range:[strContent rangeOfString:strName]];
    
    [textContainer appendText:@" "];
    
    UIImage* giftImage = [[self class] getHeartImageByType:self.colorId.intValue];
    [textContainer appendImage:giftImage size:CGSizeMake(18, 18) alignment:TYDrawAlignmentTop];
    
    
    return textContainer;
}

+ (KCLiveStreamLikeChannelMessageColorType)getRandomHeartColor {
    int heartCount = KCLiveStreamLikeChannelMessageColorCount;
    int heartIndex = arc4random()%heartCount;
    return heartIndex;
}

+ (UIImage*)getHeartImageByType:(KCLiveStreamLikeChannelMessageColorType)type {
    UIImage* img = nil;
    
    int heartIndex = type;
    if (heartIndex == 0) {
        img = [UIImage imageNamed:@"ic_blueheart"];
    }
    else if(heartIndex == 1)
    {
        img = [UIImage imageNamed:@"ic_pinkheart"];
    }
    else if(heartIndex == 2)
    {
        img = [UIImage imageNamed:@"ic_greenheart"];
    }
    else if(heartIndex == 3)
    {
        img = [UIImage imageNamed:@"ic_orangeheart"];
    }
    else if(heartIndex == 4)
    {
        img = [UIImage imageNamed:@"ic_purpleheart"];
    }
    else if(heartIndex == 5)
    {
        img = [UIImage imageNamed:@"ic_yellowheart"];
    }
    
    return img;
}


@end

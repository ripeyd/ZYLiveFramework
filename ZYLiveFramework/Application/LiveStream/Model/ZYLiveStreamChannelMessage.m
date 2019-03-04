//
//  ZYLiveStreamChannelMessage.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamChannelMessage.h"

@implementation ZYLiveStreamChannelMessage

- (TYTextContainer*)createRichTextContainer {
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.lineBreakMode = kCTLineBreakByWordWrapping;
    textContainer.characterSpacing = 0;
    return textContainer;
}

- (UIFont*)getContentFont {
    return [UIFont fontOfSystemFontWithMediumSize:15];
}

- (UIFont*)getNameFont {
    return [UIFont fontOfSystemFontWithSemiBoldSize:15];
}


@end

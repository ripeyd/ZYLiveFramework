//
//  ZYLiveStreamGiftView.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamGiftView.h"
#import "ZYLiveStreamGiftBanner.h"
#import "ZYLiveStreamGiftChannelMessage.h"

@interface ZYLiveStreamGiftView ()
@property (nonatomic, strong) ZYLiveStreamGiftBanner *topBanner;
@property (nonatomic, strong) ZYLiveStreamGiftBanner *bottomBanner;

@end

@implementation ZYLiveStreamGiftView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor randomColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initCustomView {
	
}


#pragma mark - normal gifts
- (void)showGeneralGiftAnimation:(ZYLiveStreamGiftChannelMessage *)giftMsg {
    
    if (giftMsg.tapCount == 0) {
        return;
    }
    
    if ([self hasFreeSpace] == false) {
        return;
    }
    
    int bannerWidth = [ZYLiveStreamGiftBanner bannerWidth];
    int bannerHeight = [ZYLiveStreamGiftBanner bannerHeight];
    
    int bottomMargin = 80 + 300;
    int originY = SCREEN_HEIGHT - bottomMargin - bannerHeight;
    int padding = 20;
    int line = 2;
    
    if (_bottomBanner == nil) {
        //
    }
    else if(_topBanner == nil)
    {
        originY -= (padding + bannerHeight);
        line = 1;
    }
    
    ZYLiveStreamGiftBanner *giftBanner = [[ZYLiveStreamGiftBanner alloc] initWithFrame:CGRectMake(0, originY, bannerWidth, bannerHeight)];
    [self addSubview:giftBanner];
    [giftBanner initWithGiftMsg:giftMsg showLine:line];
    
    if (line == 1) {
        self.topBanner = giftBanner;
    }
    else if (line == 2)
    {
        self.bottomBanner = giftBanner;
    }
    
    [giftBanner showWithAnimationFinishBlock:^(int line) {
        
        if (line == 2) {
            self.bottomBanner = nil;
        }
        else if (line == 1)
        {
            self.topBanner = nil;
        }
        
    }];
    
}

- (ZYLiveStreamGiftBanner *)getTopBanner
{
    return _topBanner;
}

- (ZYLiveStreamGiftBanner *)getBottomBanner
{
    return _bottomBanner;
}

- (BOOL)hasFreeSpace
{
    return _topBanner == nil || _bottomBanner == nil;
}


@end

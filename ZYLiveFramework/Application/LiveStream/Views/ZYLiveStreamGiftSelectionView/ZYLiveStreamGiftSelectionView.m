//
//  ZYLiveStreamGiftSelectionView.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamGiftSelectionView.h"
#import "ZYLiveStreamGiftSelectionHolder.h"

@interface ZYLiveStreamGiftSelectionView ()
@property (nonatomic, strong) ZYLiveStreamGiftSelectionHolder*                 giftHolder;

@end

@implementation ZYLiveStreamGiftSelectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = false;
    }
    return self;
}

- (void)initCustomView {
    
    int height = 240 + 34;
    
    self.giftHolder = [ZYLiveStreamGiftSelectionHolder new];
    _giftHolder.frame = CGRectMake(0, self.bounds.size.height - height, SCREEN_WIDTH, height);
    [self addSubview:_giftHolder];
    _giftHolder.hidden = YES;
    [_giftHolder buildGifts];
    
    
    [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showGiftSelectionView:(BOOL)show {
    if (show) {
        [_giftHolder showWithAnimated:true];
    }
    else
    {
        [_giftHolder hideWithAnimated:true];
    }
    
    self.userInteractionEnabled = show;
}


- (void)hide
{
    [self showGiftSelectionView:false];
}

@end

//
//  ZYLiveStreamGiftSelectionHolder.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamGiftSelectionHolder.h"
#import <POP.h>
#import "UIView+Display.h"
#import "UIImageEX.h"

@interface ZYLiveStreamGiftSelectionHolder ()
@property (nonatomic, assign) CGPoint targetCenter;

@property (nonatomic, strong) UIScrollView *giftScrollView;
@property (nonatomic, strong) UIButton *btnSend;


@property (nonatomic, strong) NSMutableArray*                 giftItems;
@property (nonatomic, strong) UIButton*                       selectedItem;

@end

@implementation ZYLiveStreamGiftSelectionHolder

- (void)buildGifts
{
    if (!CGRectIsEmpty(self.frame)) {
        self.targetCenter = self.center;
    }
    
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.6];
    
    //blur effect
    [self addBlurEffect];
    
    CGRect frame = self.frame;
    frame.origin.y += self.bounds.size.height;
    self.frame = frame;
    
    
    self.giftItems = @[].mutableCopy;
    
    self.giftScrollView = [UIScrollView new];
    _giftScrollView.backgroundColor = [UIColor clearColor];
    _giftScrollView.pagingEnabled = YES;
    [self addSubview:_giftScrollView];
    _giftScrollView.frame = self.bounds;
    _giftScrollView.backgroundColor = [UIColor clearColor];
    _giftScrollView.showsHorizontalScrollIndicator = NO;
    
    int giftCount = 8;
    int giftNumPerPage = 8;
    for (int i = 0; i < giftCount; i ++) {
        int width = SCREEN_WIDTH / 4;
        int topMargin = 5;
        int height = 93;
        
        int x = SCREEN_WIDTH*(i/giftNumPerPage) + (i%4)*width;
        int y = ((i%giftNumPerPage)/4)*height;
        
        int gap = 30;
        
        width = MAX(width, height);
        height = MAX(height, width);
        
        CGRect displayFrame = CGRectMake(x, y+topMargin, width, height);
        displayFrame.origin.x += gap;
        displayFrame.origin.y += gap;
        displayFrame.size.width -= 2*gap;
        displayFrame.size.height -= 2*gap;
        
        UIButton *giftView = [[UIButton alloc] initWithFrame:displayFrame];
        [_giftScrollView addSubview:giftView];
        [giftView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"gift%d", i]] forState:UIControlStateNormal];
        [giftView addTarget:self action:@selector(btnGiftItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_giftItems addObject:giftView];
        giftView.tag = i;
        
        UILabel* lbExperience = [UILabel new];
        lbExperience.backgroundColor = [UIColor clearColor];
        lbExperience.font = [UIFont systemFontOfSize:10];
        lbExperience.textColor = [UIColor colorWithHex:0xffffff alpha:0.5];
        lbExperience.text = [NSString stringWithFormat:@"%d 钻石", i*100];
        lbExperience.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbExperience];
        
        displayFrame.origin.y = displayFrame.origin.y + displayFrame.size.height + 0;
        displayFrame.origin.x -= gap;
        displayFrame.size.width += 2*gap;
        lbExperience.frame = displayFrame;
    }
    
    
    self.btnSend = [UIButton new];
    [_btnSend addTarget:self action:@selector(buttonSendClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor themeSubColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    _btnSend.layer.cornerRadius = 4;
    _btnSend.layer.masksToBounds = YES;
    [self addSubview:_btnSend];
    
    int rightPadding = 10;
    int height = 36;
    int width = 80;
    [_btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-rightPadding);
        make.bottom.equalTo(self).offset(-6-25);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
}

- (void)showWithAnimated:(BOOL)animated
{
    if (animated) {
        
        CGFloat fromValue = _targetCenter.y + self.bounds.size.height;
        CGFloat toValue = _targetCenter.y;
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.springBounciness = 0;
        anim.fromValue = @(fromValue);
        anim.toValue = @(toValue);
        [self pop_addAnimation:anim forKey:@"xxx"];
        self.hidden = NO;
    }
    else
    {
        self.hidden = NO;
    }
}

- (void)hideWithAnimated:(BOOL)animated
{
    CGFloat toValue = _targetCenter.y + self.bounds.size.height;
    if (animated) {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.springBounciness = 0;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished)
        {
            self.hidden = YES;
        };
        anim.toValue = @(toValue);
        [self pop_addAnimation:anim forKey:@"xxx"];
    }
    else
    {
        CGPoint position = self.center;
        position.y = toValue;
        self.center = position;
        self.hidden = YES;
    }
}

- (void)buttonSendClicked:(id)sender
{
//    KC(self.context.view, IStreamView, showGiftSelectionView:false);
    // OC 消息转发
    if (_selectedItem) {
        KC(self.context.presenter, ZYLiveStreamPresenterDeleagte, sendGiftWithIndex:(int)_selectedItem.tag);
    }
}

- (void)btnGiftItemClick:(id)sender
{
    UIButton* clickedGift = sender;
    
    for (UIButton* btn in _giftItems) {
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 0;
    }
    
    clickedGift.layer.borderColor = [UIColor whiteColor].CGColor;
    clickedGift.layer.borderWidth = 2.0;
    
    _selectedItem = clickedGift;
}

@end

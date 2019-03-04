//
//  ZYLiveStreamShareHolder.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamShareHolder.h"
#import <POP.h>
#import "UIView+Display.h"

@interface ZYLiveStreamShareHolder ()
@property (nonatomic, assign) CGPoint targetCenter;

@property (nonatomic, strong) UIScrollView *shareScrollView;
@end

@implementation ZYLiveStreamShareHolder

- (void)buildShare
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
    
    
    self.shareScrollView = [UIScrollView new];
    _shareScrollView.backgroundColor = [UIColor clearColor];
    _shareScrollView.pagingEnabled = YES;
    [self addSubview:_shareScrollView];
    _shareScrollView.frame = self.bounds;
    _shareScrollView.backgroundColor = [UIColor clearColor];
    _shareScrollView.showsHorizontalScrollIndicator = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickShareImage)];
    
    NSArray* shareList = @[@"wechat", @"sina", @"qq"];
    
    int shareSize = 36;
    
    int marginY = self.bounds.size.height/2-shareSize/2;
    int gap = (SCREEN_WIDTH-3*shareSize)/4;
    int marginX = gap;
    
    for (int i = 0; i < shareList.count; i ++) {
        
        CGRect displayFrame = CGRectMake(marginX, marginY, shareSize, shareSize);
        UIImageView *shareImg = [[UIImageView alloc] initWithFrame:displayFrame];
        [_shareScrollView addSubview:shareImg];
        marginX += (shareSize + gap);
        shareImg.image = [UIImage imageNamed:shareList[i]];
        shareImg.userInteractionEnabled = YES;
        [shareImg addGestureRecognizer:tap];
    }
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

- (void)didClickShareImage{
    KC(self.context.presenter, ZYLiveStreamPresenterDeleagte, didClickAvatarImageToQQKe);

}


@end

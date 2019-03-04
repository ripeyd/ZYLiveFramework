
//
//  ZYLiveStreamBulletSwitch.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamBulletSwitch.h"

#import "UIColor+App.h"
#import "UIFont+App.h"

@interface ZYLiveStreamBulletSwitch ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *lbTitle;

@end

@implementation ZYLiveStreamBulletSwitch

- (void)buildViews
{
    self.layer.cornerRadius = 4;
    [self addTarget:self action:@selector(didClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    //titleView
    int padding = 2;
    int width = 45;
    int height = 32;
    self.titleView = [UIView new];
    _titleView.layer.cornerRadius = 4;
    [self addSubview:_titleView];
    _titleView.frame = CGRectMake(padding, padding, width, height);
    
    //lbTitle
    self.lbTitle = [UILabel new];
    _lbTitle.backgroundColor = [UIColor clearColor];
    _lbTitle.font = [UIFont fontOfSystemFontWithMediumSize:12];
    _lbTitle.text = @"弹幕";
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:_lbTitle];
    width = 40;
    height = 12;
    _lbTitle.frame = CGRectMake(0, 0, width, height);
    _lbTitle.center = _titleView.center;
    
    CGRect frame = _lbTitle.frame;
    frame.origin.y -= 2;
    frame.origin.x -= 2;
    _lbTitle.frame = frame;
    
    [self setSwitchStyleWithSelected:self.isSelected];
    
}

- (void)setSwitchStyleWithSelected:(BOOL)on
{
    _titleView.backgroundColor = [UIColor whiteColor];
    _lbTitle.textColor = [UIColor colorWithHex:0x747474];
    self.backgroundColor = [UIColor colorWithHex:0x888888];
    
    CGRect frame = [self getOffFrame];
    if (on) {
        _lbTitle.textColor = [UIColor themeSubColor];
        self.backgroundColor = [UIColor themeSubColor];
        
        frame = [self getOnFrame];
    }
    
    if (_titleView.frame.origin.x != frame.origin.x) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _titleView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (void)didClickSwitch:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    [self setSwitchStyleWithSelected:sender.isSelected];
    
    if (_switchDelegate) {
        [_switchDelegate didClickBulletSwitch];
    }
}

- (CGRect)getOnFrame
{
    int rightPadding = 2;
    CGRect frame = _titleView.frame;
    frame.origin.x = self.bounds.size.width - _titleView.bounds.size.width - rightPadding;
    return frame;
}

- (CGRect)getOffFrame
{
    int leftPadding = 2;
    CGRect frame = _titleView.frame;
    frame.origin.x = leftPadding;
    return frame;
}

@end

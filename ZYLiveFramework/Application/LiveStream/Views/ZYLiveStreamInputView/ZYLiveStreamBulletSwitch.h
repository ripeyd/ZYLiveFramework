//
//  ZYLiveStreamBulletSwitch.h
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCLiveStreamBulletSwitchDelegate <NSObject>

- (void)didClickBulletSwitch;
- (void)switchOnBullet;

@end


@interface ZYLiveStreamBulletSwitch : UIButton

@property (nonatomic, weak) id<KCLiveStreamBulletSwitchDelegate>                 switchDelegate;

- (void)buildViews;

@end

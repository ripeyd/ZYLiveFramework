//
//  ZYLiveStreamHeartView.h
//  PIXY
//
//  Created by gao feng on 16/5/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLiveStreamHeartView : UIView

- (void)fireHeart:(NSNumber*)colorId;
- (NSNumber*)getCurrentGuestColorId;

@end

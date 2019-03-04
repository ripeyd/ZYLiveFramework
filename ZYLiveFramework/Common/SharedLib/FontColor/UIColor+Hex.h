//
//  UIColor+Hex.h
//  PIXY
//
//  Created by 谢国碧 on 16/5/6.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;

+ (UIColor*)randomColor;

@end

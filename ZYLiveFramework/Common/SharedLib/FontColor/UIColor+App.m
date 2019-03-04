//
//  UIColor+App.m
//  PIXY
//
//  Created by 谢国碧 on 16/5/6.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "UIColor+App.h"
#import "UIColor+Hex.h"

#define kThemeColorBlue         0xFAFAFA
#define kThemeSubColorBlue      0xF24D5B
#define kTabBarSelectedColor    0x17181A
#define kTabBarNormalColor      0x26272B

@implementation UIColor (App)

+ (UIColor *)whiteBackgroundColor {
    return [UIColor colorWithHex:0xffffff];
}

+ (UIColor *)grayBackgroundColor {
    return [UIColor colorWithHex:0xF6F6F6];
}

+ (UIColor *)blueFontColor {
    return [UIColor colorWithHex:0x0079ff];
}

+ (UIColor *)blueButtonNormalColor {
    return [self blueFontColor];
}

+ (UIColor *)blueButtonHighlightColor {
    return [UIColor colorWithHex:0x0054b2];
}

+ (UIColor *)blueButtonDisableColor {
    return [UIColor colorWithHex:0xa6d0ff];
}

+ (UIColor *)blackFontColor {
    return [UIColor colorWithHex:0x333333];
}

+ (UIColor *)grayFontColor {
    return [UIColor colorWithHex:0x9B9B9B];
}

+ (UIColor *)grayLineColor {
    return [UIColor colorWithHex:0xe1e1e1];
}

+ (UIColor *)cellSelectedColor {
    return [UIColor colorWithHex:0xd9d9d9];
}

+ (UIColor *)sectionHeaderColor {
    return [self navBackgroundColor];
}

+ (UIColor *)navBackgroundColor {
    return [UIColor themeColor];
}

+ (UIColor *)navTintColor {
    return [self blackFontColor];
}

+ (UIColor *)tableViewBgColor
{
    return [UIColor colorWithHex:0xF6F6F6];
}

+ (UIColor *)themeColor
{
    return [UIColor colorWithHex:kThemeColorBlue];
}

+ (UIColor *)themeSubColor
{
    return [UIColor colorWithHex:kThemeSubColorBlue];
}

+ (UIColor *)tabBarSelectedColor
{
    return [UIColor colorWithHex:kTabBarSelectedColor];
}

+ (UIColor *)tabBarNormalColor
{
    return [UIColor colorWithHex:kTabBarNormalColor];
}


+ (UIColor *)notifyViewBgColor
{
    return [UIColor colorWithHex:0x7BD1EB];
}


@end

//
//  UIFont+App.h
//  Coco
//
//  Created by gaofeng on 13/6/14.
//  Copyright (c) 2014 music4kid Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFont (App)
{

}

+ (UIFont*)appFontOfSize:(CGFloat)size;
+ (UIFont*)boldAppFontOfSize:(CGFloat)size;
+ (UIFont *)fontOfHelveticaNeueLightWithSize:(CGFloat)size;
+ (UIFont *)fontOfHelveticaNeueRegularWithSize:(CGFloat)size;
+ (UIFont *)fontOfHelveticaNeueThinWithSize:(CGFloat)size;
+ (UIFont *)fontOfRobotoRegularWithSize:(CGFloat)size;
+ (UIFont *)fontOfHelveticaNeueMediumWithSize:(CGFloat)size;

+ (UIFont *)fontOfSystemFontWithMediumSize:(CGFloat)size;
+ (UIFont *)fontOfSystemFontWithSemiBoldSize:(CGFloat)size;
+ (UIFont *)fontOfSystemFontWithRegularSize:(CGFloat)size;
+ (UIFont *)fontOfSystemFontWithHeavySize:(CGFloat)size;

@end

//
//  ZYDaoEventUntil.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYDaoEventUntil : NSObject
+ (void)postNotification:(NSString*)tableName withEvent:(NSString*)rowEvent withData:(id)data;

@end

NS_ASSUME_NONNULL_END

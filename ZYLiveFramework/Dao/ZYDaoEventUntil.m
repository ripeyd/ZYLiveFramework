//
//  ZYDaoEventUntil.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYDaoEventUntil.h"

@implementation ZYDaoEventUntil

+ (void)postNotification:(NSString*)tableName withEvent:(NSString*)rowEvent withData:(id)data
{
    NSMutableDictionary *info = [NSMutableDictionary new];
    info[@"data"] = data;
    info[@"table"] = tableName;
    info[@"event"] = rowEvent;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:tableName object:nil userInfo:info];
    });
}

@end

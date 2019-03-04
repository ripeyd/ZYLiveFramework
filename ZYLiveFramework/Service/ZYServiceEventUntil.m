//
//  ZYServiceEventUntil.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYServiceEventUntil.h"
#import "ZYDaoEventUntil.h"

@implementation ZYServiceEventUntil
+ (void)postNotification:(NSString*)tableName withEvent:(NSString*)rowEvent withData:(id)data
{
    [ZYDaoEventUntil postNotification:tableName withEvent:rowEvent withData:data];
}

@end

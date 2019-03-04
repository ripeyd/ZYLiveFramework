//
//  ZYBaseViewController.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseViewController : ViewController

@property (nonatomic, strong) CDDContext    *rootContext;
- (void)configMVP:(NSString*)name;

@end

NS_ASSUME_NONNULL_END

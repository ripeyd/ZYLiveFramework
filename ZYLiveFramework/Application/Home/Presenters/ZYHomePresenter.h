//
//  ZYHomePresent.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYBaseAdapter;

@protocol ZYHomePresentDelegate <NSObject>

@optional
// 通过adapter建立我们的视图 : 主要是数据与视图的绑定
- (void)buildHomeView:(ZYBaseAdapter *)adapter;
// 加载数据
- (void)loadDataWithAdapter:(ZYBaseAdapter *)adapter;
// UI去刷新界面了
- (void)reloadUIWithData;
// 去直播间
- (void)gotoLiveStream;

@end

@interface ZYHomePresenter : CDDPresenter<ZYHomePresentDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

NS_ASSUME_NONNULL_END

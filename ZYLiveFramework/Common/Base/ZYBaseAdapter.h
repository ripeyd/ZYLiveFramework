//
//  ZYBaseAdapter.h
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZYBaseAdapterDelegate <NSObject>

@optional
- (void)didSelectCellData:(id)cellData;
- (void)deleteCellData:(id)cellData;
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol ZYBaseAdapterScrollDelegate <NSObject>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView ;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView ;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;

@end

@protocol ZYBaseAdapterPullUpDelegate <NSObject>

- (void)beginToRefresh;

@end

@interface ZYBaseAdapter : NSObject<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, weak) id<ZYBaseAdapterDelegate>   adapterDelegate;
@property (nonatomic, weak) id<ZYBaseAdapterScrollDelegate>              adapterScrollDelegate;
@property (nonatomic, weak) id<ZYBaseAdapterPullUpDelegate>              adapterPullUpDelegate;

- (float)getTableContentHeight;
- (void)refreshCellByData:(id)data tableView:(UITableView*)tableView;

- (NSArray*)getAdapterArray;
- (void)setAdapterArray:(NSArray*)arr;


@end

NS_ASSUME_NONNULL_END

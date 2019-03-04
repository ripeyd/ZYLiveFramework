//
//  ZYBaseAdapter.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYBaseAdapter.h"

@interface ZYBaseAdapter ()
@property (nonatomic, strong) NSMutableArray    *arr;
@end

@implementation ZYBaseAdapter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _arr = [NSMutableArray new];
    }
    return self;
}

- (NSArray*)getAdapterArray
{
    return _arr;
}

- (void)setAdapterArray:(NSArray*)arr
{
    [_arr removeAllObjects];
    [_arr addObjectsFromArray:arr];
}

- (float)getTableContentHeight
{
    return 0;
}

#pragma mark - 抽象方法
- (void)refreshCellByData:(id)data tableView:(UITableView*)tableView
{
    
}

#pragma mark    UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.getAdapterArray.count-1) {
        return [UITableViewCell new];
    }
    
    id cellData = [self.arr objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = NULL;
    CCSuppressPerformSelectorLeakWarning(
                                         cell = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"tableView:cellFor%@:", [cellData class]]) withObject:tableView withObject:cellData];);
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.getAdapterArray.count-1) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    id cellData = [self.arr objectAtIndex:indexPath.row];
    if (self.adapterDelegate) {
        if ([_adapterDelegate respondsToSelector:@selector(didSelectCellData:)]) {
            [_adapterDelegate didSelectCellData:cellData];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.getAdapterArray.count-1) {
        return;
    }
    
    if (self.adapterPullUpDelegate && [self.adapterPullUpDelegate respondsToSelector:@selector(beginToRefresh)]) {
        //倒数第三个 发送请求
        if (tableView.style == UITableViewStyleGrouped) {
            if (self.getAdapterArray.count >1) {
                NSArray *dataArray = [self.getAdapterArray objectAtIndex:0];
                if (dataArray.count > 4 && dataArray.count - 4 == indexPath.row) {
                    [self.adapterPullUpDelegate beginToRefresh];
                }
            }
        }
        else if (tableView.style == UITableViewStylePlain)
        {
            if (self.getAdapterArray.count > 4 && self.getAdapterArray.count - 4 == indexPath.row) {
                [self.adapterPullUpDelegate beginToRefresh];
            }
        }
    }
    if (self.adapterDelegate) {
        if ([_adapterDelegate respondsToSelector:@selector(willDisplayCell:forRowAtIndexPath:)]) {
            [_adapterDelegate willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.adapterScrollDelegate && [self.adapterScrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.adapterScrollDelegate scrollViewWillBeginDragging:scrollView];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.adapterScrollDelegate && [self.adapterScrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.adapterScrollDelegate scrollViewDidScroll:scrollView];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.adapterScrollDelegate && [self.adapterScrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:)]) {
        [self.adapterScrollDelegate scrollViewDidEndDragging:scrollView];
    }
}



@end

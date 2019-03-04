//
//  ZYHomeAdapter.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYHomeAdapter.h"
#import "ZYHomeTableViewCell.h"
#import "ZYChannelProfile.h"

@implementation ZYHomeAdapter

- (CGFloat)getCellHeight:(NSInteger)row
{
    CGFloat height = SCREEN_WIDTH*608/1080 + 54;
    ZYChannelProfile *model = [self.getAdapterArray objectAtIndex:row];
    if (model.title.length > 0) {
        CGSize titleSize = [model.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        if (titleSize.width > SCREEN_WIDTH - 35) {
            // 两行
            height +=67;
        }else{
            height +=50;
        }
    }else{
        height += 8;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getCellHeight:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.getAdapterArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYChannelProfile* liveModel = self.getAdapterArray[indexPath.row];
    
    UITableViewCell *cell = nil;
    
    CCSuppressPerformSelectorLeakWarning (
                                          cell = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"tableView:cellForKCChannelProfile:"]) withObject:tableView withObject:liveModel];
                                          );
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForKCChannelProfile:(id)model {
    NSString *cellIdentifier = NSStringFromSelector(_cmd);
    ZYHomeTableViewCell *cell = (ZYHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZYHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZYChannelProfile* liveModel = model;
    [cell setCellContent:liveModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    id model = self.getAdapterArray[indexPath.row];
    if (self.adapterDelegate && [self.adapterDelegate respondsToSelector:@selector(didSelectCellData:)]) {
        [self.adapterDelegate didSelectCellData:model];
    }
}

@end

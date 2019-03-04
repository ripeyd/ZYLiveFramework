//
//  ZYHomeViewController.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYHomeViewController.h"


@interface ZYHomeViewController ()<ZYBaseAdapterDelegate>
@property (nonatomic, strong) ZYHomeAdapter     *homeAdapter;
@end

@implementation ZYHomeViewController

- (void)viewDidLoad {

    [self configMVP:@"Home"];
    
    [super viewDidLoad];
    
    self.homeAdapter = [ZYHomeAdapter new];
    self.homeAdapter.adapterDelegate = self;
    
    KC(self.view, ZYHomePresentDelegate, buildHomeView:self.homeAdapter);
    KC(self.context.presenter,ZYHomePresentDelegate, loadDataWithAdapter:self.homeAdapter);

}

#pragma mark - ZYBaseAdapterDelegate
- (void)didSelectCellData:(id)cellData{
    
    KC(self.context.interactor, ZYHomePresentDelegate, gotoLiveStream);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

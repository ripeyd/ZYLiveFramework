//
//  ZYBaseViewController.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYBaseViewController.h"

@interface ZYBaseViewController ()
@property (nonatomic, strong) NSMutableDictionary   *eventMap;
@property (nonatomic, assign) BOOL                  mvpEnabled;
@end

@implementation ZYBaseViewController

- (void)configMVP:(NSString*)name
{
    self.mvpEnabled = true;
    
    self.rootContext = [[CDDContext alloc] init]; //strong
    self.context = self.rootContext; //weak
    
    //presentor
    Class presenterClass = NSClassFromString([NSString stringWithFormat:@"ZY%@Presenter", name]);
    if (presenterClass != NULL) {
        self.context.presenter = [presenterClass new];
        self.context.presenter.context = self.context;
    }
    
    //interactor
    Class interactorClass = NSClassFromString([NSString stringWithFormat:@"ZY%@Interactor", name]);
    if (interactorClass != NULL) {
        self.context.interactor = [interactorClass new];
        self.context.interactor.context = self.context;
    }
    
    //view
    Class viewClass = NSClassFromString([NSString stringWithFormat:@"ZY%@View", name]);
    if (viewClass != NULL) {
        self.context.view = [viewClass new];
        self.context.view.context = self.context;
    }
    
    //build relation
    self.context.presenter.view = self.context.view;
    self.context.presenter.baseController = self;
    
    self.context.interactor.baseController = self;
    
    self.context.view.presenter = self.context.presenter;
    self.context.view.interactor = self.context.interactor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.mvpEnabled) {
        self.context.view.frame = self.view.bounds;
        self.view = self.context.view;
    }
    
    KCLog(@"\n\nDid Load ViewController: %@\n\n", [self class]);
}

- (void)dealloc
{
    KCLog(@"\n\nReleasing ViewController: %@\n\n", [self class]);
    
    [Notif removeObserver:self];
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

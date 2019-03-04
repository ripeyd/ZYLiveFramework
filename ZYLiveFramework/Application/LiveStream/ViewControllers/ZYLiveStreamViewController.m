//
//  ZYLiveStreamViewController.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveStreamViewController.h"
#import "ZYLiveStreamAdapter.h"

@interface ZYLiveStreamViewController ()
@property (nonatomic, strong) ZYLiveStreamAdapter *adapter;

@end

@implementation ZYLiveStreamViewController

// MVC
// MVP


- (void)viewDidLoad {
    
    [self configMVP:@"LiveStream"];
    [super viewDidLoad];

    self.adapter = [ZYLiveStreamAdapter new];
    self.context.presenter.adapter = self.adapter;
    
    
    KC(self.view, ZYLiveStreamPresenterDeleagte, buildLiveStreamViewWithAdapter:self.adapter);
   
    KC(self.context.presenter, ZYLiveStreamPresenterDeleagte, startLikeAnimating);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:true];
    
    [Notif removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [Notif addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [Notif removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [Notif addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [Notif removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [Notif removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:false];
}


#pragma mark-    Keyboard Event
- (void)keyboardWillShow:(NSNotification *)notification {
    KC(self.view, ZYLiveStreamPresenterDeleagte, adjustTalkViewOnKeyboardShow:notification);
}

- (void)keyboardWillHide:(NSNotification *)notification {
    KC(self.view, ZYLiveStreamPresenterDeleagte, adjustTalkViewOnKeyboardHide:notification);
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

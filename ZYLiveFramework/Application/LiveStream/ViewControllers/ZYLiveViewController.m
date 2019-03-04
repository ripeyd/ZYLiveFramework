//
//  ZYLiveViewController.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/25.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYLiveViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+Display.h"
#import "UIImageEX.h"

@interface ZYLiveViewController ()
<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView   *webView;

@end

@implementation ZYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
//    self.webView.navigationDelegate = self;
//    self.webView.UIDelegate = self;
//    [self.view addSubview:self.webView];
//
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ke.qq.com/course/339445"]]];

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, SCREEN_HEIGHT-80, 60, 60)];
    [btn addTarget:self action:@selector(buttonCloseClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"走你" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor themeSubColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    btn.layer.cornerRadius = 30;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
}

- (void)buttonCloseClicked{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"回到直播间");
    }];
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

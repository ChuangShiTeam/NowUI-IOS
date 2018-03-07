//
//  ViewController.m
//  NowUI-IOS
//
//  Created by ZhongYongQiang on 06/03/2018.
//  Copyright © 2018 zhongyongqiang. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WXSDKInstance.h>

@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];

    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
    }
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview]; 
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //process failure
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        //process renderFinish
    };
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.js" withExtension:@"js"];
//    [_instance renderWithURL:url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
    NSString *path = [NSString stringWithFormat:@"http://h5.chuangshi.nowui.com/wawipet/dist/view/index.js"];
    [_instance renderWithURL:[NSURL URLWithString:path]];
    NSLog(@"123456");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_instance destroyInstance];
}


@end

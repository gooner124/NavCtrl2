//
//  WebPageViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "WebPageViewController.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([self.title isEqualToString:@"iPad"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/ipad-pro/"];
//    }else if ([self.title isEqualToString:@"iPod Touch"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/ipod-touch/"];
//    }else if ([self.title isEqualToString:@"iPhone"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/iphone/"];
//    }else if ([self.title isEqualToString:@"Galaxy S4"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/global/microsite/galaxys4/"];
//    }else if ([self.title isEqualToString:@"Galaxy Note"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
//    }else if ([self.title isEqualToString:@"Galaxy Tab"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/us/mobile/galaxy-tab/"];
//    }else if ([self.title isEqualToString:@"V10"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/mobile-phones/v10"];
//    }else if ([self.title isEqualToString:@"Vista 2"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2"];
//    }else if ([self.title isEqualToString:@"G4"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/mobile-phones/g4"];
//    }else if ([self.title isEqualToString:@"One A9"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-one-a9/"];
//    }else if ([self.title isEqualToString:@"Desire EYE"]) {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-desire-eye/"];
//    }else {
//        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-one-m9/"];
//    }
//    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    [webView loadRequest:[NSURLRequest requestWithURL:self.urlToLoad]];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    
    if ([self.title isEqualToString:@"iPad"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/ipad-pro/"];
    }else if ([self.title isEqualToString:@"iPod Touch"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/ipod-touch/"];
    }else if ([self.title isEqualToString:@"iPhone"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.apple.com/iphone/"];
    }else if ([self.title isEqualToString:@"Galaxy S4"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/global/microsite/galaxys4/"];
    }else if ([self.title isEqualToString:@"Galaxy Note"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
    }else if ([self.title isEqualToString:@"Galaxy Tab"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.samsung.com/us/mobile/galaxy-tab/"];
    }else if ([self.title isEqualToString:@"V10"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/mobile-phones/v10"];
    }else if ([self.title isEqualToString:@"Vista 2"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2"];
    }else if ([self.title isEqualToString:@"G4"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.lg.com/us/mobile-phones/g4"];
    }else if ([self.title isEqualToString:@"One A9"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-one-a9/"];
    }else if ([self.title isEqualToString:@"Desire EYE"]) {
        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-desire-eye/"];
    }else {
        self.urlToLoad = [NSURL URLWithString:@"https://www.htc.com/us/smartphones/htc-one-m9/"];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:self.urlToLoad]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

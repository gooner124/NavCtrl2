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
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds] configuration:theConfiguration];
    [theConfiguration release];
    wkWebView.navigationDelegate = self;
    
    [wkWebView loadRequest:[NSURLRequest requestWithURL:self.urlToLoad]];
    [self.view addSubview:wkWebView];
    [wkWebView release]; wkWebView = nil;
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

//
//  WebPageViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebPageViewController : UIViewController <WKNavigationDelegate>

@property (nonatomic, retain) NSURL *urlToLoad;

@end

//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebPageViewController;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *appleArray;
@property (nonatomic, retain) NSMutableArray *samsungArray;
@property (nonatomic, retain) NSMutableArray *lgArray;
@property (nonatomic, retain) NSMutableArray *htcArray;


@property (nonatomic, retain)  WebPageViewController *webPageViewController;


@end

//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"


@class WebPageViewController;
@class AddProductViewController;
@class EditProductViewController;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic,retain) Company *currentCompany;


@property (nonatomic, retain) WebPageViewController *webPageViewController;
@property (nonatomic, strong) AddProductViewController *addProductViewController;
@property (nonatomic, strong) EditProductViewController *editProductViewController;


@end

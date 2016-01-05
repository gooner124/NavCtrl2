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

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) Product *currentProduct;

@property (nonatomic, strong) WebPageViewController *webPageViewController;
@property (nonatomic, strong) AddProductViewController *addProductViewController;
@property (nonatomic, strong) EditProductViewController *editProductViewController;


@end

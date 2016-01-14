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
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) NSIndexPath *currentIndex;
@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, retain) Product *currentProduct;

@property (nonatomic, retain) WebPageViewController *webPageViewController;
@property (nonatomic, retain) AddProductViewController *addProductViewController;
@property (nonatomic, retain) EditProductViewController *editProductViewController;


@end

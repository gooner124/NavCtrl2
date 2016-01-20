//
//  ProductCollectionViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "CollectionViewCell.h"


@class WebPageViewController;
@class AddProductViewController;
@class EditProductViewController;

@interface ProductCollectionViewController : UICollectionViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) NSIndexPath *currentIndex;
@property (nonatomic, retain) Product *currentProduct;
@property (nonatomic, retain) CollectionViewCell *cell;

@property (nonatomic, retain) WebPageViewController *webPageViewController;
@property (nonatomic, retain) AddProductViewController *addProductViewController;
@property (nonatomic, retain) EditProductViewController *editProductViewController;

@end

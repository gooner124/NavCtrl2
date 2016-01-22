//
//  CompanyCollectionViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DataAccessObject.h"
#import "CollectionViewCell.h"
#import "ProductCollectionViewController.h"
#import "AddCompanyViewController.h"
#import "EditCompanyViewController.h"


@class ProductCollectionViewController;
@class AddCompanyViewController;
@class EditCompanyViewController;

@interface CompanyCollectionViewController : UICollectionViewController 

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSString *stockPriceUrl;
@property (nonatomic, retain) NSArray *stockPriceArray;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) NSIndexPath *currentIndex;
@property (nonatomic, retain) CollectionViewCell *cell;
@property (nonatomic) BOOL networkConnection;


@property (nonatomic, retain) ProductCollectionViewController *productCollectionViewController;
@property (nonatomic, retain) AddCompanyViewController *addCompanyViewController;
@property (nonatomic, retain) EditCompanyViewController *editCompanyViewController;

@end

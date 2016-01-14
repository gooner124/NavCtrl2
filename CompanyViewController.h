//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DataAccessObject.h"
#import "EditCompanyViewController.h"

@class ProductViewController;
@class AddCompanyViewController;
@class EditCompanyViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSString *stockPriceUrl;
@property (nonatomic, retain) NSArray *stockPriceArray;
@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) NSIndexPath *currentIndex;


@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;
@property (nonatomic, retain) AddCompanyViewController *addCompanyViewController;
@property (nonatomic, retain) EditCompanyViewController *editCompanyViewController;


@end

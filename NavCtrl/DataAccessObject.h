//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Company.h"
#import "Product.h"
#import "CompanyMO.h"
#import "ProductMO.h"

@interface DataAccessObject : NSObject {
    
//    NSManagedObjectContext *context;
//    NSManagedObjectModel *model;
    
}

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectModel *model;

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *MOCompanyList;

+ (id)sharedDAO;

-(NSString *) archivePath;

-(void)initModelContext;

-(void) loadAllCompanies;

-(void) reloadDataFromContext;

-(void)saveChanges;

-(void)undoChanges;

-(NSMutableArray*) getCompanies;

-(void)deleteCompany:(NSUInteger) index;

-(void)deleteProduct:(NSUInteger) index AndProduct:(Product*)product;

- (void)createCompany:(NSString*) companyName stockSymbol:(NSString *)stockSymbol companyLogo:(NSString*) companyLogo;

- (void)editCompany:(Company *)currentCompany WithCompanyName:(NSString *)newCompanyName stockSymbol:(NSString *)newStockSymbol companyLogo:(NSString*) newCompanyLogo AndCurrentIndex:(NSIndexPath*) currentIndex;

- (void)addProduct:(NSString*) productName WithProductWebsite:(NSString *)productWebsite WithProductLogo:(NSString*)productLogo ToCompany:(Company *)currentCompany WithCurrentIndex:(NSIndexPath*) currentIndexPath;

- (void)editProduct:(Product*)currentProduct WithProductName:(NSString*)newProductName WithProductWebsite:(NSString*)newProductWebsite WithProductLogo:(NSString*)newProductLogo WithCurrentIndex:(NSIndexPath*)currentIndex;

@end

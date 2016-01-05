//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Company.h"
#import "Product.h"

@interface DataAccessObject : NSObject

@property(nonatomic, strong) NSString *dbPathString;
@property (nonatomic, strong) NSMutableArray *companyList;


-(NSMutableArray*) getCompanies;
+ (id)sharedDAO;
-(void)createOrOpenDB;
-(NSMutableArray*) displayCompany;
-(void)deleteCompany:(Company*) company;
-(void)deleteProduct:(Product*) product;
- (void)createCompany:(NSString*) companyName stockSymbol:(NSString *)stockSymbol companyLogo:(NSString*) companyLogo;
- (void)editCompany:(Company *)currentCompany WithCompanyName:(NSString *)newCompanyName stockSymbol:(NSString *)newStockSymbol companyLogo:(NSString*) newCompanyLogo;
- (void)addProduct:(NSString*) productName WithProductWebsite:(NSString *)productWebsite WithProductLogo:(NSString*)productLogo ToCompany:(Company *)currentCompany;
- (void)editProduct:(Product*)currentProduct WithProductName:(NSString*)newProductName WithProductWebsite:(NSString*)newProductWebsite WithProductLogo:(NSString*)newProductLogo;

@end

//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DataAccessObject : NSObject

-(NSMutableArray*) getCompanies;
+ (id)sharedDAO;


- (void)createCompany:(NSString*) companyName;
- (void)editCompany:(Company *)currentCompany WithCompanyName:(NSString *)newCompanyName;
- (void)addProduct:(NSString*) productName WithProductWebsite:(NSString *)productWebsite ToCompany:(Company *)currentCompany;
- (void)editProduct:(Product*)currentProduct WithProductName:(NSString*)newProductName WithProductWebsite:(NSString*)newProductWebsite;

@end

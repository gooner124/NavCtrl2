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
- (void)addCompany:(Company*)company atIndex:(int)index;
- (void)deleteCompanyAtIndex:(int)index;
+ (id)sharedDAO;

@end

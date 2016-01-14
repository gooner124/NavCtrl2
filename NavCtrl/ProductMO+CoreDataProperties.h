//
//  ProductMO+CoreDataProperties.h
//  NavCtrl
//
//  Created by Matthew Paravati on 1/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProductMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *productName;
@property (nullable, nonatomic, retain) NSString *productLogo;
@property (nullable, nonatomic, retain) NSString *productUrl;
@property (nullable, nonatomic, retain) CompanyMO *company;

@end

NS_ASSUME_NONNULL_END

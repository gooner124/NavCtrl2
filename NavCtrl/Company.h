//
//  Company.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/8/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *stockPrice;
@property (nonatomic, retain) NSString *stockSymbol;
@property (nonatomic, retain) NSMutableArray *products;

@end

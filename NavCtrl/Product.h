//
//  Product.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/8/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, assign) int company_uniqueId;
@property(nonatomic,strong) NSString *productName;
@property(nonatomic,strong) NSString *productLOGO;
@property(nonatomic,strong) NSString *productURL;

@end

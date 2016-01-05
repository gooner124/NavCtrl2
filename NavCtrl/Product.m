//
//  Product.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/8/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)dealloc {
    
    [_productName release];
    [_productLOGO release];
    [_productURL release];
    
    [super dealloc];
}

@end

//
//  Company.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/8/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(void)dealloc {
    
    [_name release];
    [_stockPrice release];
    [_stockSymbol release];
    [_logo release];
    [_products release];
    
    [super dealloc];
}

@end

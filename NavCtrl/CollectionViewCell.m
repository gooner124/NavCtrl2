//
//  CollectionViewCell.m
//  NavCtrl
//
//  Created by Matthew Paravati on 1/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CollectionViewCell.h"


@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        
        self = [[arrayOfViews objectAtIndex:0 ]retain];
        
        
    }
    
    return self;
    
}



- (void)dealloc {
    [_stockPrice release];
    [_name release];
    [_logo release];
    [super dealloc];
}

@end

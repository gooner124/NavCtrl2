//
//  CollectionViewCell.h
//  NavCtrl
//
//  Created by Matthew Paravati on 1/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *stockPrice;
@property (retain, nonatomic) IBOutlet UIImageView *logo;

@end

//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Product.h"

@class ProductViewController;

@interface EditProductViewController : UIViewController

@property(nonatomic, retain)Product *currentProduct;
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productWebsite;
@property (retain, nonatomic) IBOutlet UITextField *productLogo;
@property (retain, nonatomic) IBOutlet UIButton *editProductButton;
@property(retain, nonatomic) ProductViewController *productViewController;
- (IBAction)editProductButtonPushed:(id)sender;

@end

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

@property(nonatomic, strong)Product *currentProduct;
@property (strong, nonatomic) IBOutlet UITextField *productName;
@property (strong, nonatomic) IBOutlet UITextField *productWebsite;
@property (strong, nonatomic) IBOutlet UITextField *productLogo;
@property (strong, nonatomic) IBOutlet UIButton *editProductButton;
@property(strong, nonatomic) ProductViewController *productViewController;
- (IBAction)editProductButtonPushed:(id)sender;

@end

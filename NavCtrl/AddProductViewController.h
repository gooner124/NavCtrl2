//
//  AddProductViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"
#import "AddCompanyViewController.h"

@interface AddProductViewController : UIViewController

@property(nonatomic, retain) Company *currentCompany;
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productWebsite;
@property (retain, nonatomic) IBOutlet UITextField *productLogo;
@property (retain, nonatomic) IBOutlet UIButton *addProductButton;
- (IBAction)addProductButtonPressed:(id)sender;

@end

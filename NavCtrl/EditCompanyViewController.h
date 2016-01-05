//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"

@interface EditCompanyViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *companyName;
@property (strong, nonatomic) IBOutlet UITextField *stockSymbol;
@property (strong, nonatomic) IBOutlet UITextField *companyLogo;
@property (strong, nonatomic) Company *currentCompany;

@property (strong, nonatomic) IBOutlet UIButton *editCompany;
- (IBAction)editCompanyButtonPressed:(id)sender;
@end

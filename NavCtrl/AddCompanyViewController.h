//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"


@interface AddCompanyViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *companyName;
@property (retain, nonatomic) IBOutlet UITextField *stockSymbol;
@property (retain, nonatomic) IBOutlet UIButton *createCompanyButton;

- (IBAction)createCompanyButtonPressed:(id)sender;
@end

//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"

@interface AddCompanyViewController ()

@end

@implementation AddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_companyName release];
    [_createCompanyButton release];
    [_stockSymbol release];
    [super dealloc];
}

#pragma mark create company 
- (IBAction)createCompanyButtonPressed:(id)sender {
    [[DataAccessObject sharedDAO] createCompany:self.companyName.text stockSymbol:self.stockSymbol.text];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end

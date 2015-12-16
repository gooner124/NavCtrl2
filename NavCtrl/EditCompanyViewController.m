//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"

@interface EditCompanyViewController ()

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.companyName.text = self.currentCompany.name;
    self.stockSymbol.text = self.currentCompany.stockSymbol;
    self.companyLogo.text = self.currentCompany.logo;
    
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
    [_editCompany release];
    [_companyName release];
    [_stockSymbol release];
    [_companyLogo release];
    [super dealloc];
}

- (IBAction)editCompanyButtonPressed:(id)sender {
    [[DataAccessObject sharedDAO] editCompany:self.currentCompany WithCompanyName:self.companyName.text stockSymbol:self.stockSymbol.text companyLogo:self.companyLogo.text];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

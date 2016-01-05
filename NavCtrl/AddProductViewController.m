//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

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

- (IBAction)addProductButtonPressed:(id)sender {
    [[DataAccessObject sharedDAO] addProduct:self.productName.text WithProductWebsite:self.productWebsite.text WithProductLogo:self.productLogo.text ToCompany:self.currentCompany];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealloc {
    [_productName release];
    [_productWebsite release];
    [_addProductButton release];
    [_productLogo release];
    [_currentCompany release];
    [super dealloc];
}

@end

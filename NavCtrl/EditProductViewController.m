//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"

@interface EditProductViewController ()

@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.productName.text = self.currentProduct.productName;
    self.productWebsite.text = self.currentProduct.productURL;
    self.productLogo.text = self.currentProduct.productLOGO;
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

- (IBAction)editProductButtonPushed:(id)sender {
    
    [[DataAccessObject sharedDAO] editProduct:self.currentProduct WithProductName:self.productName.text WithProductWebsite:self.productWebsite.text WithProductLogo:self.productLogo.text];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealloc {
    [_productName release];
    [_productWebsite release];
    [_editProductButton release];
    [_productLogo release];
    [_productViewController release];
    [_currentProduct release];
    [super dealloc];
}

@end

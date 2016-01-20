//
//  CompanyCollectionViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"


@interface CompanyCollectionViewController ()

@end

@implementation CompanyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    // Do any additional setup after loading the view.
    
    [[DataAccessObject sharedDAO] initModelContext];

    
    //display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Display an Add button in the navigation bar for this view controller.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self action:@selector(saveButtonPressed:)];
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                   target:self action:@selector(undoButtonPressed:)];
    self.navigationItem.rightBarButtonItems = @[saveButton, undoButton, addButton];
    [addButton release]; addButton = nil;
    [saveButton release]; saveButton = nil;
    [undoButton release]; undoButton = nil;
    
    //Initialize the long press gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detectLongPress:)];
    
    //Specify the duration for the long press
    longPressRecognizer.minimumPressDuration = 0.5;
    
    //Add the long press gesture to the view
    [self.view addGestureRecognizer:longPressRecognizer];
    [longPressRecognizer release]; longPressRecognizer = nil;
    
    //Initialize the swipe gesture recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detectSwipeGesture:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    [swipeRecognizer release]; swipeRecognizer = nil;
    
    self.title = @"Mobile device makers";
    
    [[DataAccessObject sharedDAO] loadAllCompanies];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.productCollectionViewController setCompanyList:nil];
    [self.productCollectionViewController setCurrentCompany:nil];
    [self.productCollectionViewController setCurrentProduct:nil];
    [self.productCollectionViewController setProducts:nil];
    [self.productCollectionViewController setCurrentIndex:nil];
    [self.editCompanyViewController setCurrentCompany:nil];
    [self.editCompanyViewController setCurrentIndex:nil];
    
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
    [self getStockPrices];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.companyList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    
    self.cell.name.text = self.currentCompany.name;
    self.cell.stockPrice.text = self.currentCompany.stockPrice;
    self.cell.logo.image = [UIImage imageNamed: self.currentCompany.logo];

    return self.cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionViewController *viewController = [[ProductCollectionViewController alloc] initWithNibName:@"ProductCollectionViewController" bundle:nil];
    self.productCollectionViewController = viewController;
    [viewController release]; viewController = nil;
    
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    self.productCollectionViewController.title = self.currentCompany.name;
    self.productCollectionViewController.currentCompany = self.currentCompany;
    NSIndexPath *index = indexPath;
    self.currentIndex = index;
    self.productCollectionViewController.currentIndex = self.currentIndex;
    self.productCollectionViewController.companyList = self.companyList;
    
    [self.navigationController
     pushViewController:self.productCollectionViewController
     animated:YES];
}

#pragma mark delete product

//need method here
-(void)detectSwipeGesture: (UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded && recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Company" message:@"Do you want to delete this company?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete Company"
                                                           style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [[DataAccessObject sharedDAO] deleteCompany:touchedIndexPath.row];
                                                                 [self.companyList removeObjectAtIndex:
                                                                  touchedIndexPath.row];
                                                                 [self.collectionView reloadData];
                                                             
                                                             }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                             handler:nil];
        [alertController addAction:actionDelete];
        [alertController addAction:actionCancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark Add Company

-(void)addButtonPressed: (id) sender {
    AddCompanyViewController *viewController = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    
    self.addCompanyViewController = viewController;
    [viewController release]; viewController = nil;
    self.addCompanyViewController.title = @"Add Company";
    
    [self.navigationController
     pushViewController:self.addCompanyViewController
     animated:YES];
    
}

#pragma mark edit company

-(void)detectLongPress:(UILongPressGestureRecognizer *) recognizer  {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        EditCompanyViewController *viewController = [[EditCompanyViewController alloc] initWithNibName:@"EditCompanyViewController" bundle:nil];
        self.editCompanyViewController = viewController;
        [viewController release]; viewController = nil;
        
        self.editCompanyViewController.title = @"Edit Company Information";
        self.currentCompany = [self.companyList objectAtIndex:[touchedIndexPath row]];
        self.currentIndex = touchedIndexPath;
        self.editCompanyViewController.currentCompany = self.currentCompany;
        self.editCompanyViewController.currentIndex = self.currentIndex;
        // Push the view controller.
        [self.navigationController pushViewController:self.editCompanyViewController animated:YES];
    }
    
}

#pragma mark get stock prices

-(void) getStockPrices {
    NSString *stockURL = @"http://finance.yahoo.com/d/quotes.csv?s=";
    for (Company *company in self.companyList) {
        NSString *symbol = company.stockSymbol;
        
        stockURL = [stockURL stringByAppendingString:symbol];
        stockURL = [stockURL stringByAppendingString:@"+"];
    }
    
    //NSURLSession to get stock prices of companies
    NSString *formatURL = @"&f=a";
    stockURL = [stockURL stringByAppendingString:formatURL];
    
    
    self.stockPriceUrl = stockURL;
    NSURL *url = [NSURL URLWithString:self.stockPriceUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //Convert csv to string
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (data == nil) {
            NSLog(@"Error storing --- data is nil");
            NSLog(@"Domain: %@", error.domain);
            NSLog(@"Error Code: %ld", (long)error.code);
            NSLog(@"Description: %@", [error localizedDescription]);
            NSLog(@"Reason: %@", [error localizedFailureReason]);
            NSLog(@"Company  Updated");
            [dataString release]; dataString = nil;
            
        }else {
            NSArray *companyAndStockPrices = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            [dataString release]; dataString = nil;
            
            self.stockPriceArray = companyAndStockPrices;
            int i = 0;
            for (Company *company in self.companyList) {
                company.stockPrice = self.stockPriceArray[i];
                i++;
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        
    }];
    [dataTask resume];
    [self.collectionView reloadData];
}

#pragma mark save button
-(void)saveButtonPressed: (id) sender {
    
    [[DataAccessObject sharedDAO] saveChanges];
}

#pragma mark undo button
-(void)undoButtonPressed: (id)sender {
    [[DataAccessObject sharedDAO] undoChanges];
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
    [self getStockPrices];
    [self.collectionView reloadData];
    
}

#pragma mark memory management


- (void)dealloc {
    [_companyList release];
    [_stockPriceArray release];
    [_stockPriceUrl release];
    [_cell release];
    [_currentCompany release];
    
    [_productCollectionViewController release];
    [_addCompanyViewController release];
    [_editCompanyViewController release];
    
    [super dealloc];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/
 
/*
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

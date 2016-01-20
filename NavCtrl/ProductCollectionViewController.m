//
//  ProductCollectionViewController.m
//  NavCtrl
//
//  Created by Matthew Paravati on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewController.h"
#import "CompanyCollectionViewController.h"
#import "WebPageViewController.h"
#import "EditProductViewController.h"
#import "AddProductViewController.h"

@interface ProductCollectionViewController ()

@end

@implementation ProductCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes

    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    // Do any additional setup after loading the view.
    
    //Create an Add button in the navigation bar for this view controller.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self action:@selector(saveButtonPressed:)];
    
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                   target:self action:@selector(undoButtonPressed:)];
    //Display the add and edit button on the right of the navigation bar
    self.navigationItem.rightBarButtonItems = @[saveButton, undoButton, addButton, self.editButtonItem];
    [addButton release]; addButton = nil;
    
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
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.addProductViewController setCurrentCompany:nil];
    [self.addProductViewController setCurrentIndex:nil];
    [self.editProductViewController setCurrentProduct:nil];
    [self.editProductViewController setCurrentIndex:nil];
    
    self.products = self.currentCompany.products;
    [self.collectionView reloadData];

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

#pragma mark awake from Nib
//- (void) awakeFromNib{
//    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: reuseIdentifier];
//}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.products count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    self.cell.name.text = [[self.products objectAtIndex:[indexPath row]] productName];
    self.cell.logo.image = [UIImage imageNamed:[[self.products objectAtIndex:[indexPath row]] productLOGO]];

    
    return self.cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Create the next view controller.
    WebPageViewController *viewController = [[WebPageViewController alloc] initWithNibName:@"WebPage" bundle:nil];
    self.webPageViewController = viewController;
    [viewController release]; viewController = nil;
    
    // Pass the selected object to the new view controller.
    self.webPageViewController.title = [[self.products objectAtIndex:[indexPath row]] productName];
    NSURL *url = [NSURL URLWithString:[[self.products objectAtIndex:[indexPath row]] productURL]];
    self.webPageViewController.urlToLoad = url;
    
    
    // Push the view controller.
    [self.navigationController pushViewController:self.webPageViewController animated:YES];
}

#pragma mark delete product

-(void)detectSwipeGesture: (UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded && recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Product" message:@"Do you want to delete this product?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete Product"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 self.currentProduct = [self.currentCompany.products objectAtIndex:touchedIndexPath.row];
                                                                 [[DataAccessObject sharedDAO] deleteProduct:self.currentIndex.row AndProduct:self.currentProduct];
                                                                 [self.currentCompany.products removeObjectAtIndex:
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

#pragma mark add product
-(void) addButtonPressed: (id) sender {
    AddProductViewController *viewController = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    self.addProductViewController = viewController;
    [viewController release]; viewController = nil;
    
    self.addProductViewController.title = @"Add Product";
    self.addProductViewController.currentCompany = self.currentCompany;
    self.addProductViewController.currentIndex = self.currentIndex;
    
    [self.navigationController
     pushViewController:self.addProductViewController
     animated:YES];
    
}

#pragma mark edit product

-(void)detectLongPress:(UILongPressGestureRecognizer *) recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        
        EditProductViewController *viewController = [[EditProductViewController alloc] initWithNibName:@"EditProductViewController" bundle:nil];
        self.editProductViewController = viewController;
        [viewController release]; viewController = nil;
        
        self.editProductViewController.title = @"Edit Product Information";
        self.currentProduct = [self.currentCompany.products objectAtIndex:[touchedIndexPath row]];
        self.editProductViewController.currentProduct = self.currentProduct;
        self.editProductViewController.currentIndex = self.currentIndex;
        // Push the view controller.
        [self.navigationController pushViewController:self.editProductViewController animated:YES];
    }
}

#pragma mark save button

-(void)saveButtonPressed: (id) sender {
    
    [[DataAccessObject sharedDAO] saveChanges];
}

#pragma mark undo button
-(void)undoButtonPressed: (id)sender {
    [[DataAccessObject sharedDAO] undoChanges];
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
    self.currentCompany = [self.companyList objectAtIndex:self.currentIndex.row];
    self.products = self.currentCompany.products;
    [self.collectionView reloadData];
    
}

- (void)dealloc {
    [_products release];
    [_currentCompany release];
    [_currentProduct release];
    [_cell release];
    [_webPageViewController release];
    [_editProductViewController release];
    [_addProductViewController release];
    
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
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

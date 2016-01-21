//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebPageViewController.h"
#import "CompanyViewController.h"
#import "EditProductViewController.h"
#import "AddProductViewController.h"

static NSString * const BaseURLString = @"http://";

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.addProductViewController setCurrentCompany:nil];
    [self.addProductViewController setCurrentIndex:nil];
    [self.editProductViewController setCurrentProduct:nil];
    [self.editProductViewController setCurrentIndex:nil];

    self.products = self.currentCompany.products;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (self.cell == nil) {
        UITableViewCell *tempCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        self.cell = tempCell;
        [tempCell release]; tempCell = nil;
    }
    // Configure the cell...
    self.cell.textLabel.text = [[self.products objectAtIndex:[indexPath row]] productName];
    UIImage *image= [UIImage imageNamed:[[self.products objectAtIndex:[indexPath row]] productLOGO]];
    self.cell.imageView.image = image;
    return self.cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Delete product from database
        self.currentProduct = [self.currentCompany.products objectAtIndex:indexPath.row];
        [[DataAccessObject sharedDAO] deleteProduct: self.currentIndex.row AndProduct:self.currentProduct];
        
        // Delete the row from the data source
        [self.products removeObjectAtIndex: indexPath.row ];
        [tableView reloadData];
    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    self.currentProduct = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:self.currentProduct atIndex:toIndexPath.row];

}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

 //In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    WebPageViewController *viewController = [[WebPageViewController alloc] initWithNibName:@"WebPage" bundle:nil];
    self.webPageViewController = viewController;
    [viewController release]; viewController = nil;

    // Pass the selected object to the new view controller.    
    self.webPageViewController.title = [[self.products objectAtIndex:[indexPath row]] productName];
    
    NSString *stringURL = [NSString stringWithString:BaseURLString];
    NSString *prodURL = [[self.products objectAtIndex:[indexPath row]] productURL];
    stringURL = [stringURL stringByAppendingString: prodURL];
    
    NSURL *url = [NSURL URLWithString: stringURL];
    self.webPageViewController.urlToLoad = url;
    
    
    // Push the view controller.
    [self.navigationController pushViewController:self.webPageViewController animated:YES];
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
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath *touchedIndexPath = [self.tableView indexPathForRowAtPoint:location];
        
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
    [self.tableView reloadData];
    
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


@end

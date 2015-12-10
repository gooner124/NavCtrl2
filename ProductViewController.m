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
    //Display the add and edit button on the right of the navigation bar
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, addButton];
    
    //Initialize the long press gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detectLongPress:)];
    
    //Specify the duration for the long press
    longPressRecognizer.minimumPressDuration = 0.5;
    
    //Add the long press gesture to the view
    [self.view addGestureRecognizer:longPressRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.products = self.currentCompany.products;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[self.products objectAtIndex:[indexPath row]] productName];
    UIImage *image= [UIImage imageNamed:[[self.products objectAtIndex:[indexPath row]] productLOGO]];
    cell.imageView.image = image;
    return cell;
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
    Product *currentProduct = [[Product alloc] init];
    currentProduct = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:currentProduct atIndex:toIndexPath.row];

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
    self.webPageViewController = [[WebPageViewController alloc] initWithNibName:@"WebPage" bundle:nil];

    // Pass the selected object to the new view controller.    
    self.webPageViewController.title = [[self.products objectAtIndex:[indexPath row]] productName];
    NSURL *url = [NSURL URLWithString:[[self.products objectAtIndex:[indexPath row]] productURL]];
    self.webPageViewController.urlToLoad = url;
    
    
    // Push the view controller.
    [self.navigationController pushViewController:self.webPageViewController animated:YES];
}


#pragma mark add product
-(void) addButtonPressed: (id) sender {
    self.addProductViewController = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    
    self.addProductViewController.title = @"Add Product";
    self.addProductViewController.currentCompany = self.currentCompany;
    
    [self.navigationController
     pushViewController:self.addProductViewController
     animated:YES];
    
}

#pragma mark edit product

-(void)detectLongPress:(UILongPressGestureRecognizer *) recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath *touchedIndexPath = [self.tableView indexPathForRowAtPoint:location];
        
        self.editProductViewController = [[EditProductViewController alloc] initWithNibName:@"EditProductViewController" bundle:nil];
        
        self.editProductViewController.title = @"Edit Product Information";
        Product *product = [[Product alloc] init];
        product = [self.currentCompany.products objectAtIndex:[touchedIndexPath row]];
        self.editProductViewController.currentProduct = product;
        // Push the view controller.
        [self.navigationController pushViewController:self.editProductViewController animated:YES];
    }
}

- (void)dealloc {
    [self.webPageViewController release];
    [super dealloc];
}


@end

//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "AddCompanyViewController.h"
#import "EditCompanyViewController.h"


@interface CompanyViewController ()

@end

@implementation CompanyViewController

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
    [[DataAccessObject sharedDAO] initModelContext];
    
    //preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
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
    
    self.title = @"Mobile device makers";
    
    [[DataAccessObject sharedDAO] loadAllCompanies];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.productViewController setCompanyList:nil];
    [self.productViewController setCurrentCompany:nil];
    [self.productViewController setCurrentProduct:nil];
    [self.productViewController setProducts:nil];
    [self.productViewController setCurrentIndex:nil];
    [self.editCompanyViewController setCurrentCompany:nil];
    [self.editCompanyViewController setCurrentIndex:nil];
    
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
    [self getStockPrices];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (self.cell == nil) {
        
        UITableViewCell *tempCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        self.cell = tempCell;
        [tempCell release]; tempCell = nil;
    }
    
    // Configure the cell...
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];

    self.cell.textLabel.text = self.currentCompany.name;
    self.cell.imageView.image = [UIImage imageNamed:self.currentCompany.logo];
    self.cell.detailTextLabel.text = self.currentCompany.stockPrice;
    
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Delete From Database

        [[DataAccessObject sharedDAO] deleteCompany:indexPath.row];
        
        // Delete the row from the data source
        [self.companyList removeObjectAtIndex: indexPath.row];
        
        [tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    self.currentCompany = [self.companyList objectAtIndex:fromIndexPath.row];
    
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:self.currentCompany atIndex:toIndexPath.row];


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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    self.productViewController.title = self.currentCompany.name;
    self.productViewController.currentCompany = self.currentCompany;
    NSIndexPath *index = indexPath;
    self.currentIndex = index;
    self.productViewController.currentIndex = self.currentIndex;
    self.productViewController.companyList = self.companyList;
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];

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
        
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath *touchedIndexPath = [self.tableView indexPathForRowAtPoint:location];
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
                [self.tableView reloadData];
            });
        }
        
    }];
    [dataTask resume];
    [self.tableView reloadData];
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
    [self.tableView reloadData];

}

#pragma mark memory management


- (void)dealloc {
    [_companyList release];
    [_stockPriceArray release];
    [_stockPriceUrl release];
    [_cell release];
    [_currentCompany release];
    
    [_productViewController release];
    [_addCompanyViewController release];
    [_editCompanyViewController release];
    
    [super dealloc];
}
@end









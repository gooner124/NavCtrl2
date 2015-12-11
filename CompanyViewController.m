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

    //preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    //display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Display an Add button in the navigation bar for this view controller.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;

    //Initialize the long press gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detectLongPress:)];
    
    //Specify the duration for the long press
    longPressRecognizer.minimumPressDuration = 0.5;
    
    //Add the long press gesture to the view
    [self.view addGestureRecognizer:longPressRecognizer];
    
    self.title = @"Mobile device makers";

    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
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
        NSArray *companyAndStockPrices = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        self.stockPriceArray = companyAndStockPrices;
        int i = 0;
        for (Company *company in self.companyList) {
            company.stockPrice = self.stockPriceArray[i];
            i++;
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
    [self.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = company.name;
    cell.imageView.image = [UIImage imageNamed:company.logo];
    cell.detailTextLabel.text = company.stockPrice;
    
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
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
    Company *company = [[Company alloc] init];
    company = [self.companyList objectAtIndex:fromIndexPath.row];
    
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:company atIndex:toIndexPath.row];
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
    Company *company = [[Company alloc] init];
    company = [self.companyList objectAtIndex:[indexPath row]];
    self.productViewController.title = company.name;
    self.productViewController.currentCompany = company;
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}

#pragma mark Add Company

-(void)addButtonPressed: (id) sender {
    self.addCompanyViewController = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    
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
        self.editCompanyViewController = [[EditCompanyViewController alloc] initWithNibName:@"EditCompanyViewController" bundle:nil];
        
        self.editCompanyViewController.title = @"Edit Company Information";
        Company *company = [[Company alloc] init];
        company = [self.companyList objectAtIndex:[touchedIndexPath row]];
        self.editCompanyViewController.currentCompany = company;
        // Push the view controller.
        [self.navigationController pushViewController:self.editCompanyViewController animated:YES];
    }

}



//- (void)dealloc {
//    [super dealloc];
//}
@end

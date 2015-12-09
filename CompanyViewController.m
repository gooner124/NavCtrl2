//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"


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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Apple company
//    Company *apple = [[Company alloc] init];
//    apple.name = @"Apple mobile devices";
//    apple.logo = @"apple logo.tiff";
//    
//    // Apple Products
//    Product *ipad = [[Product alloc] init];
//    ipad.productName = @"iPad";
//    ipad.productLOGO = @"iPad_logo.jpeg";
//    ipad.productURL = @"https://www.apple.com/ipad-pro/";
//    
//    Product *ipod = [[Product alloc] init];
//    ipod.productName = @"iPod";
//    ipod.productLOGO = @"iPod_touch_logo.jpeg";
//    ipod.productURL = @"https://www.apple.com/ipod-touch/";
//    
//    Product *iphone = [[Product alloc] init];
//    iphone.productName = @"iPhone";
//    iphone.productLOGO = @"iPhone_logo.png";
//    iphone.productURL = @"https://www.apple.com/iphone";
//    
//    apple.products = [[NSMutableArray alloc] initWithObjects: ipad, ipod, iphone, nil];
//    
//    //Samsung company
//    Company *samsung = [[Company alloc] init] ;
//    samsung.name = @"Samsung mobile devices";
//    samsung.logo = @"Samsung_Logo.png";
//    
//    //Samsung products
//    Product *galaxyS4 = [[Product alloc] init];
//    galaxyS4.productName = @"Galaxy S4";
//    galaxyS4.productLOGO = @"S4_logo.png";
//    galaxyS4.productURL = @"https://www.samsung.com/global/microsite/galaxys4/";
//    
//    Product *galaxyNote = [[Product alloc] init];
//    galaxyNote.productName = @"Galaxy Note";
//    galaxyNote.productLOGO = @"Note_logo.png";
//    galaxyNote.productURL = @"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
//    
//    Product *galaxyTab = [[Product alloc] init];
//    galaxyTab.productName = @"Galaxy Tab";
//    galaxyTab.productLOGO = @"tab_logo.jpeg";
//    galaxyTab.productURL = @"https://www.samsung.com/us/mobile/galaxy-tab/";
//    
//    samsung.products = [[NSMutableArray alloc] initWithObjects: galaxyS4, galaxyNote, galaxyTab, nil];
//    
//    //LG company
//    Company *lg = [[Company alloc] init];
//    lg.name = @"LG mobile devices";
//    lg.logo = @"lg logo.jpg";
//    
//    //LG products
//    Product *v10 = [[Product alloc] init];
//    v10.productName = @"V10";
//    v10.productLOGO = @"V10_pic.jpeg";
//    v10.productURL = @"https://www.lg.com/us/mobile-phones/v10";
//    
//    Product *vista2 = [[Product alloc] init];
//    vista2.productName = @"Vista 2";
//    vista2.productLOGO = @"vista2_pic.jpeg";
//    vista2.productURL = @"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2";
//    
//    Product *g4 = [[Product alloc] init];
//    g4.productName = @"G4";
//    g4.productLOGO = @"g4_pic.jpeg";
//    g4.productURL = @"https://www.lg.com/us/mobile-phones/g4";
//    
//    lg.products = [[NSMutableArray alloc] initWithObjects: v10, vista2, g4, nil];
//    
//    //HTC company
//    Company *htc = [[Company alloc] init];
//    htc.name = @"HTC mobile devices";
//    htc.logo =  @"htc_logo.jpg";
//    
//    //HTC products
//    Product *oneA9 = [[Product alloc] init];
//    oneA9.productName = @"One A9";
//    oneA9.productLOGO = @"One_A9_pic.jpeg";
//    oneA9.productURL = @"https://www.htc.com/us/smartphones/htc-one-a9/";
//    
//    Product *desireEye = [[Product alloc] init];
//    desireEye.productName = @"Desire EYE";
//    desireEye.productLOGO = @"Desire_eye_pic.jpeg";
//    desireEye.productURL = @"https://www.htc.com/us/smartphones/htc-desire-eye/";
//    
//    Product *oneM9 = [[Product alloc] init];
//    oneM9.productName = @"One M9";
//    oneM9.productLOGO = @"One_M9_pic.jpeg";
//    oneM9.productURL = @"https://www.htc.com/us/smartphones/htc-one-m9/";
//    
//    htc.products = [[NSMutableArray alloc] initWithObjects: oneA9, desireEye, oneM9, nil];
//    
//    self.companyList = [NSMutableArray arrayWithObjects: apple, samsung, lg, htc, nil];
    //DataAccessObject *dataObject = [DataAccessObject sharedDAO];
    self.companyList = [[DataAccessObject sharedDAO] getCompanies];
    self.title = @"Mobile device makers";
    
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = company.name;
    cell.imageView.image = [UIImage imageNamed:company.logo];
    
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
        [self.companyList removeObjectAtIndex: indexPath.row];
        [tableView reloadData];
    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *company = [[Company alloc] init];
    company = [self.companyList objectAtIndex:[indexPath row]];
    self.productViewController.title = company.name;
    self.productViewController.currentCompany = company;
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


//- (void)dealloc {
//    [super dealloc];
//}
@end

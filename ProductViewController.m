//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebPageViewController.h"

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

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
        self.appleArray = [NSMutableArray arrayWithObjects: @"iPad", @"iPod Touch",@"iPhone", nil];
        self.samsungArray = [NSMutableArray arrayWithObjects: @"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
        self.lgArray = [NSMutableArray arrayWithObjects: @"V10", @"Vista 2", @"G4", nil];
        self.htcArray = [NSMutableArray arrayWithObjects: @"One A9", @"Desire EYE", @"One M9", nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = self.appleArray;
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        self.products = self.samsungArray;
    }else if ([self.title isEqualToString:@"LG mobile devices"]) {
        self.products = self.lgArray;
    }else {
        self.products = self.htcArray;
    }
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
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    NSString *product = [self.products objectAtIndex:[indexPath row]];
    if ([product isEqualToString:@"iPad"]) {
        cell.imageView.image = [UIImage imageNamed:@"iPad_logo.jpeg"];
    }else if ([product isEqualToString:@"iPod Touch"]) {
        cell.imageView.image = [UIImage imageNamed:@"iPod_touch_logo.jpeg"];
    }else if ([product isEqualToString:@"iPhone"]) {
        cell.imageView.image = [UIImage imageNamed:@"iPhone_logo.png"];
    }else if ([product isEqualToString:@"Galaxy S4"]) {
        cell.imageView.image = [UIImage imageNamed:@"S4_logo.png"];
    }else if ([product isEqualToString:@"Galaxy Note"]) {
        cell.imageView.image = [UIImage imageNamed:@"Note_logo.png"];
    }else if ([product isEqualToString:@"Galaxy Tab"]) {
        cell.imageView.image = [UIImage imageNamed:@"tab_logo.jpeg"];
    }else if ([product isEqualToString:@"V10"]) {
        cell.imageView.image = [UIImage imageNamed:@"V10_pic.jpeg"];
    }else if ([product isEqualToString:@"Vista 2"]) {
        cell.imageView.image = [UIImage imageNamed:@"vista2_pic.jpeg"];
    }else if ([product isEqualToString:@"G4"]) {
        cell.imageView.image = [UIImage imageNamed:@"g4_pic.jpeg"];
    }else if ([product isEqualToString:@"One A9"]) {
        cell.imageView.image = [UIImage imageNamed:@"One_A9_pic.jpeg"];
    }else if ([product isEqualToString:@"Desire EYE"]) {
        cell.imageView.image = [UIImage imageNamed:@"Desire_eye_pic.jpeg"];
    }else {
        cell.imageView.image = [UIImage imageNamed:@"One_M9_pic.jpeg"];
    }
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *stringToMove = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:stringToMove atIndex:toIndexPath.row];

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
    NSString *product = [self.products objectAtIndex:[indexPath row]];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        if ([product isEqualToString:@"iPad"]){
            self.webPageViewController.title = @"iPad";
        }else if ([product isEqualToString:@"iPod Touch"]) {
            self.webPageViewController.title = @"iPod Touch";
        }else {
            self.webPageViewController.title = @"iPhone";
        }
    }else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        if ([product isEqualToString:@"Galaxy S4"]){
            self.webPageViewController.title = @"Galaxy S4";
        }else if ([product isEqualToString:@"Galaxy Note"]) {
            self.webPageViewController.title = @"Galaxy Note";
        }else {
            self.webPageViewController.title = @"Galaxy Tab";
        }
    }else if ([self.title isEqualToString:@"LG mobile devices"]) {
        if ([product isEqualToString:@"V10"]){
            self.webPageViewController.title = @"V10";
        }else if ([product isEqualToString:@"Vista 2"]) {
            self.webPageViewController.title = @"Vista 2";
        }else {
            self.webPageViewController.title = @"G4";
        }
    }else {
        if ([product isEqualToString:@"One A9"]){
            self.webPageViewController.title = @"One A9";
        }else if ([product isEqualToString:@"Desire EYE"]) {
            self.webPageViewController.title = @"Desire EYE";
        }else {
            self.webPageViewController.title = @"One M9";
        }
    }
    
    
    // Push the view controller.
    [self.navigationController pushViewController:self.webPageViewController animated:YES];
}
 


- (void)dealloc {
    [self.webPageViewController release];
    [super dealloc];
}


@end

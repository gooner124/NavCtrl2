//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@interface DataAccessObject() {
    sqlite3 *Company_ProductDB;
    NSString *bulletPoint;
    NSMutableArray *productList;
 
}

@end

@implementation DataAccessObject

+ (id)sharedDAO {
    static DataAccessObject *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    return sharedData;
}

-(id)init {
    self = [super init];
//    bulletPoint = @"bullet_point.jpeg";
    
    if (self) {
        //companyList = [[NSMutableArray alloc] init];
//        Company *apple = [[Company alloc] init];
//        apple.name = @"Apple mobile devices";
//        apple.stockSymbol = @"AAPL";
//        apple.logo = bulletPoint;
//
//        // Apple Products
//        Product *ipad = [[Product alloc] init];
//        ipad.productName = @"iPad";
//        ipad.productLOGO = bulletPoint;
//        ipad.productURL = @"https://www.apple.com/ipad-pro/";
//        
//        Product *ipod = [[Product alloc] init];
//        ipod.productName = @"iPod";
//        ipod.productLOGO = bulletPoint;
//        ipod.productURL = @"https://www.apple.com/ipod-touch/";
//        
//        Product *iphone = [[Product alloc] init];
//        iphone.productName = @"iPhone";
//        iphone.productLOGO = bulletPoint;
//        iphone.productURL = @"https://www.apple.com/iphone";
//        
//        apple.products = [[NSMutableArray alloc] initWithObjects: ipad, ipod, iphone, nil];
//        
//        //Samsung company
//        Company *samsung = [[Company alloc] init] ;
//        samsung.name = @"Samsung mobile devices";
//        samsung.stockSymbol = @"005930.KS";
//        samsung.logo = bulletPoint;
//        
//        //Samsung products
//        Product *galaxyS4 = [[Product alloc] init];
//        galaxyS4.productName = @"Galaxy S4";
//        galaxyS4.productLOGO = bulletPoint;
//        galaxyS4.productURL = @"https://www.samsung.com/global/microsite/galaxys4/";
//        
//        Product *galaxyNote = [[Product alloc] init];
//        galaxyNote.productName = @"Galaxy Note";
//        galaxyNote.productLOGO = bulletPoint;
//        galaxyNote.productURL = @"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
//        
//        Product *galaxyTab = [[Product alloc] init];
//        galaxyTab.productName = @"Galaxy Tab";
//        galaxyTab.productLOGO = bulletPoint;
//        galaxyTab.productURL = @"https://www.samsung.com/us/mobile/galaxy-tab/";
//        
//        samsung.products = [[NSMutableArray alloc] initWithObjects: galaxyS4, galaxyNote, galaxyTab, nil];
//        
//        //LG company
//        Company *lg = [[Company alloc] init];
//        lg.name = @"LG mobile devices";
//        lg.stockSymbol = @"066570.KS";
//        lg.logo = bulletPoint;
//        
//        //LG products
//        Product *v10 = [[Product alloc] init];
//        v10.productName = @"V10";
//        v10.productLOGO = bulletPoint;
//        v10.productURL = @"https://www.lg.com/us/mobile-phones/v10";
//        
//        Product *vista2 = [[Product alloc] init];
//        vista2.productName = @"Vista 2";
//        vista2.productLOGO = bulletPoint;
//        vista2.productURL = @"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2";
//        
//        Product *g4 = [[Product alloc] init];
//        g4.productName = @"G4";
//        g4.productLOGO = bulletPoint;
//        g4.productURL = @"https://www.lg.com/us/mobile-phones/g4";
//        
//        lg.products = [[NSMutableArray alloc] initWithObjects: v10, vista2, g4, nil];
//        
//        //HTC company
//        Company *htc = [[Company alloc] init];
//        htc.name = @"HTC mobile devices";
//        htc.stockSymbol = @"2498.TW";
//        htc.logo =  bulletPoint;
//        
//        //HTC products
//        Product *oneA9 = [[Product alloc] init];
//        oneA9.productName = @"One A9";
//        oneA9.productLOGO = bulletPoint;
//        oneA9.productURL = @"https://www.htc.com/us/smartphones/htc-one-a9/";
//        
//        Product *desireEye = [[Product alloc] init];
//        desireEye.productName = @"Desire EYE";
//        desireEye.productLOGO = bulletPoint;
//        desireEye.productURL = @"https://www.htc.com/us/smartphones/htc-desire-eye/";
//        
//        Product *oneM9 = [[Product alloc] init];
//        oneM9.productName = @"One M9";
//        oneM9.productLOGO = bulletPoint;
//        oneM9.productURL = @"https://www.htc.com/us/smartphones/htc-one-m9/";
//        
//        htc.products = [[NSMutableArray alloc] initWithObjects: oneA9, desireEye, oneM9, nil];
//        
//       companyList = [NSMutableArray arrayWithObjects: apple, samsung, lg, htc, nil];

    }
    
    return self;
}

#pragma mark create or open DB
-(void)createOrOpenDB
{

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    self.dbPathString = [docPath stringByAppendingPathComponent:@"Company_Product_DB"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.dbPathString]) {
        //Get DB from bundle & copy it to the doc dirctory
        NSString *databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Company_Product_DB"];
        [fileManager copyItemAtPath:databasePath toPath:self.dbPathString error:nil];
    }
    
}

#pragma mark get Company list

-(NSMutableArray*) getCompanies {
    //[self createOrOpenDB];
    //[self displayCompany];
    
    return self.companyList;
}

-(NSMutableArray *) displayCompany {
    sqlite3_stmt *company_statement;
    sqlite3_stmt *product_statement;
    if (sqlite3_open([self.dbPathString UTF8String], &Company_ProductDB)==SQLITE_OK)
    {
        [self.companyList removeAllObjects];
        NSString *companyQuerySQL = [NSString stringWithFormat:@"SELECT * FROM COMPANY"];
        NSString *productQuerySQL = [NSString stringWithFormat:@"SELECT * FROM PRODUCT"];
        const char *company_query_sql = [companyQuerySQL UTF8String];
        const char *product_query_sql = [productQuerySQL UTF8String];
        NSMutableArray *companyArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare(Company_ProductDB, company_query_sql, -1, &company_statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(company_statement)== SQLITE_ROW)
            {
                int uniqueId = sqlite3_column_int(company_statement, 0);
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(company_statement, 1)];
                NSString *stockSymbol = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(company_statement, 2)];
                NSString *logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(company_statement, 3)];
                Company *company = [[Company alloc]init];
                company.uniqueId = uniqueId;
                company.name = name;
                company.stockSymbol = stockSymbol;
                company.logo = logo;
                [name release]; name = nil;
                [stockSymbol release]; stockSymbol = nil;
                [logo release]; logo = nil;
    
                if (sqlite3_prepare(Company_ProductDB, product_query_sql, -1, &product_statement, NULL) == SQLITE_OK) {
                    productList = [[NSMutableArray alloc] init];
                    
                    while (sqlite3_step(product_statement)== SQLITE_ROW) {
                        
                        int company_uniqueId = sqlite3_column_int(product_statement, 1);
                        if (company_uniqueId == company.uniqueId) {
                            int uniqueId = sqlite3_column_int(product_statement, 0);
                            NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(product_statement, 2)];
                            NSString *url = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(product_statement, 3)];
                            NSString *logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(product_statement, 4)];
                            Product *product = [[Product alloc] init];
                            product.uniqueId = uniqueId;
                            product.company_uniqueId = company_uniqueId;
                            product.productName = name;
                            product.productURL = url;
                            product.productLOGO = logo;
                            [name release]; name = nil;
                            [url release]; url = nil;
                            [logo release]; logo = nil;
                            [productList addObject:product];
                            [product release]; product = nil;
                        }
                        
                    }
                    
                    company.products = productList;
                    [companyArray addObject:company];
                    [productList release]; productList = nil;
                }
                [company release]; company = nil;
            }

        }
        self.companyList = companyArray;
        [companyArray release]; companyArray = nil;
        
        sqlite3_close(Company_ProductDB);
    }
    return self.companyList;
}


#pragma mark create or edit Company

- (void) createCompany:(NSString*) companyName stockSymbol:(NSString*)stockSymbol companyLogo:(NSString*) companyLogo{
    char *error;
    if(sqlite3_open([self.dbPathString UTF8String], &Company_ProductDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO Company (NAME,STOCK_SYMBOL,LOGO) VALUES ('%s','%s','%s')",[companyName UTF8String],[stockSymbol UTF8String], [companyLogo UTF8String]];
        const char *query_sql = [querySQL UTF8String];
        NSLog(@"Create Company button click..");
        if (sqlite3_exec(Company_ProductDB, query_sql, NULL, NULL, &error) == SQLITE_OK)
        {
            NSLog(@"Company added to DB");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add company Complete" message:@"Company added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
            [alert release];
            Company *company = [[Company alloc] init];
            company.name = companyName;
            company.stockSymbol = stockSymbol;
            company.logo = companyLogo;
            
            NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Company"];
            const char *sql = [SQL UTF8String];
            sqlite3_stmt *statement;
            if (sqlite3_prepare(Company_ProductDB, sql, -1, &statement, NULL)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    if ([name isEqualToString:company.name]) {
                        int uniqueId = sqlite3_column_int(statement, 0);
                        company.uniqueId = uniqueId;
                    }
                    [name release]; name = nil;
                }
            }
            
            //company.uniqueId = 0;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            company.products = array;
            
            [self.companyList addObject:company];
            [array release]; array = nil;
            [company release]; company = nil;

        }
        sqlite3_close(Company_ProductDB);
    }
    [self getCompanies];
    

}

- (void)editCompany:(Company *)currentCompany WithCompanyName:(NSString *)newCompanyName stockSymbol:(NSString *)newStockSymbol companyLogo:(NSString*) newCompanyLogo{
    
    NSString *updateQuerySQL = [NSString stringWithFormat:@"UPDATE Company set name = '%s',stock_symbol = '%s',logo = '%s' where id = %d",[newCompanyName UTF8String],[newStockSymbol UTF8String], [newCompanyLogo UTF8String],(int)currentCompany.uniqueId];
    const char *update_query_sql = [updateQuerySQL UTF8String];
    
    if (sqlite3_exec(Company_ProductDB, update_query_sql, NULL, NULL, nil)==SQLITE_OK)
    {
        NSLog(@"Company  Updated");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Update" message:@"Company Updated" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
        
    currentCompany.name = newCompanyName;
    currentCompany.stockSymbol = newStockSymbol;
    currentCompany.logo = newCompanyLogo;

}

#pragma mark delete company

-(void)deleteCompany:(Company*) company {
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE from Company where id is %d", (int)company.uniqueId];
    const char* delete_query = [deleteQuery UTF8String];
    NSString *deleteProductQuery = [NSString stringWithFormat:@"DELETE from Product where company_id is %d", (int)company.uniqueId];
    const char *delete_product_query = [deleteProductQuery UTF8String];
    if (sqlite3_exec(Company_ProductDB, delete_query, NULL, NULL, nil)==SQLITE_OK) {
        NSLog(@"Company Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Company Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    if (sqlite3_exec(Company_ProductDB, delete_product_query, NULL, NULL, nil) == SQLITE_OK) {
        NSLog(@"Products deleted");
    }

}


#pragma mark create or edit Product

- (void)addProduct:(NSString*) productName WithProductWebsite:(NSString *)productWebsite WithProductLogo:(NSString*)productLogo ToCompany:(Company *)currentCompany {

    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO Product (company_id, name, url, logo) VALUES (%d,'%s','%s','%s')",
                        (int)currentCompany.uniqueId, [productName UTF8String],[productWebsite UTF8String], [productLogo UTF8String]];
    NSLog(@"%@", querySQL);
    const char *query_sql = [querySQL UTF8String];
    if (sqlite3_exec(Company_ProductDB, query_sql, NULL, NULL, nil) == SQLITE_OK) {
        NSLog(@"Product added to DB");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Product Complete" message:@"Product added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    Product *product = [[Product alloc] init];
    product.productName = productName;
    product.productURL = productWebsite;
    product.productLOGO = productLogo;
    
    [[currentCompany products] addObject:product];
    [product release]; product = nil;
}

- (void)editProduct:(Product*)currentProduct WithProductName:(NSString*)newProductName WithProductWebsite:(NSString*)newProductWebsite WithProductLogo:(NSString*)newProductLogo {
    
    NSString *updateQuerySQL = [NSString stringWithFormat:@"UPDATE Product set name = '%s', url = '%s',logo = '%s' where id = %d",[newProductName UTF8String],[newProductWebsite UTF8String], [newProductLogo UTF8String],(int)currentProduct.uniqueId];
    const char *update_query_sql = [updateQuerySQL UTF8String];
    
    if (sqlite3_exec(Company_ProductDB, update_query_sql, NULL, NULL, nil)==SQLITE_OK)
    {
        NSLog(@"Product  Updated");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Update" message:@"Product Updated" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    currentProduct.productName = newProductName;
    currentProduct.productURL = newProductWebsite;
    currentProduct.productLOGO = newProductLogo;
}

#pragma mark delete product

-(void)deleteProduct:(Product*) product {
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE from Product where name is '%s'", [product.productName UTF8String]];
    const char* delete_query = [deleteQuery UTF8String];
    if (sqlite3_exec(Company_ProductDB, delete_query, NULL, NULL, nil)==SQLITE_OK) {
        NSLog(@"Product Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Product Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}


#pragma mark memory management
- (void)dealloc {
    [_dbPathString release];
    [_companyList release];
    [productList release];
    
    
    [super dealloc];
}


@end










































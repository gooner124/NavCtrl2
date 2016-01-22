//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@interface DataAccessObject() {
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

#pragma mark initialize model context

-(void)initModelContext
{
    self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    NSString *path = [self archivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;

    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
    self.context = moc;
    //Add an undo manager
    NSUndoManager *undoManager = [[NSUndoManager alloc] init];
    self.context.undoManager = undoManager;
    [self.context setPersistentStoreCoordinator:psc];
    //[self.context setUndoManager:nil];
    [moc release];
    [psc release];
    [undoManager release];
}

-(NSString*) archivePath
{
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}


#pragma mark get Company list

-(NSMutableArray*) getCompanies {
    
    
    return self.companyList;
}

#pragma mark load companies

-(void) loadAllCompanies {
    
    if (!self.companyList) {
        

        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        //A predicate template can also be used
        NSPredicate *p = [NSPredicate predicateWithFormat:@"name MATCHES '.*'"];
        [request setPredicate:p];
        
        //Change ascending  YES/NO and validate
        NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES
                                        selector:@selector(caseInsensitiveCompare:)];
        
        [request setSortDescriptors:[NSArray arrayWithObject:sortByName]];
        [sortByName release];
        
        NSEntityDescription *company = [[self.model entitiesByName] objectForKey:@"CompanyMO"];
        [request setEntity:company];
        NSError *error = nil;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        [request release];
        if(!result){
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        if ([result count] == 0) {
            bulletPoint = @"bullet_point.jpeg";
            //Apple Company
            CompanyMO *apple = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.context];
            apple.name = @"Apple mobile devices";
            apple.stockSymbol = @"AAPL";
            apple.logo = bulletPoint;
            
            // Apple Products
            ProductMO *ipad = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            ipad.productName = @"iPad";
            ipad.productLogo = bulletPoint;
            ipad.productUrl = @"https://www.apple.com/ipad-pro/";
            [apple addProductsObject:ipad];
            
            ProductMO *ipod = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            ipod.productName = @"iPod";
            ipod.productLogo = bulletPoint;
            ipod.productUrl = @"https://www.apple.com/ipod-touch/";
            [apple addProductsObject:ipod];
            
            ProductMO *iphone = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            iphone.productName = @"iPhone";
            iphone.productLogo = bulletPoint;
            iphone.productUrl = @"https://www.apple.com/iphone";
            [apple addProductsObject: iphone];
            
            
            //Samsung company
            CompanyMO *samsung = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.context];
            samsung.name = @"Samsung mobile devices";
            samsung.stockSymbol = @"005930.KS";
            samsung.logo = bulletPoint;
            
            //Samsung products
            ProductMO *galaxyS4 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            galaxyS4.productName = @"Galaxy S4";
            galaxyS4.productLogo = bulletPoint;
            galaxyS4.productUrl = @"https://www.samsung.com/global/microsite/galaxys4/";
            [samsung addProductsObject:galaxyS4];
            
            ProductMO *galaxyNote = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            galaxyNote.productName = @"Galaxy Note";
            galaxyNote.productLogo = bulletPoint;
            galaxyNote.productUrl = @"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
            [samsung addProductsObject:galaxyNote];
            
            ProductMO *galaxyTab = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            galaxyTab.productName = @"Galaxy Tab";
            galaxyTab.productLogo = bulletPoint;
            galaxyTab.productUrl = @"https://www.samsung.com/us/mobile/galaxy-tab/";
            [samsung addProductsObject:galaxyTab];


            //LG company
            CompanyMO *lg = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.context];
            lg.name = @"LG mobile devices";
            lg.stockSymbol = @"066570.KS";
            lg.logo = bulletPoint;
            
            //        //LG products
            ProductMO *v10 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            v10.productName = @"V10";
            v10.productLogo = bulletPoint;
            v10.productUrl = @"https://www.lg.com/us/mobile-phones/v10";
            [lg addProductsObject:v10];
            
            ProductMO *vista2 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            vista2.productName = @"Vista 2";
            vista2.productLogo = bulletPoint;
            vista2.productUrl = @"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2";
            [lg addProductsObject:vista2];
            
            ProductMO *g4 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            g4.productName = @"G4";
            g4.productLogo = bulletPoint;
            g4.productUrl = @"https://www.lg.com/us/mobile-phones/g4";
            [lg addProductsObject:g4];
            

            
            //HTC company
            CompanyMO *htc = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.context];
            htc.name = @"HTC mobile devices";
            htc.stockSymbol = @"2498.TW";
            htc.logo =  bulletPoint;
            
            //HTC products
            ProductMO *oneA9 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            oneA9.productName = @"One A9";
            oneA9.productLogo = bulletPoint;
            oneA9.productUrl = @"https://www.htc.com/us/smartphones/htc-one-a9/";
            [htc addProductsObject:oneA9];
                    
            ProductMO *desireEye = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            desireEye.productName = @"Desire EYE";
            desireEye.productLogo = bulletPoint;
            desireEye.productUrl = @"https://www.htc.com/us/smartphones/htc-desire-eye/";
            [htc addProductsObject:desireEye];
                    
            ProductMO *oneM9 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
            oneM9.productName = @"One M9";
            oneM9.productLogo = bulletPoint;
            oneM9.productUrl = @"https://www.htc.com/us/smartphones/htc-one-m9/";
            [htc addProductsObject:oneM9];
            
            [self saveChanges];
            
            self.MOCompanyList = [NSMutableArray arrayWithObjects: apple, samsung, lg, htc, nil];
            [self loadAllCompanies];
        }else {
            NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:result];
            self.MOCompanyList = temp;
            [temp release];
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (CompanyMO *companyMO in result) {
                Company *company = [[Company alloc] init];
                company.name = companyMO.name;
                company.stockSymbol = companyMO.stockSymbol;
                company.logo = companyMO.logo;
                NSMutableArray *prodArray = [[NSMutableArray alloc] init];
                company.products = prodArray;
                [prodArray release];
                NSSet *productSet = [companyMO products];
                for (ProductMO *productMO in productSet) {
                    Product *product = [[Product alloc] init];
                    product.productName = productMO.productName;
                    product.productLOGO = productMO.productLogo;
                    product.productURL = productMO.productUrl;
                    [[company products] addObject:product];
                    [product release];
                }
                NSSortDescriptor *sortByProductName = [[NSSortDescriptor alloc]
                                                initWithKey:@"productName" ascending:YES
                                                selector:@selector(caseInsensitiveCompare:)];
                
                NSArray *sortedArray = [[company products] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByProductName]];
                [sortByProductName release];
                NSMutableArray *sortedMutableArray = [NSMutableArray arrayWithArray:sortedArray];
                company.products = sortedMutableArray;
                
                [array addObject:company];
                [company release];
                
            }
            self.companyList = array;
            
            [array release];
            
        }
        
    }
    
}

#pragma mark reload data from context
-(void) reloadDataFromContext {
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //A predicate template can also be used
    NSPredicate *p = [NSPredicate predicateWithFormat:@"name MATCHES '.*'"];
    [request setPredicate:p];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]
                                    initWithKey:@"name" ascending:YES
                                    selector:@selector(caseInsensitiveCompare:)];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByName]];
    [sortByName release];
    
    NSEntityDescription *companyMO = [[[self model] entitiesByName] objectForKey:@"CompanyMO"];
    [request setEntity:companyMO];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [[self context] executeFetchRequest:request error:&error];
    [request release];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:result];
    self.MOCompanyList = temp;
    [temp release];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (CompanyMO *companyMO in result) {
        Company *company = [[Company alloc] init];
        company.name = companyMO.name;
        company.stockSymbol = companyMO.stockSymbol;
        company.logo = companyMO.logo;
        NSMutableArray *prodArray = [[NSMutableArray alloc] init];
        company.products = prodArray;
        [prodArray release];
        NSSet *productSet = [companyMO products];
        for (ProductMO *productMO in productSet) {
            Product *product = [[Product alloc] init];
            product.productName = productMO.productName;
            product.productLOGO = productMO.productLogo;
            product.productURL = productMO.productUrl;
            [[company products] addObject:product];
            [product release];
        }
        NSSortDescriptor *sortByProductName = [[NSSortDescriptor alloc]
                                               initWithKey:@"productName" ascending:YES
                                               selector:@selector(caseInsensitiveCompare:)];
        
        NSArray *sortedArray = [[company products] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByProductName]];
        [sortByProductName release];
        NSMutableArray *sortedMutableArray = [NSMutableArray arrayWithArray:sortedArray];
        company.products = sortedMutableArray;
        
        [array addObject:company];
        [company release];
        
    }
    self.companyList = array;
    
    [array release];
}

#pragma mark create or edit Company

- (void) createCompany:(NSString*) companyName stockSymbol:(NSString*)stockSymbol companyLogo:(NSString*) companyLogo{
    
    CompanyMO *companyMO = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.context];
    [companyMO setName:companyName];
    [companyMO setLogo:companyLogo];
    [companyMO setStockSymbol:stockSymbol];
    
    NSSet *productSet = [[NSSet alloc] init];
    [companyMO setProducts:productSet];
    [productSet release];
 
    [self.MOCompanyList addObject:companyMO];
    
    Company *company = [[Company alloc] init];
    
    company.name = companyName;
    company.stockSymbol = stockSymbol;
    company.logo = companyLogo;
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    company.products = array;
            
    [self.companyList addObject:company];
    [array release]; array = nil;
    [company release]; company = nil;

    
    //[self reloadDataFromContext];
}

- (void)editCompany:(Company *)currentCompany WithCompanyName:(NSString *)newCompanyName stockSymbol:(NSString *)newStockSymbol companyLogo:(NSString*) newCompanyLogo AndCurrentIndex:(NSIndexPath*) currentIndex{
    
    NSUInteger index = [currentIndex row];
    CompanyMO *companyMO = [self.MOCompanyList objectAtIndex:index];
    [companyMO setName:newCompanyName];
    [companyMO setLogo:newCompanyLogo];
    [companyMO setStockSymbol:newStockSymbol];
    
    currentCompany.name = newCompanyName;
    currentCompany.stockSymbol = newStockSymbol;
    currentCompany.logo = newCompanyLogo;
    
    //[self reloadDataFromContext];
}

#pragma mark delete company

-(void)deleteCompany:(NSUInteger) index {
    CompanyMO *companyMO = [self.MOCompanyList objectAtIndex:index];
    
    /*
    NSString *name = companyMO.name;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:self.context]];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    NSError* error = nil;
    NSArray* results = [self.context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    CompanyMO *objectToDelete = [results objectAtIndex:0];
    
    [self.context deleteObject:objectToDelete];
     */

    [self.MOCompanyList removeObjectAtIndex:index];
    [self.context deleteObject:companyMO];

    [self.companyList removeObjectAtIndex:index];
    
    //[self reloadDataFromContext];
    
}


#pragma mark create or edit Product

- (void)addProduct:(NSString*) productName WithProductWebsite:(NSString *)productWebsite WithProductLogo:(NSString*)productLogo ToCompany:(Company *)currentCompany WithCurrentIndex:currentIndex {
    
    ProductMO *productMO = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.context];
    NSUInteger index = [currentIndex row];
    CompanyMO *companyMO = [self.MOCompanyList objectAtIndex:index];
    [productMO setProductName:productName];
    [productMO setProductLogo:productLogo];
    [productMO setProductUrl:productWebsite];
    
    [companyMO addProductsObject:productMO];
    
    Product *product = [[Product alloc] init];
    product.productName = productName;
    product.productURL = productWebsite;
    product.productLOGO = productLogo;
    
    [[currentCompany products] addObject:product];
    [product release]; product = nil;
    
    //[self reloadDataFromContext];
}

- (void)editProduct:(Product*)currentProduct WithProductName:(NSString*)newProductName WithProductWebsite:(NSString*)newProductWebsite WithProductLogo:(NSString*)newProductLogo WithCurrentIndex:(NSIndexPath*)currentIndex {
    
    NSUInteger index = [currentIndex row];
    
    CompanyMO *companyMO = [self.MOCompanyList objectAtIndex:index];
    for (ProductMO *productMO in companyMO.products) {
        if ([currentProduct.productName isEqualToString:productMO.productName]) {
            [productMO setProductName:newProductName];
            [productMO setProductLogo:newProductLogo];
            [productMO setProductUrl:newProductWebsite];
        }
    }
    
    currentProduct.productName = newProductName;
    currentProduct.productURL = newProductWebsite;
    currentProduct.productLOGO = newProductLogo;
    
    //[self reloadDataFromContext];
}

#pragma mark delete product

-(void)deleteProduct:(NSUInteger) index AndProduct:(Product*)product{
    CompanyMO *companyMO = [self.MOCompanyList objectAtIndex:index];
    for (ProductMO *productMO in companyMO.products) {
        NSString *prodName = product.productName;
        NSString *MOprodName = productMO.productName;
        
        if ([prodName isEqualToString:MOprodName]) {
            [self.context deleteObject:productMO];
            break;
        }
    }
    
 
//    NSString *name = product.productName;
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:self.context]];
//    
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"productName == %@", name]];
//    NSError* error = nil;
//    NSArray* results = [self.context executeFetchRequest:fetchRequest error:&error];
//    [fetchRequest release];
//
//    
//    ProductMO *objectToDelete = [results objectAtIndex:0];
//    
//    [self.context deleteObject:objectToDelete];
    
    
    //[self reloadDataFromContext];

}

#pragma mark save changes

-(void) saveChanges
{
    NSError *err = nil;
    BOOL successful = [self.context save:&err];
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    NSLog(@"Data Saved");
}

#pragma mark undo changes

-(void) undoChanges {
    [self.context undo];
    [self reloadDataFromContext];
    
}

#pragma mark memory management
- (void)dealloc {
    
    [_companyList release];
    [productList release];
    [_MOCompanyList release];
    [_model release];
    [_context release];
    
    
    [super dealloc];
}


@end










































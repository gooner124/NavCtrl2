//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Matthew Paravati on 12/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@interface DataAccessObject() {
    NSMutableArray *companyList;
 
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
    
    if (self) {
        Company *apple = [[Company alloc] init];
        apple.name = @"Apple mobile devices";
        apple.logo = @"apple logo.tiff";
        
        // Apple Products
        Product *ipad = [[Product alloc] init];
        ipad.productName = @"iPad";
        ipad.productLOGO = @"iPad_logo.jpeg";
        ipad.productURL = @"https://www.apple.com/ipad-pro/";
        
        Product *ipod = [[Product alloc] init];
        ipod.productName = @"iPod";
        ipod.productLOGO = @"iPod_touch_logo.jpeg";
        ipod.productURL = @"https://www.apple.com/ipod-touch/";
        
        Product *iphone = [[Product alloc] init];
        iphone.productName = @"iPhone";
        iphone.productLOGO = @"iPhone_logo.png";
        iphone.productURL = @"https://www.apple.com/iphone";
        
        apple.products = [[NSMutableArray alloc] initWithObjects: ipad, ipod, iphone, nil];
        
        //Samsung company
        Company *samsung = [[Company alloc] init] ;
        samsung.name = @"Samsung mobile devices";
        samsung.logo = @"Samsung_Logo.png";
        
        //Samsung products
        Product *galaxyS4 = [[Product alloc] init];
        galaxyS4.productName = @"Galaxy S4";
        galaxyS4.productLOGO = @"S4_logo.png";
        galaxyS4.productURL = @"https://www.samsung.com/global/microsite/galaxys4/";
        
        Product *galaxyNote = [[Product alloc] init];
        galaxyNote.productName = @"Galaxy Note";
        galaxyNote.productLOGO = @"Note_logo.png";
        galaxyNote.productURL = @"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
        
        Product *galaxyTab = [[Product alloc] init];
        galaxyTab.productName = @"Galaxy Tab";
        galaxyTab.productLOGO = @"tab_logo.jpeg";
        galaxyTab.productURL = @"https://www.samsung.com/us/mobile/galaxy-tab/";
        
        samsung.products = [[NSMutableArray alloc] initWithObjects: galaxyS4, galaxyNote, galaxyTab, nil];
        
        //LG company
        Company *lg = [[Company alloc] init];
        lg.name = @"LG mobile devices";
        lg.logo = @"lg logo.jpg";
        
        //LG products
        Product *v10 = [[Product alloc] init];
        v10.productName = @"V10";
        v10.productLOGO = @"V10_pic.jpeg";
        v10.productURL = @"https://www.lg.com/us/mobile-phones/v10";
        
        Product *vista2 = [[Product alloc] init];
        vista2.productName = @"Vista 2";
        vista2.productLOGO = @"vista2_pic.jpeg";
        vista2.productURL = @"https://www.lg.com/us/cell-phones/lg-H740-g-vista-2";
        
        Product *g4 = [[Product alloc] init];
        g4.productName = @"G4";
        g4.productLOGO = @"g4_pic.jpeg";
        g4.productURL = @"https://www.lg.com/us/mobile-phones/g4";
        
        lg.products = [[NSMutableArray alloc] initWithObjects: v10, vista2, g4, nil];
        
        //HTC company
        Company *htc = [[Company alloc] init];
        htc.name = @"HTC mobile devices";
        htc.logo =  @"htc_logo.jpg";
        
        //HTC products
        Product *oneA9 = [[Product alloc] init];
        oneA9.productName = @"One A9";
        oneA9.productLOGO = @"One_A9_pic.jpeg";
        oneA9.productURL = @"https://www.htc.com/us/smartphones/htc-one-a9/";
        
        Product *desireEye = [[Product alloc] init];
        desireEye.productName = @"Desire EYE";
        desireEye.productLOGO = @"Desire_eye_pic.jpeg";
        desireEye.productURL = @"https://www.htc.com/us/smartphones/htc-desire-eye/";
        
        Product *oneM9 = [[Product alloc] init];
        oneM9.productName = @"One M9";
        oneM9.productLOGO = @"One_M9_pic.jpeg";
        oneM9.productURL = @"https://www.htc.com/us/smartphones/htc-one-m9/";
        
        htc.products = [[NSMutableArray alloc] initWithObjects: oneA9, desireEye, oneM9, nil];
        
        companyList = [NSMutableArray arrayWithObjects: apple, samsung, lg, htc, nil];

    }
    
    return self;
}

-(NSMutableArray*) getCompanies {
    return companyList;
}

- (void)addCompany:(Company*)company atIndex:(int)index
{
    if (companyList.count >= index)
        [companyList insertObject:company atIndex:index];
    else
        [companyList addObject:company];
}

- (void)deleteCompanyAtIndex:(int)index
{
    [companyList removeObjectAtIndex:index];
}


@end

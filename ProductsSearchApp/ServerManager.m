//
//  ServerManager.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "ServerManager.h"
#import "Product.h"
#import "NetworkManager.h"

@implementation ServerManager

+ (instancetype)sharedInstance {
    static ServerManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSArray *)getProducts:(NSString *)queryStr {

    NetworkManager *networkManager = [NetworkManager sharedInstance];

    NSString *urlStr = [NSString stringWithFormat:@"https://platform.shopyourway.com/products/search?q=%@&token=0_18401_253402300799_1_c78a591a5ecaf201c77c315dae461f0647bbbe90bc5f999d782de90e6b5bdb6f&hash=b8b5adaf022fcbc2f70476b3d0181bd2a12b859d440cc40aa9638aa2513eaebe",queryStr];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *jsonStr = [networkManager getDataFrom:urlStr ];
    });
    
    Product *p1 = [[Product alloc] initWithId:123 description:@"First product desc" imageUrl:@"http://google.com/image1" price:@(1.99)];
    Product *p2 = [[Product alloc] initWithId:456 description:@"Second product desc" imageUrl:@"http://google.com/image2" price:@(2.99)];
    Product *p3 = [[Product alloc] initWithId:789 description:@"Third product desc" imageUrl:@"http://google.com/image3" price:@(3.00)];
    
    NSArray *productsArray = [[NSMutableArray alloc] initWithObjects:p1, p2, p3, nil];
    return productsArray;
}

@end

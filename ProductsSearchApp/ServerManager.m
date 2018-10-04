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
#import "ProductsRequest.h"

@implementation ServerManager

+ (instancetype)sharedInstance {
    static ServerManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getProducts:(NSString *)queryStr withCompletionBlock:(void (^)(NSArray *products))completionBlock {
    NetworkManager *networkManager = [NetworkManager sharedInstance];
    
    ProductsRequest *productsRequest = [[ProductsRequest alloc] initWithQueryParam:queryStr];
    [networkManager getDataFromRequest:productsRequest withCompletionBlock:^(NSData *data, NSError *error) {
        NSDictionary *jsonDict = [self parseJson:data];
        if (!jsonDict) {
            // ERROR
        } else {
            NSArray *rawProductsArray = [jsonDict valueForKey:@"products"];
            NSArray *productsArray = [self convertToProducts:rawProductsArray];
            completionBlock(productsArray);
        }
    }];
}

- (NSDictionary *)parseJson:(NSData *)jsonData {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    if(error) {
        NSLog(@"error parsing json");
        return nil;
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    } else {
        NSLog(@"object is not a dictionary");
        return nil;
    }
}

- (NSArray *)convertToProducts:(NSArray *)productsRaw {
    NSMutableArray *productsArray = [NSMutableArray new];
    [productsRaw enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Product *product = [[Product alloc] initWithJSONDict:obj];
        [productsArray addObject:product];
    }];
    
    return productsArray;
}
@end

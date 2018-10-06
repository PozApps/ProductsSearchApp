//
//  ServerManager.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "ProductsModel.h"
#import "Product.h"
#import "NetworkManager.h"
#import "ProductsRequest.h"
#import "CacheManager.h"
#import "DownloadImageRequest.h"

@interface ProductsModel ()

@property (nonatomic) NSMutableArray *productsArray;

@end

@implementation ProductsModel

+ (instancetype)sharedInstance {
    static ProductsModel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.productsArray = [NSMutableArray new];
    }
    return self;
}

- (void)getProducts:(NSString *)queryStr withCompletionBlock:(void (^)(NSArray *products))completionBlock {
    NetworkManager *networkManager = [NetworkManager sharedInstance];
    
    ProductsRequest *productsRequest = [[ProductsRequest alloc] initWithQueryParam:queryStr];
    [networkManager getDataFromRequest:productsRequest withCompletionBlock:^(NSData *data, NSError *error) {
        if (!data || error) {
            // TODO: We can handle error in case we want to notify about the error loading the products, (and pass it forward if needed)
            [self replaceProductsArray:nil];
        } else {
            NSDictionary *jsonDict = [self parseJson:data];
            if (!jsonDict) {
                // TODO: Handle No products or some Json parsing error
                [self replaceProductsArray:nil];
            } else {
                NSArray *rawProductsArray = [jsonDict valueForKey:@"products"];
                [self replaceProductsArray:rawProductsArray];
            }
        }
        completionBlock(self.productsArray);
    }];
}

- (NSDictionary *)parseJson:(NSData *)jsonData {
    @try {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:jsonData
                     options:0
                     error:&error];
        
        if(error) {
            // TODO: Handle error parsing Json
            return nil;
        }
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            return object;
        } else {
            // TODO: Handle unexpected json structure
            return nil;
        }
    } @catch (NSException *exception) {
        // TODO: Handle unexpected exception
        return nil;
    }
}

- (void)replaceProductsArray:(NSArray *)productsRaw {
    [self.productsArray removeAllObjects];
    [productsRaw enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Product *product = [[Product alloc] initWithJSONDict:obj];
        [self.productsArray addObject:product];
    }];
}

- (void)loadProductImage:(Product *)product withCompletionBlock:(void (^)(UIImage *image))completionBlock {
    // Note - Downloading and caching the images can also be done with many 3rd party libraries.
    UIImage *image = [[CacheManager sharedInstance] imageForUrl:[product imageUrl]];
    if (!image) {
        DownloadImageRequest *downloadImageRequest = [[DownloadImageRequest alloc] initWithImageUrl:[product imageUrl]];
        [[NetworkManager sharedInstance] getDataFromRequest:downloadImageRequest withCompletionBlock:^(NSData *data, NSError *error) {
            UIImage *newImage = nil;
            if (!data || error) {
                // TODO: Handle error loading the image
            }  else {
                newImage = [UIImage imageWithData:data];
                if (!newImage) {
                    // TODO: Handle error decoding the image from the data
                } else {
                    [[CacheManager sharedInstance] setImage:newImage forUrl:[product imageUrl]];
                }
            }
            completionBlock(newImage);
        }];
    } else {
        completionBlock(image);
    }
}

@end

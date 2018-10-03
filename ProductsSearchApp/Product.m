//
//  Product.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithId:(NSInteger )productId description:(NSString *)desc imageUrl:(NSString *)imageUrl price:(NSNumber *)price {
    if (self = [super init]) {
        _productId = productId;
        _desc = desc;
        _imageUrl = imageUrl;
        _price = price;
    }
    return self;
}

@end

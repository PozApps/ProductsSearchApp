//
//  Product.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithJSONDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _productId = [dict objectForKey:@"id"];
        _desc = [dict objectForKey:@"description"];
        _imageUrl = [dict objectForKey:@"imageUrl"];
        _regularPrice = [dict objectForKey:@"regularPrice"];
        _price = [dict objectForKey:@"price"];
        _rating = [dict objectForKey:@"rating"];
    }
    
    return self;
}

/* No need in this method if the only way to init products is from the json
- (instancetype)initWithId:(NSInteger )productId description:(NSString *)desc imageUrl:(NSString *)imageUrl price:(NSNumber *)price {
    if (self = [super init]) {
        _productId = productId;
        _desc = desc;
        _imageUrl = imageUrl;
        _price = price;
    }
    return self;
}
*/

@end

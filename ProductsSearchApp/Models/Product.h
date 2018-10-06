//
//  Product.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) NSNumber *productId;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSNumber *rating;
@property (nonatomic) NSNumber *regularPrice;
@property (nonatomic) NSNumber *price;

- (instancetype)initWithJSONDict:(NSDictionary *)dict;

@end

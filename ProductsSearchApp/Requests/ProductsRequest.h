//
//  ProductsRequest.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 04/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsRequest : NSMutableURLRequest

- (instancetype)initWithQueryParam:(NSString *)query;

@end

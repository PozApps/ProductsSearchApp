//
//  ServerManager.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductsModel : NSObject

+ (instancetype)sharedInstance;

- (void)getProducts:(NSString *)queryStr withCompletionBlock:(void (^)(NSArray *products))completionBlock;
- (void)loadProductImage:(Product *)product withCompletionBlock:(void (^)(UIImage *image))completionBlock;

@end

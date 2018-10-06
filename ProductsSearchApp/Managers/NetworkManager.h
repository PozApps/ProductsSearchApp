//
//  NetworkManager.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)getDataFromRequest:(NSMutableURLRequest *)request withCompletionBlock:(void (^)(NSData *data, NSError *error))completionBlock;

@end

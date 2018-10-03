//
//  ServerManager.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getProducts:(NSString *)queryStr;

@end

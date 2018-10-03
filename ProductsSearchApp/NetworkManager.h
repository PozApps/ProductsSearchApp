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

- (NSString *) getDataFrom:(NSString *)url;


@end

//
//  CacheManager.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 04/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+ (instancetype)sharedInstance;
- (UIImage *)imageForUrl:(NSString *)url;
- (void)setImage:(UIImage *)image forUrl:(NSString *)url;

@end

//
//  CacheManager.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 04/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheManager.h"

@interface CacheManager ()

@property (nonatomic) NSMutableDictionary *cacheDict;

@end

@implementation CacheManager

+ (instancetype)sharedInstance {
    static CacheManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.cacheDict = [NSMutableDictionary new];
    }
    return self;
}

- (UIImage *)imageForUrl:(NSString *)url {
    return [self.cacheDict objectForKey:url];
}

- (void)setImage:(UIImage *)image forUrl:(NSString *)url {
    [self.cacheDict setObject:image forKey:url];
}

@end

//
//  DownloadImageRequest.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 05/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "DownloadImageRequest.h"

@implementation DownloadImageRequest

- (instancetype)init {
    if (self = [super init]) {
        [self setHTTPMethod:@"GET"];
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)imageUrl {
    if (self = [self init]) {
        if (imageUrl) {
            [self setURL:[NSURL URLWithString:imageUrl]];
        }
    }
    return self;
}

@end

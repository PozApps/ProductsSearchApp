//
//  ProductsRequest.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 04/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "ProductsRequest.h"

@interface ProductsRequest()

@property (nonatomic) NSMutableString *urlStr;

@end

@implementation ProductsRequest

- (instancetype)init {
    if (self = [super init]) {
        [self setHTTPMethod:@"GET"];
        
        self.urlStr = [NSMutableString stringWithFormat:@"https://platform.shopyourway.com/products/search?token=0_18401_253402300799_1_c78a591a5ecaf201c77c315dae461f0647bbbe90bc5f999d782de90e6b5bdb6f&hash=b8b5adaf022fcbc2f70476b3d0181bd2a12b859d440cc40aa9638aa2513eaebe"];
    }
    return self;
}

- (instancetype)initWithQueryParam:(NSString *)query  {
    if (self = [self init]) {
        if (query) {
            [self.urlStr appendString:[NSString stringWithFormat:@"&q=%@",query]];
            [self setURL:[NSURL URLWithString:self.urlStr]];
        }
    }
    return self;
}

@end

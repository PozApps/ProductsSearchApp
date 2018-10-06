//
//  DownloadImageRequest.h
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 05/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadImageRequest : NSMutableURLRequest

- (instancetype)initWithImageUrl:(NSString *)imageUrl;

@end

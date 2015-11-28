//
//  WMNetworkManager.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WMNetworkSuccessBlock)(id responseData, NSInteger totalProducts);
typedef void (^WMNetworkFailureBlock)(NSError *error, NSString *message);

@interface WMNetworkManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

+ (WMNetworkManager *)sharedWMNetworkManager;

- (void)getProductsWithPageNumber:(NSInteger)pageNumber success:(WMNetworkSuccessBlock)success failure:(WMNetworkFailureBlock)failure;

@end
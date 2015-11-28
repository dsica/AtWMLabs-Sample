//
//  WMNetworkManager.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMNetworkManager.h"

@interface WMNetworkManager (Private)


@end


@implementation WMNetworkManager

+ (WMNetworkManager *)sharedWMNetworkManager
{
    static WMNetworkManager *_sharedWMNetworkManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWMNetworkManager = [[self alloc] init];
    });
    
    return _sharedWMNetworkManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return self;
}


#pragma mark - Public Methods -
- (void)getProductsWithPageNumber:(NSInteger)pageNumber success:(WMNetworkSuccessBlock)success failure:(WMNetworkFailureBlock)failure
{
    NSString *productsURL = [NSString stringWithFormat:@"https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/walmartproducts/fe9c2f0a-7d46-43ef-bfde-16a098f61c46/%lu/30", (long)pageNumber];
    NSURL *url = [NSURL URLWithString:productsURL];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                if ([responseDict isKindOfClass:[NSDictionary class]]) {
                    NSString *errorMessage = [responseDict valueForKey:@"error"];
                    if (!IsEmpty(errorMessage)) {
                        NSLog(@"Unable to get products: %@", errorMessage);
                        if (failure) {
                            failure(nil, errorMessage);
                        }
                        return;
                    }
                    
                    NSArray *productsJSON = [responseDict objectForKey:@"products"];
                    NSInteger totalProducts = [[responseDict objectForKey:@"totalProducts"] integerValue];
                    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
                    
                    if (!jsonError) {
                        for (NSDictionary *thisProductDict in productsJSON) {
                            WMProduct *thisProduct = [[WMProduct alloc] init];
                            if ([thisProductDict valueForKey:@"productId"]) {
                                thisProduct.productId = [thisProductDict valueForKey:@"productId"];
                                thisProduct.productName = [thisProductDict valueForKey:@"productName"];
                                thisProduct.shortDescription = [thisProductDict valueForKey:@"shortDescription"];
                                thisProduct.longDescription = [thisProductDict valueForKey:@"longDescription"];
                                thisProduct.price = [thisProductDict valueForKey:@"price"];
                                thisProduct.productImage = [thisProductDict valueForKey:@"productImage"];
                                thisProduct.reviewRating = [[thisProductDict valueForKey:@"reviewRating"] floatValue];
                                thisProduct.reviewCount = [[thisProductDict valueForKey:@"reviewCount"] integerValue];
                                thisProduct.inStock = [[thisProductDict valueForKey:@"inStock"] boolValue];
                            }
                            
                            [productsArray addObject:thisProduct];
                        }
                        
                        if (success) {
                            success(productsArray, totalProducts);
                        }
                    }
                    else {
                        if (failure) {
                            failure(jsonError, nil);
                        }
                    }
                }
                else {
                    if (failure) {
                        failure(nil, nil);
                    }
                }
            } else {
                NSLog(@"Unexpected HTTP status code: %lu", (long)httpResp.statusCode);
            }
        } else {
            NSLog(@"Network error: %@", [error localizedDescription]);
        }
    }] resume];
}


@end
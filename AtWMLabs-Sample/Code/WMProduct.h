//
//  WMProduct.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMProduct : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, strong) NSString *longDescription;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic) CGFloat reviewRating;
@property (nonatomic) NSInteger reviewCount;
@property (nonatomic) BOOL inStock;

@end

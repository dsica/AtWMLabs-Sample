//
//  WMProductDetailContentPriceTableViewCell.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailContentPriceTableViewCell.h"

@implementation WMProductDetailContentPriceTableViewCell


- (void)setProduct:(WMProduct *)product
{
    if (_product != product) {
        _product = product;
    }
    
    [self updatePriceTextView];
}

- (void)updatePriceTextView
{
    UIColor *textColor = [UIColor wmOrange];
    CGFloat bigSize = isPadDevice ? 30.0f : 24.0f;
    CGFloat smallSize = isPadDevice ? 24.0f : 16.0f;
    NSDictionary *bigAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:bigSize], NSForegroundColorAttributeName : textColor};
    NSDictionary *smallAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:smallSize], NSForegroundColorAttributeName : textColor, NSBaselineOffsetAttributeName : [NSNumber numberWithFloat:5.0f]};
    
    NSMutableAttributedString *priceText = [[NSMutableAttributedString alloc] init];
    NSAttributedString *dollarSign = [[NSAttributedString alloc] initWithString:@"$"
                                                                     attributes:smallAttrs];
    
    NSString *priceString = [self.product.price stringByReplacingOccurrencesOfString:@"$" withString:@""];
    NSArray *prices = [priceString componentsSeparatedByString:@"."];
    
    if ([prices count] == 2) {
        NSAttributedString *dollars = [[NSAttributedString alloc] initWithString:[prices objectAtIndex:0] attributes:bigAttrs];
        NSAttributedString *cents = [[NSAttributedString alloc] initWithString:[prices objectAtIndex:1]
                                                                    attributes:smallAttrs];
        
        [priceText appendAttributedString:dollarSign];
        [priceText appendAttributedString:dollars];
        [priceText appendAttributedString:cents];
        
        self.priceLabel.attributedText = priceText;
    }
    else {
        self.priceLabel.text = @"--";
    }
}


@end

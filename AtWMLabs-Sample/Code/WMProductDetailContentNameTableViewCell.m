//
//  WMProductDetailContentNameTableViewCell.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailContentNameTableViewCell.h"

@implementation WMProductDetailContentNameTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.productName.scrollsToTop = NO;
    self.reviewCountLabel.textColor = [UIColor grayColor];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.productName.text = nil;
    self.blueViewWidthConstraint.constant = 0.0f;
}

- (void)setProduct:(WMProduct *)product
{
    if (_product != product) {
        _product = product;
    }
    
    [self updateCell];
}

- (void)updateCell
{
    self.blueViewWidthConstraint.constant = self.starsView.frame.size.width * (self.product.reviewRating/5.0f);
    self.productName.text = self.product.productName;
    
    if (self.product.reviewCount > 0) {
        self.reviewCountLabel.alpha = 1.0f;
        self.starsView.alpha = 1.0f;
        self.reviewCountLabel.text = [NSString stringWithFormat:@"(%lu)", (long)self.product.reviewCount];
    }
    else {
        self.reviewCountLabel.alpha = 0.0f;
        self.starsView.alpha = 0.0f;
    }
}


@end

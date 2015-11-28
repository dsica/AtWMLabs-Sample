//
//  WMProductCollectionViewCell.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductCollectionViewCell.h"

@interface WMProductCollectionViewCell ()

@end

@implementation WMProductCollectionViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.productName.scrollsToTop = NO;
    self.priceTextView.scrollsToTop = NO;
    self.reviewCountLabel.textColor = [UIColor grayColor];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.productName.text = nil;
    self.priceTextView.text = nil;
    self.productImage.image = nil;
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
    [self updatePriceTextViewHighlighted:NO];
    
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

- (void)updatePriceTextViewHighlighted:(BOOL)highlighted
{
    UIColor *textColor = highlighted ? [UIColor whiteColor] : [UIColor wmOrange];
    CGFloat bigSize = isPadDevice ? 24.0f : 20.0f;
    CGFloat smallSize = isPadDevice ? 16.0f : 12.0f;
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
        
        self.priceTextView.attributedText = priceText;
    }
    else {
        self.priceTextView.text = @"--";
    }
    
    CGFloat fixedHeight = self.priceTextView.frame.size.height;
    CGSize newSize = [self.priceTextView sizeThatFits:CGSizeMake(MAXFLOAT, fixedHeight)];
    self.priceTextViewWidthContraint.constant = newSize.width;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.productName.textColor = [UIColor whiteColor];
        self.productName.backgroundColor = [UIColor lightGrayColor];
        self.starsBlueView.backgroundColor = [UIColor whiteColor];
        self.starsView.backgroundColor = [UIColor lightGrayColor];
        self.starsGrayView.backgroundColor = [UIColor lighterColorForColor:[UIColor lightGrayColor]];
        self.starsImageView.image = [UIImage imageNamed:@"fivestars-gray"];
        self.reviewCountLabel.textColor = [UIColor whiteColor];
        self.priceTextView.backgroundColor = [UIColor lightGrayColor];
        [self updatePriceTextViewHighlighted:YES];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.productName.textColor = [UIColor blackColor];
        self.productName.backgroundColor = [UIColor whiteColor];
        self.starsBlueView.backgroundColor = [UIColor wmBlue];
        self.starsView.backgroundColor = [UIColor whiteColor];
        self.starsGrayView.backgroundColor = [UIColor lightGrayColor];
        self.starsImageView.image = [UIImage imageNamed:@"fivestars"];
        self.reviewCountLabel.textColor = [UIColor grayColor];
        self.priceTextView.backgroundColor = [UIColor whiteColor];
        [self updatePriceTextViewHighlighted:NO];
    }
}


@end

//
//  WMProductCollectionViewCell.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UITextView *productName;
@property (weak, nonatomic) IBOutlet UITextView *priceTextView;
@property (weak, nonatomic) IBOutlet UIView *starsView;
@property (weak, nonatomic) IBOutlet UIView *starsBlueView;
@property (weak, nonatomic) IBOutlet UIView *starsGrayView;
@property (weak, nonatomic) IBOutlet UIImageView *starsImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceTextViewWidthContraint;

@property (nonatomic, strong) WMProduct *product;

- (void)setHighlighted:(BOOL)highlighted;

@end

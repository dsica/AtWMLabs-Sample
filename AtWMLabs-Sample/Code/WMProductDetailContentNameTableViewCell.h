//
//  WMProductDetailContentNameTableViewCell.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductDetailContentNameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *productName;
@property (weak, nonatomic) IBOutlet UIView *starsView;
@property (weak, nonatomic) IBOutlet UIView *starsBlueView;
@property (weak, nonatomic) IBOutlet UIView *starsGrayView;
@property (weak, nonatomic) IBOutlet UIImageView *starsImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewWidthConstraint;

@property (nonatomic, strong) WMProduct *product;

@end

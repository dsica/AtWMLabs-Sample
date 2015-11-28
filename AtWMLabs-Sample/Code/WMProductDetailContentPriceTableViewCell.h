//
//  WMProductDetailContentPriceTableViewCell.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductDetailContentPriceTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) WMProduct *product;


@end

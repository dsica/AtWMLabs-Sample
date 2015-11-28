//
//  WMProductDetailContentImageTableViewCell.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductDetailContentImageTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIScrollView *productImagesScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) WMProduct *product;

@end

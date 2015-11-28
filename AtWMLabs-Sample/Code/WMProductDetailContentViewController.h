//
//  WMProductDetailContentViewController.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductDetailContentViewController : UITableViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) WMProduct *product;

@end

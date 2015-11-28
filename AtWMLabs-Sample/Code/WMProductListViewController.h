//
//  WMProductCollectionVC.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMProductDetailViewController.h"

@protocol WMProductListViewControllerDelegate <NSObject>

- (void)loadedProducts:(NSArray *)products;

@end

@interface WMProductListViewController : UIViewController <WMProductDetailViewConrollerDelegate>

@property (nonatomic, weak) id <WMProductListViewControllerDelegate> delegate;

@end

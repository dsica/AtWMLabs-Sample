//
//  WMProductDetailPageViewController.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WMProductDetailViewConrollerDelegate <NSObject>

- (void)didChangeSelectedIndex:(NSInteger)selectedIndex;

@end

@interface WMProductDetailViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, weak) id <WMProductDetailViewConrollerDelegate> delegate;

@property (nonatomic, strong) NSArray *products;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

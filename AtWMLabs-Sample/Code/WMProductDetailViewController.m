//
//  WMProductDetailViewController.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailViewController.h"
#import "WMProductDetailContentViewController.h"

@interface WMProductDetailViewController ()

@end

@implementation WMProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    WMProductDetailContentViewController *startingViewController = [self viewControllerAtIndex:self.currentIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


#pragma mark - UIPageViewControllerDataSource -
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((WMProductDetailContentViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    if ([self.delegate respondsToSelector:@selector(didChangeSelectedIndex:)]) {
        [self.delegate didChangeSelectedIndex:index];
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((WMProductDetailContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if ([self.delegate respondsToSelector:@selector(didChangeSelectedIndex:)]) {
        [self.delegate didChangeSelectedIndex:index];
    }

    if (index == [self.products count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (WMProductDetailContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.products count] == 0) || (index >= [self.products count])) {
        return nil;
    }
    
    WMProductDetailContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WMProductDetailContentViewController"];
    
    WMProduct *thisProduct = self.products[index];
    pageContentViewController.product = thisProduct;
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}


@end

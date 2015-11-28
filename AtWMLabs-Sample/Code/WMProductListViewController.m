//
//  WMProductCollectionVC.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductListViewController.h"
#import "WMProductCollectionViewCell.h"
#import "WMProductDetailViewController.h"

@interface WMProductListViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalProducts;
@property (nonatomic) BOOL autoLoading;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation WMProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.products = [NSMutableArray array];
    self.currentPage = 1;
    
    self.autoLoading = YES;
    self.collectionView.scrollsToTop = YES;
    
    if (!isPadDevice) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = @"Loading...";
    
    WMMakeWeakSelf();
    [[WMNetworkManager sharedWMNetworkManager] getProductsWithPageNumber:self.currentPage success:^(id responseData, NSInteger totalProducts) {
        weakSelf.totalProducts = totalProducts;
        NSArray *thisProductList = (NSArray *)responseData;
        
        if (!IsEmpty(thisProductList)) {
            [weakSelf.products addObjectsFromArray:thisProductList];
        }
        
        weakSelf.currentPage++;
        weakSelf.autoLoading = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [weakSelf.collectionView reloadData];
            
            if ([weakSelf.delegate respondsToSelector:@selector(loadedProducts:)]) {
                [weakSelf.delegate loadedProducts:thisProductList];
            }

        });
    } failure:^(NSError *error, NSString *message) {
        weakSelf.autoLoading = NO;
        NSLog(@"Unable to load products");

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            UIAlertController *errorAlert = [UIAlertController
                                             alertControllerWithTitle:@"Error Loading"
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleCancel
                                      handler:^(UIAlertAction *action) {
                                      }];
            
            [errorAlert addAction:confirm];
            [weakSelf presentViewController:errorAlert animated:YES completion:nil];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (self.selectedIndex > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


#pragma mark - UICollectionViewDataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rows = self.products.count;
    if (self.products.count > self.totalProducts) {
        rows = self.totalProducts;
    }

    return rows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WMProduct *thisProduct = [self.products objectAtIndex:indexPath.row];

    WMProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    cell.product = thisProduct;
    cell.productImage.image = nil;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        if (!IsEmpty(thisProduct.productImage)) {
            NSURL *imageURL = [NSURL URLWithString:thisProduct.productImage];
            NSData *productImage = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([cell.product.productId isEqualToString:thisProduct.productId]) {
                    cell.productImage.image = [UIImage imageWithData:productImage];
                }
            });
        }
    });
    
    if (self.products.count < self.totalProducts && indexPath.row == self.products.count-1) {
        [self loadNextPage];
    }

    return cell;
}


#pragma mark - UICollectionViewDelegate -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    WMProductCollectionViewCell *cell = (WMProductCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setHighlighted:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    WMProductCollectionViewCell *cell = (WMProductCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setHighlighted:NO];
}


#pragma mark - Private Methods -
- (void)loadNextPage
{
    if (self.autoLoading) {
        return;
    }
    
    self.autoLoading = YES;
    
    WMMakeWeakSelf();
    [[WMNetworkManager sharedWMNetworkManager] getProductsWithPageNumber:self.currentPage+1 success:^(id responseData, NSInteger totalProducts) {
        weakSelf.totalProducts = totalProducts;
        NSArray *thisProductList = (NSArray *)responseData;
        
        if (!IsEmpty(thisProductList)) {
            [weakSelf.products addObjectsFromArray:thisProductList];
        }
        
        weakSelf.currentPage++;
        weakSelf.autoLoading = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    } failure:^(NSError *error, NSString *message) {
        weakSelf.autoLoading = NO;
        NSLog(@"Unable to load products");
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *errorAlert = [UIAlertController
                                             alertControllerWithTitle:@"Error Loading"
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleCancel
                                      handler:^(UIAlertAction *action) {
                                      }];
            
            [errorAlert addAction:confirm];
            [weakSelf presentViewController:errorAlert animated:YES completion:nil];
        });
    }];
}


#pragma mark - Navigation -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueID = [segue identifier];
    if ([segueID isEqualToString:@"productDetailSegue"]) {
        WMProductDetailViewController *destinationVC = (WMProductDetailViewController *)[segue destinationViewController];
        WMProductCollectionViewCell *cell = (WMProductCollectionViewCell *)sender;
        destinationVC.products = self.products;
        self.selectedIndex = [self.products indexOfObject:cell.product];
        destinationVC.currentIndex = self.selectedIndex;
        destinationVC.delegate = self;
    }
}


#pragma mark - WMProductDetailViewController Delegate Methods -
- (void)didChangeSelectedIndex:(NSInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
}


@end

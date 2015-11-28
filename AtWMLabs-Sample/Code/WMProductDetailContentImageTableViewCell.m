//
//  WMProductDetailContentImageTableViewCell.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailContentImageTableViewCell.h"

@implementation WMProductDetailContentImageTableViewCell

- (void)setProduct:(WMProduct *)product
{
    if (_product != product) {
        _product = product;
    }
    
    [self updateCell];
}

- (void)updateCell
{
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.productImagesScrollView.frame.size.height)];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.0f, self.frame.size.width, self.productImagesScrollView.frame.size.height)];
    imageView2.backgroundColor = [UIColor whiteColor];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*2.0f, 0.0f, self.frame.size.width, self.productImagesScrollView.frame.size.height)];
    imageView3.backgroundColor = [UIColor whiteColor];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    
    self.productImagesScrollView.contentSize = CGSizeMake(self.frame.size.width*3.0f, self.productImagesScrollView.frame.size.height);
    [self.productImagesScrollView addSubview:imageView1];
    [self.productImagesScrollView addSubview:imageView2];
    [self.productImagesScrollView addSubview:imageView3];
    
    self.productImagesScrollView.pagingEnabled = YES;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        if (!IsEmpty(self.product.productImage)) {
            NSURL *imageURL = [NSURL URLWithString:self.product.productImage];
            NSData *productImage = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView1.image = [UIImage imageWithData:productImage];
                imageView2.image = [UIImage imageWithData:productImage];
                imageView3.image = [UIImage imageWithData:productImage];
            });
        }
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.productImagesScrollView.frame.size.width;
    float fractionalPage = self.productImagesScrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}


@end

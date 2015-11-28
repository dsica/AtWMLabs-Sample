//
//  WMProductDetailContentViewController,m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailContentViewController.h"
#import "WMProductDetailContentNameTableViewCell.h"
#import "WMProductDetailContentImageTableViewCell.h"
#import "WMProductDetailContentPriceTableViewCell.h"
#import "WMProductDetailedDescriptionViewController.h"

@interface WMProductDetailContentViewController ()

@end

@implementation WMProductDetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
}

- (void)setProduct:(WMProduct *)product
{
    if (_product != product) {
        _product = product;
    }
}


#pragma mark - UITableViewDataSource methods -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"ProductNameCell";
    
    switch (indexPath.row) {
        case 0:
            CellIdentifier = @"ProductNameCell";
            break;
            
        case 1:
            CellIdentifier = @"ImagesCell";
            break;
            
        case 2:
            CellIdentifier = @"PriceCell";
            break;
            
        case 3:
            CellIdentifier = @"ButtonCell";
            break;
            
        case 4:
            CellIdentifier = @"DescriptionCell";
            break;

        default:
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    switch (indexPath.row) {
        case 0:
        {
            WMProductDetailContentNameTableViewCell *productCell = (WMProductDetailContentNameTableViewCell *)cell;
            productCell.product = self.product;
            break;
        }
            
        case 1:
        {
            WMProductDetailContentImageTableViewCell *imageCell = (WMProductDetailContentImageTableViewCell *)cell;
            imageCell.product = self.product;
            break;
        }
            
        case 2:
        {
            WMProductDetailContentPriceTableViewCell *priceCell = (WMProductDetailContentPriceTableViewCell *)cell;
            priceCell.product = self.product;
            break;
        }
            
        case 3:
        {
            UIButton *addToCartButton = [cell viewWithTag:1];
            addToCartButton.layer.cornerRadius = 4.0f;
            addToCartButton.layer.masksToBounds = YES;
            
            if (self.product.inStock) {
                addToCartButton.enabled = YES;
                [addToCartButton setTitle:@"Add To Cart" forState:UIControlStateNormal];
                [addToCartButton setBackgroundImage:[UIImage imageWithColor:[UIColor wmOrange] size:addToCartButton.frame.size] forState:UIControlStateNormal];
                [addToCartButton setBackgroundImage:[UIImage imageWithColor:[UIColor darkerColorForColor:[UIColor wmOrange]] size:addToCartButton.frame.size] forState:UIControlStateHighlighted];
            }
            else {
                addToCartButton.enabled = NO;
                [addToCartButton setTitle:@"Not In Stock" forState:UIControlStateNormal];
                [addToCartButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:addToCartButton.frame.size] forState:UIControlStateNormal];
                [addToCartButton setBackgroundImage:[UIImage imageWithColor:[UIColor darkerColorForColor:[UIColor wmOrange]] size:addToCartButton.frame.size] forState:UIControlStateHighlighted];
            }
            
            [addToCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [addToCartButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

            CellIdentifier = @"ButtonCell";
            break;
        }
            
        case 4:
        {
            UITextView *descTextView = [cell viewWithTag:2];
            NSAttributedString *shortDesc = [[NSAttributedString alloc] initWithData:[self.product.shortDescription dataUsingEncoding:NSUTF8StringEncoding]
                                                                             options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                       NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                                  documentAttributes:nil
                                                                               error:nil];
            

            NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:shortDesc];
            CGFloat textSize = isPadDevice ? 18.0f : 14.0f;
            [newString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:textSize] range:NSMakeRange(0, [newString length])];

            descTextView.attributedText = newString;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark - UITableViewDelegate Methods -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 4) {
        WMProductDetailedDescriptionViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WMProductDetailedDescriptionViewController"];
        NSAttributedString *longDesc = [[NSAttributedString alloc] initWithData:[self.product.longDescription dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                              documentAttributes:nil
                                                                           error:nil];

        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:longDesc];
        CGFloat textSize = isPadDevice ? 20.0f : 16.0f;
        [newString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:textSize] range:NSMakeRange(0, [newString length])];

        detailVC.textString = newString;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    
    switch (indexPath.row) {
        case 0:
            cellHeight = isPadDevice ? 120.0f : 128.0f;
            break;
            
        case 1:
            cellHeight = isPadDevice ? 527.0f : 175.0f;
            break;
            
        case 2:
            cellHeight = isPadDevice ? 60.0f : 40.0f;
            break;
            
        case 3:
            cellHeight = 44.0f;
            break;
            
        case 4:
            cellHeight = isPadDevice ? 200.0f : 120.0f;
            break;
            
        default:
            break;
    }
    
    return cellHeight;
}


@end

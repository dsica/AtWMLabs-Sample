//
//  WMProductDetailedDescriptionViewController.m
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import "WMProductDetailedDescriptionViewController.h"

@interface WMProductDetailedDescriptionViewController ()

@end

@implementation WMProductDetailedDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Item Description";
    self.textView.attributedText = self.textString;
}


@end

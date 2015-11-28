//
//  WMProductDetailedDescriptionViewController.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/27/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProductDetailedDescriptionViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSAttributedString *textString;

@end

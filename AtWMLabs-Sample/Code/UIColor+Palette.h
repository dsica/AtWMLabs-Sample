//
//  UIColor+Palette.h
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/24/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Palette)

+ (UIColor *)wmBlue;
+ (UIColor *)wmOrange;
+ (UIColor *)darkGrey;
+ (UIColor *)grey;
+ (UIColor *)lightGrey;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)lighterColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForColor:(UIColor *)c;


@end

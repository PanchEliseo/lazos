//
//  ImageUtils.m
//  Lazos
//
//  Created by Sferea on 06/10/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+(UIImage *) imageWithColor:(UIColor *)color
{
	CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, rect);
	UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	return image;
}

@end

//
//  ConfiguraLabel.h
//  Lazos
//
//  Created by sferea on 23/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfiguraLabel : UILabel
@property (nonatomic, assign) IBInspectable CGFloat leftEdge;
@property (nonatomic, assign) IBInspectable CGFloat rightEdge;
@property (nonatomic, assign) IBInspectable CGFloat topEdge;
@property (nonatomic, assign) IBInspectable CGFloat bottomEdge;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@end

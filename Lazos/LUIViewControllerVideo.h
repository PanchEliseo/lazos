//
//  LUIViewControllerVideo.h
//  Lazos
//
//  Created by Programacion on 9/15/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface LUIViewControllerVideo : UIViewController

@property (strong, nonatomic) IBOutlet YTPlayerView *viewVideo;
@property (strong, nonatomic) NSString *urVideo;

@end
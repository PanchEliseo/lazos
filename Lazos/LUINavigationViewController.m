//
//  LUINavigationViewController.m
//  Lazos
//
//  Created by Programacion on 9/15/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUINavigationViewController.h"
#import "LUIViewControllerVideo.h"

@implementation LUINavigationViewController

@synthesize supportedInterfaceOrientatoin = _supportedInterfaceOrientatoin;

@synthesize orientation = _orientation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _supportedInterfaceOrientatoin = UIInterfaceOrientationMaskLandscape;
        _orientation = UIInterfaceOrientationLandscapeLeft;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations

{
    return _supportedInterfaceOrientatoin;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.orientation;
}

@end
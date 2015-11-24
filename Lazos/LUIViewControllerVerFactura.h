//
//  LUIViewControllerVerFactura.h
//  Lazos
//
//  Created by Programacion on 10/9/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerVerFactura : UIViewController

//propiedades del sistema
@property(strong, nonatomic)NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
//
//  LUIDetalleNoticiaViewController.h
//  Lazos
//
//  Created by Programacion on 9/11/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMNoticia.h"

@interface LUIDetalleNoticiaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageNoticia;
@property (weak, nonatomic) IBOutlet UILabel *textoNoticia;
@property (weak, nonatomic) IBOutlet UILabel *fechaNoticia;
@property (strong, nonatomic)LMNoticia *noticia;
@property (weak, nonatomic) IBOutlet UITextView *descripcionNoticia;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

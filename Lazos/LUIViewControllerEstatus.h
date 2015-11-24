//
//  LUIViewControllerEstatus.h
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerEstatus : UIViewController

@property(strong, nonatomic)NSString *estatus;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus1;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus2;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus3;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus4;
@property (weak, nonatomic) IBOutlet UIImageView *sobreEstatus1;
@property (weak, nonatomic) IBOutlet UIImageView *sobreEstatus2;
@property (weak, nonatomic) IBOutlet UIImageView *sobreEstatus3;

@end

//
//  LUICellTableAportaciones.h
//  Lazos
//
//  Created by Programacion on 10/7/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUICellTableAportaciones : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fechaAportaciones;
@property (weak, nonatomic) IBOutlet UILabel *montoAportaciones;
@property (weak, nonatomic) IBOutlet UIButton *botonPDF;
@property (weak, nonatomic) IBOutlet UIButton *botonEnviar;
@property (strong, nonatomic) NSString *tipo;
@property (strong, nonatomic) NSString *resibo;

@end

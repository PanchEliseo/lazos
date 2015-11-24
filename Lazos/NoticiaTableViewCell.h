//
//  NoticiaTableViewCell.h
//  Lazos
//
//  Created by sferea on 07/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiaTableViewCell : UITableViewCell

///Imagen de la noticia
@property (weak, nonatomic) IBOutlet UIImageView *noticiaImagen;

///Breve texto relativa a la noticia
@property (weak, nonatomic) IBOutlet UILabel *noticiaTexto;

@end

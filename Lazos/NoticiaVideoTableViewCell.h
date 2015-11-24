//
//  NoticiaVideoTableViewCell.h
//  Lazos
//
//  Created by sferea on 04/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiaVideoTableViewCell : UITableViewCell

///Imagen del video
@property (weak, nonatomic) IBOutlet UIImageView *videoImagen;

///Título o breve texto relativo al video
@property (weak, nonatomic) IBOutlet UILabel *videoTexto;

@end

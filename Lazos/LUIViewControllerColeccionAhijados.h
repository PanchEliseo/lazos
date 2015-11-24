//
//  LUIViewControllerColeccionAhijados.h
//  Lazos
//
//  Created by Programacion on 9/24/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAhijado.h"

@interface LUIViewControllerColeccionAhijados : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)NSString *data;
@property (strong, nonatomic)NSDictionary *ahijado;
@property (strong, nonatomic)NSMutableArray *ahijadosSeparados;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

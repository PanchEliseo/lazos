//
//  LUtil.h
//  Lazos
//
//  Created by Programacion on 9/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LMPadrino.h"
#import "LManagerObject.h"

@interface LUtil : NSObject

//cabeceras de los metodos de la clase
+ (LUtil *)instance;
-(NSString *)calculateDateLevel:(NSDate *)date;
-(LMPadrino*)oftenPadrino;
-(NSString *)obtenerPDF:(NSString *)url;
- (void)saveData:(NSDictionary *) json methodDave:(LManagerObject*) store contador:(NSInteger) cont response:(NSDictionary *) response;

@end
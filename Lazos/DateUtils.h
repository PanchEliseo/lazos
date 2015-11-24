//
//  DateUtils.h
//  FarmaciasSimilares
//
//  Created by Jorge on 7/27/15.
//  Copyright (c) 2015 Sferea. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @brief  Clase con distintos métodos de apoyo en el manejo de fechas.
 */
@interface DateUtils : NSObject

/*!
*  @brief  Obtiene el nombre completo de un mes.
*
*  @param month Número del mes del que se desea obtener el nombre.
*
*  @return NSString con el nombre del mes indicado o nil si el mes no existe.
*/
+(NSString *)getNameForMonth:(int)month;

/*!
 *  @brief  Obtiene el nombre corto de un mes.
 *
 *  @param month Número del mes del que se desea obtener el nombre.
 *
 *  @return NSString con el nombre corto del mes indicado o nil si el mes no existe.
 */
+(NSString *)getShortNameForMonth:(int)month;

/*!
 *  @brief  Obtiene el número del día de hoy
 *
 *  @return Entero representando el día de la fecha de hoy.
 */
+(int) getDay;

/*!
 *  @brief  Obtiene el número del mes actual.
 *
 *  @return Entero representando el mes de la fecha de hoy.
 */
+(int) getMonth;

/*!
 *  @brief  Obtiene el número del año actual.
 *
 *  @return Entero representando el año de la fecha de hoy.
 */
+(int) getYear;

/*!
 *  @brief  Obtiene el número del día correspondiente a una fecha.
 *
 *  @param date NSDate del cual se desea obtener el día.
 *
 *  @return Entero representando el día de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int)getDayFromDate:(NSDate*)date;

/*!
 *  @brief  Obtiene el número del mes orrespondiente a una fecha.
 *
 *  @param date NSDate del cual se desea obtener el mes.
 *
 *  @return Entero representando el mes de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int) getMonthFromDate:(NSDate*)date;

/*!
 *  @brief  Obtiene el número del año correspondiente a una fecha.
 *
 *  @param date NSDate del cual se desea obtener el año.
 *
 *  @return Entero representando el año de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int) getYearFromDate:(NSDate*)date;

/*!
 *  @brief  Obtiene el nombre corto del mes representado en un string con formato DDMMYYYY.
 *
 *  @param text NSString con formato DDMMYYYY que representa una fecha de la cual se desea obtener el nombre corto del mes.
 *
 *  @return NSString con el nombre del mes o nil en caso de que el parámetro text sea nulo.
 */
+(NSString *)getMonthFromString:(NSString *) text;

/*!
 *  @brief  Obtiene el número del día  representado en un string con formato DDMMYYYY.
 *
 *  @param text NSString con formato DDMMYYYY que representa una fecha de la cual se desea obtener el día.
 *
 *  @return Entero con el número del día indicado en el string o 0 en caso de que el parametro text sea nulo.
 */
+(int)getDayFromString:(NSString *) text;

/*!
 *  @brief  Obtiene un objeto representando la fecha actual.
 *
 *  @return NSDate con la información de la fecha y hora actual.
 */
+(NSDate *) getDate;

/*!
 *  @brief  Obtiene un string con la información de la fecha indicada y con el formato especificado.
 *
 *  @param date   NSDate de la fecha que se quiere transformar en texto.
 *  @param format Formato en el que se desea obtener el string. Ver NSDateFormatter.
 *
 *  @return NSString con el formato indicado y que contiene la información de la fecha o nil en caso de que algún parámetro sea nulo.
 */
+(NSString *) getFullStringFromDate:(NSDate*)date WithFormat:(NSString *) format;

/*!
 *  @brief  Convierte un String con un formato específico en un objeto NSDate.
 *
 *  @param text   NSString a convertir.
 *  @param format Formato de fecha que se muestra en el NSString.
 *
 *  @return Objeto NSDate correspondiente al NSString indicado o nil en caso de que alguno de los parámetros sea nulo.
 */
+(NSDate*) getDateFromString:(NSString *) text WithFormat:(NSString *)format;
@end

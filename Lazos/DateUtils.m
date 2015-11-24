//
//  DateUtils.m
//  FarmaciasSimilares
//
//  Created by Jorge on 7/27/15.
//  Copyright (c) 2015 Sferea. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

///  @brief  Objeto para formatear las fechas y localizarlas.
static NSDateFormatter *dateFormatter;
/// @brief Objeto calendar empleado para manejar fechas dentro de la clase.
static NSCalendar * calendar;

/*!
 *  @brief  Obtiene el nombre completo de un mes.
 *
 *  @param month Número del mes del que se desea obtener el nombre.
 *
 *  @return NSString con el nombre del mes indicado o nil si el mes no existe.
 */
+(NSString *)getNameForMonth:(int)month
{
	//Verifica los parámetros
	if(month<1|| month>12)
		return nil;
	
	//Obtiene el objeto DateFormatter para trabajar con fechas localizadas
	dateFormatter=[DateUtils getDateFormatter];
	//Obtiene le nombre del mes a partir de los símbolos del formateador de fechas y lo capitaliza.
	NSString *monthName = [[[dateFormatter monthSymbols] objectAtIndex:(month-1)] capitalizedString];
	
	//Retorna la cadena con el nombre del mes.
	return monthName;
}

/*!
 *  @brief  Obtiene el nombre corto de un mes.
 *
 *  @param month Número del mes del que se desea obtener el nombre.
 *
 *  @return NSString con el nombre corto del mes indicado o nil si el mes no existe.
 */
+(NSString *)getShortNameForMonth:(int)month
{
	//Verifica los parámetros
	if(month<1|| month>12)
		return nil;
	
	//Obtiene el objeto DateFormatter para trabajar con fechas localizadas
	dateFormatter=[DateUtils getDateFormatter];
	//Obtiene el nombre del mes a partir de los símbolos del formateador de fechas y lo capitaliza.
	NSString *monthName = [[[dateFormatter shortMonthSymbols] objectAtIndex:(month-1)] capitalizedString];
	
	//Retorna la cadena con el nombre del mes.
	return monthName;
}

/*!
 *  @brief  Crea un objeto para formatear las fechas con localización en México.
 *
 *  @return NSDateFormatter con localización en México.
 */
+(NSDateFormatter*) getDateFormatter
{
	if(!dateFormatter)
	{
		dateFormatter=[[NSDateFormatter alloc]init];
		dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
	}
	return dateFormatter;
}

/*!
 *  @brief  Obtiene un objeto del tipo Calendario para ayudar en la manipulación de fechas.
 *
 *  @return NSCalendar empleado por el dispositivo.
 */
+(NSCalendar *)getCalendar
{
	if(!calendar)
		calendar=[NSCalendar currentCalendar];
	return calendar;

}

/*!
 *  @brief  Obtiene el número del día de hoy
 *
 *  @return Entero representando el día de la fecha de hoy.
 */
+(int)getDay
{
	//Obtiene el objeto NSDate que representa la fecha de hoy
	NSDate * today= [NSDate date];
	//Divide la fecha en sus distintos componentes
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:today];
	
	//Devuelve el componente correspondiente con el día
	return (int)[dateComponents day];
}

/*!
 *  @brief  Obtiene el número del mes actual.
 *
 *  @return Entero representando el mes de la fecha de hoy.
 */
+(int) getMonth
{
	//Obtiene el objeto NSDate que representa la fecha de hoy
	NSDate * today= [NSDate date];
	//Divide la fecha en sus distintos componentes
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:today];
	
	//Devuelve el componente correspondiente con el mes
	return (int)[dateComponents month];
}

/*!
 *  @brief  Obtiene el número del año actual.
 *
 *  @return Entero representando el año de la fecha de hoy.
 */
+(int) getYear
{
	//Obtiene el objeto NSDate que representa la fecha de hoy
	NSDate * today= [NSDate date];
	//Divide la fecha en sus distintos componentes
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:today];
	
	//Devuelve el componente correspondiente con el año
	return (int)[dateComponents year];
}

/*!
 *  @brief  Obtiene el número del día de hoy
 *
 *  @param date NSDate del cual se desea obtener el día
 *
 *  @return Entero representando el día de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int)getDayFromDate:(NSDate*)date
{
	//Verifica los parámetros
	if(!date)
		return -1;
	
	//Separa los componentes de la fecha
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
	
	//Devuelve el componente correspondiente al día
	return (int)[dateComponents day];
}

/*!
 *  @brief  Obtiene el número del mes orrespondiente a una fecha.
 *
 *  @param date NSDate del cual se desea obtener el mes.
 *
 *  @return Entero representando el mwa de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int) getMonthFromDate:(NSDate*)date
{
	//Verifica los parámetros
	if(!date)
		return -1;
	
	//Separa los componentes de la fecha
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
	
	//Devuelve el componente correspondiente al mes
	return (int)[dateComponents month];
}

/*!
 *  @brief  Obtiene el número del año correspondiente a una fecha.
 *
 *  @param date NSDate del cual se desea obtener el año.
 *
 *  @return Entero representando el año de la fecha indicada o -1 en caso de que no se proporcione el parámetro date.
 */
+(int) getYearFromDate:(NSDate*)date
{
	//Verifica los parámetros
	if(!date)
		return -1;
	
	//Separa los componentes de la fecha
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
	
	//Devuelve el componente correspondiente al año
	return (int)[dateComponents year];
}

/*!
 *  @brief  Obtiene el nombre corto del mes representado en un string con formato DDMMYYYY.
 *
 *  @param text NSString con formato DDMMYYYY que representa una fecha de la cual se desea obtener el nombre corto del mes.
 *
 *  @return NSString con el nombre del mes o nil en caso de que el parámetro text sea nulo.
 */
+(NSString *)getMonthFromString:(NSString *) text
{
	//Verifica los parámetros
	if(!text)
		return nil;
	
	//Obtiene el formateador de fechas.
	dateFormatter=[DateUtils getDateFormatter];
	//Establece el formato de entrada de la fecha.
	[dateFormatter setDateFormat:@"DDMMYYYY"];
	
	//Crea un objeto NSDate a partir del string y el formateador.
	NSDate * date=[dateFormatter dateFromString:text];
	//Separa los distintos componentes de la fecha creada.
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
	
	//Obtiene el componente correspondiente al mes dentro de la fecha
	int month=(int)[dateComponents month] ;
	
	//Devuelve el nombre corto del mes.
	return [DateUtils getShortNameForMonth:month];

}

/*!
 *  @brief  Obtiene el número del día  representado en un string con formato DDMMYYYY.
 *
 *  @param text NSString con formato DDMMYYYY que representa una fecha de la cual se desea obtener el día.
 *
 *  @return Entero con el número del día indicado en el string o 0 en caso de que el parametro text sea nulo.
 */
+(int)getDayFromString:(NSString *) text
{
	//Verifica los parámetros
	if(!text)
		return 0;

	//Obtiene el formateador de fechas.
	dateFormatter=[DateUtils getDateFormatter];
	//Establece el formato de entrada de la fecha.
	[dateFormatter setDateFormat:@"DDMMYYYY"];
	
	//Crea un objeto NSDate a partir del string y el formateador.
	NSDate * date=[dateFormatter dateFromString:text];
	//Separa los distintos componentes de la fecha creada.
	NSDateComponents * dateComponents=[[DateUtils getCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
	
	//Obtiene el componente correspondiente al día dentro de la fecha
	int day=(int)[dateComponents day];
	
	//Devuelve el número del día.
	return day;
	
}

/*!
 *  @brief  Obtiene un objeto representando la fecha actual.
 *
 *  @return NSDate con la información de la fecha y hora actual.
 */
+(NSDate *)getDate
{
    NSDate * today= [NSDate date];
    return today;
}

/*!
 *  @brief  Obtiene un string con la información de la fecha indicada y con el formato especificado.
 *
 *  @param date   NSDate de la fecha que se quiere transformar en texto.
 *  @param format Formato en el que se desea obtener el string. Ver NSDateFormatter.
 *
 *  @return NSString con el formato indicado y que contiene la información de la fecha o nil en caso de que algún parámetro sea nulo.
 */
+(NSString *)getFullStringFromDate:(NSDate *)date WithFormat:(NSString *)format
{
	//Verifica los parámetros
    if(!date || !format || date==(id)[NSNull null])
        return nil;
	
	//Crea el formateador de la fecha
    NSDateFormatter *dateFormatter = [DateUtils getDateFormatter];
	//Indica el formato en el que se desea obtener el string
    [dateFormatter setDateFormat:format];
	//Crea el string con el formateador y la fecha indicada.
    NSString *dateString = [dateFormatter stringFromDate:date];
	
	//Devuelve el string creado.
	return dateString;
}

/*!
 *  @brief  Convierte un String con un formato específico en un objeto NSDate.
 *
 *  @param text   NSString a convertir.
 *  @param format Formato de fecha que se muestra en el NSString.
 *
 *  @return Objeto NSDate correspondiente al NSString indicado o nil en caso de que alguno de los parámetros sea nulo.
 */
+(NSDate*)getDateFromString:(NSString *)text WithFormat:(NSString *)format
{
    //Verifica los parámetros
    if(!text || !format || text==(id)[NSNull null])
        return nil;
    
    //Crea el formateador de fechas
    NSDateFormatter * formatter = [DateUtils getDateFormatter];
	//Establece el formato de la fecha.
    [formatter setDateFormat:format];
    
    //Obtiene la fecha a partir del string con el formato indicado
    NSDate * date=[formatter dateFromString:text];
	
	//Retorna el objeto NSDate creado
    return date;
}
@end

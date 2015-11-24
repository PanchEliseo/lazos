//
//  LConstants.m
//  Lazos
//
//  Created by Programacion on 9/4/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LConstants.h"

@implementation LConstants

//Variables globales
NSString * LSession = @"sesion";
NSString * LRespuestaPeticionPadrino = @"Datos incorrectos";
NSString * LMensajePeticionPadrino = @"mensaje";
NSString * LMenuNoticiasMensaje = @"menu noticias";
NSString * LTabBarRegistrar = @"registrar";
//Variable global para las notificaciones
NSString * LSessionN1 = @"sesionNotificacion1";
NSString * LSessionN2 = @"sesionNotificacion2";
NSString * LSessionN3 = @"sesionNotificacion2";

//Constantes de el parseo en el LServicesObjectLogin
NSString * LTableNamePadrino = @"LMPadrino";
NSString * LNipPadrino = @"nip_p_c";
NSString * LNoAhijados = @"no_ahijados_c";
NSString * LFechaPadrino = @"date_entered";
NSString * LNombrePadrino = @"first_name";
NSString * LApellidoPaternoPadrino = @"last_name";
NSString * LApellidoMaternoPadrino = @"apellido_materno_c";
NSString * LTokenPadrino = @"token";
NSString * LGeneroPadrino = @"genero_c";
NSString * LPadrinoRFC = @"rfc_c";
NSString * LPadrino = @"Padrino";

//Inteface LMNoticia
NSString * LTableNameNoticia = @"LMNoticia";
//Etiqueta del arreglo "noticias" en el JSON
NSString * LNoticia = @"noticias";
//Etiquetas de las estructuras de "noticias" en el JSON
NSString * LId_Noticia = @"id";
NSString * LTitulo = @"titulo";
NSString * LNoticia_Descripcion = @"descripcion";
NSString * LFechaNoticia = @"fecha";
NSString * LHora = @"hora";
NSString * LUrl_Imagen = @"url_imagen";
NSString * LUrl_Video = @"url_video";
NSString * LTipo_Noticia = @"tipo";
NSString * LMostrar = @"mostrar";

//constantes en la clase UIControllerMain
NSString * LCustomCellMenu = @"CustomCell";
NSString * LHeaderCellMenu = @"LHeaderCell";
NSString * LFooterCellMenu = @"LFooterCell";
NSString * LMenuAhijados = @"ahijados";
NSString * LMenuBuzon = @"buzon";
NSString * LMenuNoticias = @"noticias";
NSString * LMenuAportaciones = @"aportaciones";
NSString * LMenuLogros = @"logros";
NSString * LMenuAjustes = @"ajustes";

//constantes de el servicio de galeria
NSString * LAhijado = @"ahijado";
NSString * LFoto = @"foto";

//constante servidor
NSString * LServicio = @"https://201.175.10.244/";

//Constantes de el parseo en el LServicesObjectAhijado
NSString * LTableNameAhijado = @"LMAhijado";
//Etiqueta del arreglo "Ahijados" en el JSON
NSString * LAhijadoJson = @"Ahijados";
//Etiquetas de las estructuras de "Ahijados" en el JSON
NSString * LApellidoMaternoAhijado = @"apellido_materno_c";
NSString * LApellidoPaternoAhijado = @"last_name";
NSString * LCalificacionCiencias = @"ciencias";
NSString * LCalificacionEspanol = @"espanol";
NSString * LCalificacionMatematicas = @"mate";
NSString * LCicloEscolar = @"ciclo_c";
NSString * LFechaNacimientoAhijado = @"fecha_nacimiento_c";
NSString * LFilial = @"filial_c";
NSString * LFotoAhijado = @"foto2_c";
NSString * LGrado = @"grado";
NSString * LGrupo = @"grupo";
NSString * LGustos = @"Gustos y pasatiempos del ahijado";
NSString * LNipAhijado = @"nip";
NSString * LNombreAhijado = @"first_name";
NSString * LNombreEscuela = @"nombre de la escuela";
NSString * LNivel = @"nivel";
NSString * LTallaCalzado = @"tallaropa_c";
NSString * LTallaRopa = @"tallacalzado_c";
NSString * LNipEscuela = @"nip_esc_c";
NSString * LCalificaciones = @"Calificaciones";
NSString * LMensajeAhijados = @"mensaje";
NSString * LDatosIncorrectos = @"Datos incorrectos";

//constantes de buzon
NSString * LBuzon = @"buzon_enviados";
NSString * LTipoCartas = @"tipo";
NSString * LDescripcion = @"description";
NSString * LFechaBuzon = @"date_entered";
NSString * LName = @"name";
NSString * LFilialBuzon = @"filial_c";
NSString * LNipPadrinoBuzon = @"nip_p_c";
NSString * LStatusBuzon = @"status";
NSString * LIdBuzon = @"id";

//constantes buzon recibidos
NSString * LBuzonRecibidos = @"Recibidos";
NSString * LBuzonRecibidosApellido = @"apellido_ahijado";
NSString * LBuzonRecibidosCaso = @"caso";
NSString * LBuzonRecibidosCategoria = @"categoria";
NSString * LBuzonRecibidosFecha = @"fecha";
NSString * LBuzonRecibidosFotoAhijado = @"foto_ahijado";
NSString * LBuzonRecibidosHora = @"hora";
NSString * LBuzonRecibidosId = @"id";
NSString * LBuzonRecibidosIdAhijado = @"id_ahijado";
NSString * LBuzonRecibidosIdPadrino = @"id_padrino";
NSString * LBuzonRecibidosNipAhijado = @"nip_ahijado";
NSString * LBuzonRecibidosNipPadrino = @"nip_padrino";
NSString * LBuzonRecibidosNombre = @"nombre_ahijado";
NSString * LBuzonRecibidosTexto = @"texto";
NSString * LBuzonRecibidosTitulo = @"titulo";
NSString * LBuzonRecibidosTipo = @"tipo";
NSString * LBuzonRecibidosUrlImagenOpcional = @"url_imagen_opcional";
NSString * LBuzonRecibidosUrlImagenRespuesta = @"url_imagen_respuesta";

//constantes de Aportaciones
NSString * LAportaciones = @"Pagos";
NSString * LFechaCargoAportacion = @"fecha de cargo";
NSString * LMontoAportacion = @"monto";
NSString * LPeriodicidadAportacion = @"periodicidad";
NSString * LResiboAportacion = @"resibo_c";
NSString * LXmlAportacion = @"xml";


///Constantes de Logros
NSString * LLogro = @"logros";
NSString * LAhijados_1 = @"ahijados_1";
NSString * LAhijados_2 = @"ahijados_2";
NSString * LAhijados_3 = @"ahijados_3";
NSString * LAhijados_mas_3 = @"ahijados_mas_3";
NSString * LRegalos_1 = @"regalos_1";
NSString * LRegalos_2 = @"regalos_2";
NSString * LRegalos_3 = @"regalos_3";
NSString * LRegalos_mas_3 = @"regalos_mas_3";
NSString * LCartas_2 = @"cartas_2";
NSString * LCartas_4 = @"cartas_4";
NSString * LCartas_6 = @"cartas_6";
NSString * LCartas_mas_8 = @"cartas_mas_8";
NSString * LCompartir_1 = @"compartir_1";
NSString * LCompartir_mas_1 = @"compartir_mas_1";
NSString * LVisita = @"visita";
NSString * LAportacion_Adicional = @"a_adicional";

//Constantes Galeria
NSString * LGaleriaAhijado = @"Galeria";
NSString * LGaleriaFotosAhijado = @"foto_ahijado";
NSString * LGaleriaNipAhijado = @"nip_ahijado";


@end
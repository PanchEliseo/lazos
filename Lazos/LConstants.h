//
//  STConstants.h
//  Lazos
//
//  Created by Programacion on 9/4/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LConstants : NSObject

//variables globales
extern NSString * LSession;
extern NSString * LRespuestaPeticionPadrino;
extern NSString * LMensajePeticionPadrino;
extern NSString * LMenuNoticiasMensaje;
extern NSString * LTabBarRegistrar;
//Variable global para las notificaciones
extern NSString * LSessionN1;
extern NSString * LSessionN2;
extern NSString * LSessionN3;

//variables de el parseo del json en la clase LServicesObjectLogin
extern NSString * LTableNamePadrino;
extern NSString * LNipPadrino;
extern NSString * LNoAhijados;
extern NSString * LFechaPadrino;
extern NSString * LNombrePadrino;
extern NSString * LApellidoPaternoPadrino;
extern NSString * LApellidoMaternoPadrino;
extern NSString * LTokenPadrino;
extern NSString * LGeneroPadrino;
extern NSString * LPadrino;
extern NSString * LPadrinoRFC;

//Variables de Noticias, se definen en LConstants.m
extern NSString * LTableNameNoticia;
extern NSString * LId_Noticia;
extern NSString * LTitulo;
extern NSString * LNoticia_Descripcion;
extern NSString * LFechaNoticia;
extern NSString * LHora;
extern NSString * LUrl_Imagen;
extern NSString * LUrl_Video;
extern NSString * LTipo_Noticia;
extern NSString * LMostrar;
extern NSString * LNoticia;

//Variables de clase UIControllerMain
extern NSString * LCustomCellMenu;
extern NSString * LHeaderCellMenu;
extern NSString * LFooterCellMenu;
extern NSString * LMenuAhijados;
extern NSString * LMenuBuzon;
extern NSString * LMenuNoticias;
extern NSString * LMenuAportaciones;
extern NSString * LMenuLogros;
extern NSString * LMenuAjustes;

//Variables de peticion galeria
extern NSString * LAhijado;
extern NSString * LFoto;

//constante servidor
extern NSString * LServicio;

//Variables del parseo del json en la clase LServicesObjectAhijado
extern NSString * LTableNameAhijado;
extern NSString * LAhijadoJson;
extern NSString * LApellidoMaternoAhijado;
extern NSString * LApellidoPaternoAhijado;
extern NSString * LCalificacionCiencias;
extern NSString * LCalificacionEspanol;
extern NSString * LCalificacionMatematicas;
extern NSString * LCicloEscolar;
extern NSString * LFechaNacimientoAhijado;
extern NSString * LFilial;
extern NSString * LFotoAhijado;
extern NSString * LGrado;
extern NSString * LGrupo;
extern NSString * LGustos;
extern NSString * LNipAhijado;
extern NSString * LNombreAhijado;
extern NSString * LNombreEscuela;
extern NSString * LNivel;
extern NSString * LTallaCalzado;
extern NSString * LTallaRopa;
extern NSString * LNipEscuela;
extern NSString * LCalificaciones;
extern NSString * LMensajeAhijados;
extern NSString * LDatosIncorrectos;

//constantes de buzon
extern NSString * LBuzon;
extern NSString * LTipoCartas;
extern NSString * LDescripcion;
extern NSString * LFechaBuzon;
extern NSString * LName;
extern NSString * LFilialBuzon;
extern NSString * LNipPadrinoBuzon;
extern NSString * LStatusBuzon;
extern NSString * LIdBuzon;

//constantes buzon recibidos
extern NSString * LBuzonRecibidos;
extern NSString * LBuzonRecibidosApellido;
extern NSString * LBuzonRecibidosCaso;
extern NSString * LBuzonRecibidosCategoria;
extern NSString * LBuzonRecibidosFecha;
extern NSString * LBuzonRecibidosFotoAhijado;
extern NSString * LBuzonRecibidosHora;
extern NSString * LBuzonRecibidosId;
extern NSString * LBuzonRecibidosIdAhijado;
extern NSString * LBuzonRecibidosIdPadrino;
extern NSString * LBuzonRecibidosNipAhijado;
extern NSString * LBuzonRecibidosNipPadrino;
extern NSString * LBuzonRecibidosNombre;
extern NSString * LBuzonRecibidosTexto;
extern NSString * LBuzonRecibidosTitulo;
extern NSString * LBuzonRecibidosTipo;
extern NSString * LBuzonRecibidosUrlImagenOpcional;
extern NSString * LBuzonRecibidosUrlImagenRespuesta;

//constantes de Aportaciones
extern NSString * LAportaciones;
extern NSString * LFechaCargoAportacion;
extern NSString * LMontoAportacion;
extern NSString * LPeriodicidadAportacion;
extern NSString * LResiboAportacion;
extern NSString * LXmlAportacion;


///Constantes de Logros
extern NSString * LLogro;
extern NSString * LAhijados_1;
extern NSString * LAhijados_2;
extern NSString * LAhijados_3;
extern NSString * LAhijados_mas_3;
extern NSString * LRegalos_1;
extern NSString * LRegalos_2;
extern NSString * LRegalos_3;
extern NSString * LRegalos_mas_3;
extern NSString * LCartas_2;
extern NSString * LCartas_4;
extern NSString * LCartas_6;
extern NSString * LCartas_mas_8;
extern NSString * LCompartir_1;
extern NSString * LCompartir_mas_1;
extern NSString * LVisita;
extern NSString * LAportacion_Adicional;

//Constantes Galeria
extern NSString * LGaleriaAhijado;
extern NSString * LGaleriaFotosAhijado;
extern NSString * LGaleriaNipAhijado;

@end

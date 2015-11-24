//
//  BuzonRecibidosViewController.m
//  Lazos
//
//  Created by sferea on 28/10/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "BuzonRecibidosViewController.h"
#import "LConstants.h"
#import "BuzonCartaTableViewCell.h"
#import "BuzonRegaloTableViewCell.h"
#import "LConstants.h"
#import "UIImageView+WebCache.h"
#import "LMAhijado.h"
#import "LManagerObject.h"
#import "LMBuzonRecibidos.h"

@interface BuzonRecibidosViewController ()

@end

@implementation BuzonRecibidosViewController

///Identificador de la celda para Regalos
static NSString *CellIdBuzonRegalo = @"BuzonRegaloTableViewCell";
///Identificador de la celda para Cartas
static NSString *CellIdBuzonCarta = @"BuzonCartaTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"que tiene ya en el view controller a pintar %@", self.response);
    if([self.tipoMenu isEqualToString:@"ahijados"]){
        self.constraintButton.constant = 152;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewDelegate
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark - UIViewDataSource
///Informa al table view cuantas filas habrá en la sección dependiendo de la cantidad de mensajes de cartas y regalos en el buzón de Recibidos
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.response[LBuzonRecibidos] count];
}

///Se llama a éste método cuando la tabla es mostrada
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LTipoCartas] isEqualToString:@"Cartas"]){
        ///Reutiliza la celda si existe
        BuzonCartaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdBuzonCarta];
        ///Crea la celda si no existe
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdBuzonCarta owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.tituloCarta.text = [[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosTitulo];
        cell.descripcionCarta.text = [[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosTexto];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        //se le da el formato requerido a la fecha
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * fecha = [dateFormatter dateFromString:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosFecha]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"dd/MMMM/YYYY"];
        NSString *resultDate = [formatter stringFromDate:fecha];
        cell.fechaCarta.text = resultDate;
        [cell.imagenAhijadoCarta sd_setImageWithURL:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosFotoAhijado] placeholderImage:[UIImage alloc]];
        return cell;
    }else{
        ///Reutiliza la celda si existe
        BuzonRegaloTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdBuzonRegalo];
        ///Crea la celda si no existe
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdBuzonRegalo owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.bRegaloSaludo.text = [[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosTitulo];
        cell.bRegaloMensaje.text = [[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosTexto];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        //se le da el formato requerido a la fecha
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * fecha = [dateFormatter dateFromString:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosFecha]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"dd/MMMM/YYYY"];
        NSString *resultDate = [formatter stringFromDate:fecha];
        cell.bRegaloFecha.text = resultDate;
        [cell.bRegaloFoto sd_setImageWithURL:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosFotoAhijado] placeholderImage:[UIImage alloc]];
        return cell;
    }
    
    return nil;
}

///Establece la altura de las filas del Table View de Enviados
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height / 5;

}

/**
 Metodo que controla el click sobre los elementos de la tabla de las noticias
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"------------------ %@", self.response[LBuzonRecibidos]);
    NSLog(@"que de que %@", [[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosNipAhijado]);
    if(self.response){
        if([self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]]){
            
            LManagerObject *store = [LManagerObject sharedStore];
            //se obtiene el padrino de la base
            NSArray *recibidos = [store showData:@"LMBuzonRecibidos"];
            if(recibidos.count != 0){
                LMBuzonRecibidos *recibidosBase = [recibidos objectAtIndex:0];
                //se borra el unico padrino para guardar el nuevo que entre, para solo guardar el ultimo que entro a la aplicacion
                [store deleteData:recibidosBase];
                
                [self saveData:indexPath.row];
            }else{
                [self saveData:indexPath.row];
            }
            //Variable de preferencias
            //[[NSUserDefaults standardUserDefaults] setObject:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosNipAhijado] forKey:@"LNipAhijado"];
            [[NSUserDefaults standardUserDefaults] setObject:@"recibidos" forKey:@"idBuzon"];
            [self.parentViewController performSegueWithIdentifier:@"mensajes" sender:self.parentViewController];
        }else{
            LManagerObject *store = [LManagerObject sharedStore];
            //se obtiene el padrino de la base
            NSArray *recibidos = [store showData:@"LMBuzonRecibidos"];
            if(recibidos.count != 0){
                LMBuzonRecibidos *recibidosBase = [recibidos objectAtIndex:0];
                //se borra el unico padrino para guardar el nuevo que entre, para solo guardar el ultimo que entro a la aplicacion
                [store deleteData:recibidosBase];
                
                [self saveData:indexPath.row];
            }else{
                [self saveData:indexPath.row];
            }
            //Variable de preferencias
            //[[NSUserDefaults standardUserDefaults] setObject:[[self.response[LBuzonRecibidos] objectAtIndex:indexPath.row] objectForKey:LBuzonRecibidosNipAhijado] forKey:@"LNipAhijado"];
            [[NSUserDefaults standardUserDefaults] setObject:@"recibidos" forKey:@"idBuzon"];
            [self.parentViewController performSegueWithIdentifier:@"mensajesSubMenu" sender:self.parentViewController];
        }
    }
}

-(void)saveData:(NSInteger) posicion{
    LManagerObject *store = [LManagerObject sharedStore];
    NSLog(@"el que pulso %@", [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosFecha]);
    NSString *apellidos = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosApellido];
    NSNumber *caso = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosCaso] integerValue]);
    NSString *categoria = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosCategoria];
    NSString *fecha = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosFecha];
    NSString *foto = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosFotoAhijado];
    NSString *hora = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosHora];
    NSNumber *idBuzon = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosId] integerValue]);
    NSNumber *idAhijado = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosIdAhijado] integerValue]);
    NSNumber *idPadrino = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosIdPadrino] integerValue]);
    NSNumber *nipAhijado = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosNipAhijado] integerValue]);
    NSNumber *nipPadrino = @([[[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosNipPadrino] integerValue]);
    NSString *nombre = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosNombre];
    NSString *texto = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosTexto];
    NSString *tipo = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosTipo];
    NSString *titulo = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosTitulo];
    NSString *urlOpcional = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosUrlImagenOpcional];
    NSString *urlRespuesta = [[self.response[LBuzonRecibidos] objectAtIndex:posicion] objectForKey:LBuzonRecibidosUrlImagenRespuesta];
    NSString *fechaCompleta = [NSString stringWithFormat:@"%@%@%@", fecha, @" ", hora];
    
    [store saveDataRecibidos:apellidos caso:caso categoria:categoria fecha:fechaCompleta foto:foto hora:hora id_buzon:idBuzon id_ahijado:idAhijado id_padrino:idPadrino nip_ahijado:nipAhijado nip_padrino:nipPadrino nombre:nombre texto:texto tipo:tipo titulo:titulo url_imagen_opcional:urlOpcional url_imagen_respuesta:urlRespuesta];
}

@end

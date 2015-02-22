//
//  ALFooterLabelView.m
//  Allianz
//
//  Created by Matías Ginart on 8/2/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "EjercicioView.h"
#import "UIFont+ALFonts.h"
#import "UIColor+ALColor.h"
#import "Barra.h"

#define kXOffset 5
#define kYOffset 5
#define kBarraHeight 30

@interface EjercicioView()
@property(nonatomic,strong)IBOutlet UILabel *titulo;
@property(nonatomic,strong)IBOutlet UILabel *detalle;
@property(nonatomic,strong)IBOutlet UIView  *barras;
@property(nonatomic,strong)IBOutlet UIButton *botonComenzar;
@property(nonatomic,strong)Ejercicio *ejercicio;
@end

@implementation EjercicioView

+ (EjercicioView*)View {
    EjercicioView* viewToReturn = [[NSBundle mainBundle] loadNibNamed:@"EjercicioView" owner:self options:nil][0];
    return viewToReturn;
}

- (void)fillWithEjercicio:(Ejercicio *)ejercicio{
    self.ejercicio = ejercicio;
    self.titulo.text = ejercicio.nombre;
    self.detalle.text = ejercicio.detalle;

    CGSize size = [self.detalle sizeThatFits:CGSizeMake(self.detalle.frame.size.width - kXOffset*2, 10000)];
    self.detalle.frame = CGRectMake(self.detalle.frame.origin.x,self.detalle.frame.origin.y, self.detalle.frame.size.width, size.height);
//Barras
    //Hallo el máximo
    CGFloat maxWidth = 0;
    for (NSNumber *repeticion in ejercicio.repeticiones) {
        if (repeticion.floatValue > maxWidth) {
            maxWidth = repeticion.floatValue;
        }
    }
    for (NSNumber *tiempo in ejercicio.tiemposEntreRepeticiones) {
        if (tiempo.floatValue > maxWidth) {
            maxWidth = tiempo.floatValue;
        }
    }
    
    //Creo las barras
    CGFloat yOffset = kYOffset;
    for (NSInteger i = 0; i < ejercicio.repeticiones.count; i++) {
        NSNumber *repeticion = ejercicio.repeticiones[i];
        
        Barra *barra = [[Barra alloc] initWithFrame:CGRectMake(kBarraHeight + kXOffset * 2, yOffset, (self.barras.frame.size.width - 3*kXOffset - kBarraHeight)*repeticion.floatValue/maxWidth, kBarraHeight)];
        barra.showsText = NO;
        barra.color = [[UIColor greenColor] colorWithAlphaComponent:.8];
        barra.mode = BarraModoHorizontal;
        [barra setValorAnimated:@1];

        [self.barras addSubview:barra];
        //Icono de la barra
        UIImageView *icono;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
            icono = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Mis_Rutinas"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            icono.tintColor = [UIColor whiteColor];
        }else{
            icono = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Mis_Rutinas"]];
        }
        icono.contentMode = UIViewContentModeScaleAspectFit;
        icono.frame = CGRectMake(0, yOffset, kBarraHeight, kBarraHeight);
        [self.barras addSubview:icono];
        //
        
        yOffset = barra.frame.origin.y + barra.frame.size.height + kYOffset/2;

        UILabel *descripcionBarra = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset * 3, yOffset, self.barras.frame.size.width - 4*kXOffset, 15)];
        descripcionBarra.font = [UIFont systemFontOfSize:14];
        descripcionBarra.backgroundColor = [UIColor clearColor];
        descripcionBarra.textColor = [UIColor ALLightBlueColor];
        descripcionBarra.text = [NSString stringWithFormat:@"%d repeticiones. Peso: %dKg.",repeticion.intValue,[ejercicio.pesos[i] intValue]];
        [self.barras addSubview:descripcionBarra];

        yOffset = descripcionBarra.frame.origin.y + descripcionBarra.frame.size.height + kYOffset *2;

        // Si no es la última repetición agrego pausa
        if (i < ejercicio.repeticiones.count - 1) {
            NSNumber *pausa = ejercicio.tiemposEntreRepeticiones[i];
            Barra *barraPausa = [[Barra alloc] initWithFrame:CGRectMake(kBarraHeight + kXOffset * 2, yOffset, (self.barras.frame.size.width - 3*kXOffset - kBarraHeight)*pausa.floatValue/maxWidth, kBarraHeight)];
            barraPausa.showsText = NO;
            barraPausa.color = [[UIColor yellowColor] colorWithAlphaComponent:.8];
            barraPausa.mode = BarraModoHorizontal;
            [barraPausa setValorAnimated:@1];
            [self.barras addSubview:barraPausa];
            
            //Icono de la barra
            UIImageView *icono;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
                icono = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"clock"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
                icono.tintColor = [UIColor whiteColor];
            }else{
                icono = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock"]];
            }
            icono.contentMode = UIViewContentModeScaleAspectFit;
            icono.frame = CGRectMake(0, yOffset, kBarraHeight - 2, kBarraHeight - 2);
            [self.barras addSubview:icono];
            //

            
            yOffset = barraPausa.frame.origin.y + kBarraHeight + kYOffset/2;

            UILabel *descripcionBarraPausa = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset *3, yOffset, self.barras.frame.size.width - 4*kXOffset, 22)];
            descripcionBarraPausa.backgroundColor = [UIColor clearColor];
            descripcionBarraPausa.font = [UIFont systemFontOfSize:14];
            descripcionBarraPausa.textColor = [UIColor ALLightBlueColor];
            descripcionBarraPausa.text = [NSString stringWithFormat:@"Descanzar %d segundos.",pausa.intValue];
            yOffset = descripcionBarraPausa.frame.origin.y + descripcionBarraPausa.frame.size.height + kYOffset * 2;
            [self.barras addSubview:descripcionBarraPausa];
        }
    }
    
    self.barras.frame = CGRectMake(self.barras.frame.origin.x, self.detalle.frame.origin.y + self.detalle.frame.size.height + kYOffset, self.barras.frame.size.width, yOffset);
//
    
    self.botonComenzar.frame = CGRectMake(self.botonComenzar.frame.origin.x, self.barras.frame.origin.y + self.barras.frame.size.height + kYOffset, self.botonComenzar.frame.size.width, self.botonComenzar.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.botonComenzar.frame.origin.y + self.botonComenzar.frame.size.height + kYOffset*3);
    
    //Como se desacomodo todo, vuelvo a acomodarlo
    self.detalle.frame = CGRectMake(self.detalle.frame.origin.x,self.titulo.frame.origin.y + self.titulo.frame.size.height + kYOffset, self.detalle.frame.size.width, size.height);

    self.barras.frame = CGRectMake(self.barras.frame.origin.x, self.detalle.frame.origin.y + self.detalle.frame.size.height + kYOffset, self.barras.frame.size.width, yOffset);
    
    self.botonComenzar.frame = CGRectMake(self.botonComenzar.frame.origin.x, self.barras.frame.origin.y + self.barras.frame.size.height + kYOffset, self.botonComenzar.frame.size.width, self.botonComenzar.frame.size.height);
}

- (IBAction)start{
    [self.delegate ejercicioView:self wantStartEjercicio:self.ejercicio];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.titulo.frame = CGRectMake(self.titulo.frame.origin.x, self.titulo.frame.origin.y, self.frame.size.width - self.titulo.frame.origin.x*2, self.titulo.frame.size.height);

    self.detalle.frame = CGRectMake(self.detalle.frame.origin.x, self.detalle.frame.origin.y, self.frame.size.width - self.detalle.frame.origin.x*2, self.detalle.frame.size.height);

    self.barras.frame = CGRectMake(self.barras.frame.origin.x, self.barras.frame.origin.y, self.frame.size.width - self.barras.frame.origin.x*2, self.barras.frame.size.height);

    self.botonComenzar.center = CGPointMake(self.frame.size.width/2, self.botonComenzar.center.y);
}

@end

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
@end

@implementation EjercicioView

+ (EjercicioView*)View {
    EjercicioView* viewToReturn = [[NSBundle mainBundle] loadNibNamed:@"EjercicioView" owner:self options:nil][0];
    return viewToReturn;
}

- (void)fillWithEjercicio:(Ejercicio *)ejercicio{
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
        
        Barra *barra = [[Barra alloc] initWithFrame:CGRectMake(kXOffset, yOffset, (self.barras.frame.size.width - 2*kXOffset)*repeticion.floatValue/maxWidth, kBarraHeight)];
        barra.color = [UIColor greenColor];
        barra.mode = BarraModoHorizontal;
        [barra setValorAnimated:@1];

        yOffset = barra.frame.origin.y + barra.frame.size.height + kYOffset;
        [self.barras addSubview:barra];
        
        UILabel *descripcionBarra = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, yOffset, self.barras.frame.size.width - 2*kXOffset, 22)];
        descripcionBarra.backgroundColor = [UIColor clearColor];
        descripcionBarra.textColor = [UIColor whiteColor];
        descripcionBarra.text = [NSString stringWithFormat:@"%d repeticiones. Peso: %dKg.",repeticion.intValue,[ejercicio.pesos[i] intValue]];
        yOffset = descripcionBarra.frame.origin.y + descripcionBarra.frame.size.height + kYOffset;
        [self.barras addSubview:descripcionBarra];
        
//        // Si no es la última repetición agrego pausa
        if (i < ejercicio.repeticiones.count - 1) {
            NSNumber *pausa = ejercicio.tiemposEntreRepeticiones[i];
            Barra *barraPausa = [[Barra alloc] initWithFrame:CGRectMake(kXOffset, yOffset, (self.barras.frame.size.width - 2*kXOffset)*pausa.floatValue/maxWidth, kBarraHeight)];
            barraPausa.color = [UIColor yellowColor];
            yOffset = barraPausa.frame.origin.y + barraPausa.frame.size.height + kYOffset;
            barraPausa.mode = BarraModoHorizontal;
            [barraPausa setValorAnimated:@1];
            [self.barras addSubview:barraPausa];
            
            UILabel *descripcionBarraPausa = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, kYOffset, self.barras.frame.size.width - 2*kXOffset, 22)];
            descripcionBarraPausa.backgroundColor = [UIColor clearColor];
            descripcionBarraPausa.textColor = [UIColor whiteColor];
            descripcionBarraPausa.text = [NSString stringWithFormat:@"Descanzar %d segundos.",pausa.intValue];
            yOffset = descripcionBarraPausa.frame.origin.y + descripcionBarraPausa.frame.size.height + kYOffset;
            [self.barras addSubview:descripcionBarraPausa];
        }
    }
    
    self.barras.frame = CGRectMake(self.barras.frame.origin.x, self.detalle.frame.origin.y + self.detalle.frame.size.height + kYOffset, self.barras.frame.size.width, yOffset);
//
    
    self.botonComenzar.frame = CGRectMake(self.botonComenzar.frame.origin.x, self.barras.frame.origin.y + self.barras.frame.size.height + kYOffset, self.botonComenzar.frame.size.width, self.botonComenzar.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.botonComenzar.frame.origin.y + self.botonComenzar.frame.size.height + kYOffset);
}

@end

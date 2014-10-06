//
//  ResultadoRepeticionView.h
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ResultadoRepeticionViewModoEjercicio = 0,
    ResultadoRepeticionViewModoTiempo,
}ResultadoRepeticionViewModo;

@interface ResultadoRepeticionView : UIView
@property (nonatomic,assign)ResultadoRepeticionViewModo modo;
@property (nonatomic,strong)NSNumber *valorEsperado;
@property (nonatomic,strong)NSNumber *valor;

@end

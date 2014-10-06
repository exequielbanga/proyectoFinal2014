//
//  Barra.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    BarraModoHorizontal = 0,
    BarraModoVertical,
}BarraModo;

@interface Barra : UIView

@property(nonatomic,assign)BarraModo mode;
@property(nonatomic,strong)UIColor  *color;
@property(nonatomic,strong)NSNumber *valor;// TODO: Por ahora No resalta, setear animadamente
@property(nonatomic,assign)BOOL showsText;
@property(nonatomic,strong)NSString *text; //Si no es seteado, muestra porcentaje
@property(nonatomic,assign)BOOL resaltar;

- (void)setValorAnimated:(NSNumber *)valor;

@end

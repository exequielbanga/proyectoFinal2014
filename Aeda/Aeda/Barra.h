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
@class Barra;
@protocol BarraDelegate <NSObject>
- (void)barraWasTapped:(Barra *)barra;
@end

@interface Barra : UIView

@property(nonatomic,assign)BarraModo mode;
@property(nonatomic,strong)NSNumber *valor;// TODO: Por ahora No resalta, setear animadamente
@property(nonatomic,assign)BOOL showsText;
@property(nonatomic,strong)NSString *text; //Si no es seteado, muestra porcentaje
@property(nonatomic,assign)BOOL resaltar;
@property(nonatomic,assign)CGFloat tolerancia;//0..1
@property(nonatomic,weak)id<BarraDelegate>delegate;

@property(nonatomic,strong)UIColor  *color;

- (void)setValorAnimated:(NSNumber *)valor;

@end

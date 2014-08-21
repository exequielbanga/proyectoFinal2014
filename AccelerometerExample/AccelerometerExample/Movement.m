//
//  Movement.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "Movement.h"
#import "GiroscopeAndAccelerometerData.h"

@implementation Movement

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray new];
    }
    return self;
}

- (NSString *)description{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:data.description];
    }
    [string appendString:@"\n"];
    return string;
}

- (NSString *)separatedDescription{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendFormat:@"%@\n",data.description];
    }
    return string;
}


- (NSString *)rotationData{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:[self applyCrazyFunctionTo:[data rotationDescription]]];
    }
    [string appendString:@"\n"];
    return string;
}

- (NSString *)accelerationData{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:[self applyCrazyFunctionTo:[data accelerationDescription]]];
    }
    [string appendString:@"\n\n"];
    return string;
}

-(NSString *)applyCrazyFunctionTo:(NSString *)vector{
    NSString *vectorConPunto = [vector stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSArray *components = [vectorConPunto componentsSeparatedByString:@"/"];
    if (components.count!=3) {
        return @"";
    }
    
    float x = [components[0] floatValue];
    float y = [components[1] floatValue];
    float z = [components[2] floatValue];
    
    components = [[vectorConPunto stringByReplacingOccurrencesOfString:@"-" withString:@""] componentsSeparatedByString:@"/"];
    
    NSString *result = [NSString stringWithFormat:@"%@%.0f%@%.0f%@%.0f",(x<0)?@"0":@"1",[components[0] floatValue]*100000,(y<0)?@"0":@"1",[components[1] floatValue]*100000,(z<0)?@"0":@"1",[components[2] floatValue]*100000];
    
    return result;
}

- (double*)rotationScalars{
    double *scalars = (double *)malloc(sizeof(double)*self.data.count);
    
    double *aScalar = scalars;
    for (GiroscopeAndAccelerometerData *data in self.data) {
        NSString *string = [self applyCrazyFunctionTo:[data rotationDescription]];
        NSNumber *number = [[NSNumberFormatter new] numberFromString:string];
        *aScalar = [number doubleValue];
        aScalar++;
    }
    return scalars;
}

- (double*)accelerationScalars{
    int n = 3;
    double *scalars = (double *)malloc(sizeof(double)*self.data.count);
    
    double *aScalar = scalars;
    for (GiroscopeAndAccelerometerData *data in self.data) {
        //
        double resultado;
        char coordenadasConcatenadas[14];

        char * coordenadasStr[3];

        coordenadasStr[0] = getNPrimerosDigitos(data.acceleration.x, n);
        coordenadasStr[1] = getNPrimerosDigitos(data.acceleration.y, n);
        coordenadasStr[2] = getNPrimerosDigitos(data.acceleration.z, n);

        sprintf(coordenadasConcatenadas, "1%s%s%s", coordenadasStr[0], coordenadasStr[1], coordenadasStr[2]);
        
        resultado = convertirStringADouble(coordenadasConcatenadas);

        //
        *aScalar = resultado;
        aScalar++;
    }
    return scalars;
}


//// C Functions

char * convertirNumeroAString(double numero){
	size_t tamanio = 10;
	char * str = "";
    
	str = (char *)malloc(tamanio * sizeof(char));
	sprintf(str, "%f", numero);
    
	return str;
}

int quitarCaracterDeCadena(char * str, char caracter){
	int i = 0;
	
	while(i < strlen(str) && str[i] != caracter){
		i++;
	}
    
	if(i < strlen(str)){
		while(str[i] != '\0'){
			str[i] = str[i + 1];
            
			i++;
		}
	}
    
	return 0;
}

char * cortarCadenaNumerica(char * cadenaNumerica, int n){
	size_t tamanio = 10;
	char * str = "";
    
	str = (char *)malloc(tamanio * sizeof(char));
    
	sprintf( str, "%.4s", cadenaNumerica);
    
	return str;
}

double convertirStringADouble(char * strNumero){
	int i = 1;
	double newInteger;
	newInteger = (double)strNumero[0] - '0';
    
	while(strNumero[i] != '\0'){
		newInteger = (double)newInteger * 10;
		newInteger = (double)newInteger + (strNumero[i] - '0');
        
		i++;
	}
    
	return newInteger;
}

char * getNPrimerosDigitos(double numero, int n){
	char * strNumero = '\0';
    
	numero = fabs(numero);
	strNumero = convertirNumeroAString(numero);
	quitarCaracterDeCadena(strNumero, '.');
	strNumero = cortarCadenaNumerica(strNumero, n);
    
	return strNumero;
}

@end

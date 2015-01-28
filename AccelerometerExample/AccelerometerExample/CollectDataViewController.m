//
//  CollectDataViewController.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "CollectDataViewController.h"
#import "GiroscopeAndAccelerometerData.h"
#import "Movement.h"
#import "SNNeuralNet.h"
#import <CoreMotion/CoreMotion.h>

#define kBufferSize 10

@interface CollectDataViewController ()

@property(nonatomic,strong)CMMotionManager *motionManager;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)Movement *selectedMovement;
@property(nonatomic,assign)BOOL shouldSample;
@property(nonatomic,assign)NSTimeInterval samplingTimeInterval;
@property(nonatomic,strong)SNNeuralNet *net;
@property(nonatomic,assign)NSUInteger currentMin;
@property(nonatomic,assign)NSUInteger countChanges;
@property(nonatomic,assign)NSUInteger countReps;
@property(nonatomic,strong)IBOutlet UISegmentedControl *segmented;
@property(nonatomic,assign)BOOL recording;
@property(nonatomic,strong)NSMutableArray *dataBuffer;
@end

@implementation CollectDataViewController

- (void)loadMotionManager{
    self.motionManager = [CMMotionManager new];
}

- (void)updateSampleRate{
    [self.motionManager setGyroUpdateInterval:self.samplingTimeInterval];
    [self.motionManager setAccelerometerUpdateInterval:self.samplingTimeInterval];
    [self.motionManager setDeviceMotionUpdateInterval:self.samplingTimeInterval];
}

- (void)startProccessingData{
    [self.motionManager startGyroUpdates];
    [self.motionManager startAccelerometerUpdates];
    [self.motionManager startDeviceMotionUpdates];
}

- (void)takeSample{
    if (self.shouldSample) {
        GiroscopeAndAccelerometerData *newData = [GiroscopeAndAccelerometerData new];
        newData.acceleration = self.motionManager.accelerometerData.acceleration;
        newData.rotation = self.motionManager.gyroData.rotationRate;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            if (self.dataBuffer.count == kBufferSize) {
                self.dataBuffer.removeLastObject;
            }
            
            if (newData.acceleration.y != 0){ // Agregué este filtro porque si el buffer tiene ceros, no te das cuenta cuando se cambia de signo
                [self.dataBuffer insertObject:@(newData.acceleration.y) atIndex:0];
            }
            
            BOOL change = NO;
            if (self.dataBuffer.count == kBufferSize) {
                NSMutableArray *negativos = [NSMutableArray new];
                for (NSNumber *numero in self.dataBuffer) {
                    if ([numero floatValue]<0) {
                        [negativos addObject:numero];
                    }
                }
                if (negativos.count >= (self.dataBuffer.count*.3) && negativos.count <= (self.dataBuffer.count*.7)) {//Por ejemplo, si la cantidad de negativos está entre el 30% y el 70%
                    change = YES;
                }
            }
            
            if(change){
                self.countChanges++;
                if (self.countChanges % 2) {
                    self.countReps++;
                    NSLog(@"CHANGE %lu", (unsigned long)self.countReps);
                }
                
                self.dataBuffer.removeAllObjects;
            }
            
            
            
            
        });
        
        
        
        
        [[(Movement *)[self.data lastObject] data] addObject:newData];
    }
}
- (void)addNewMovement{
    [self.data addObject:[Movement new]];
}

-(IBAction)startStop{
    self.recording = !self.recording;
    if (self.recording)
        [self startPressingButton];
    else
        [self endPressingButton];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.recording = NO;
    self.samplingTimeInterval = 1.0/50;
    [self.button setTargetForBeginTouch:self selector:@selector(startPressingButton)];
    [self.button setTargetForEndTouch:self selector:@selector(endPressingButton)];
    self.shouldSample = NO;
    self.data = [NSMutableArray new];
    self.dataBuffer = [NSMutableArray new];
    self.countReps = 0;
    self.countChanges = 0;
    [self loadMotionManager];
    [self startProccessingData];
    
}

- (void)startPressingButton{
    [self addNewMovement];
    self.shouldSample = YES;
    [self updateSampleRate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.samplingTimeInterval target:self selector:@selector(takeSample) userInfo:nil repeats:YES];
    [self takeSample];
}

- (void)endPressingButton{
    [self.timer invalidate];
    self.shouldSample = NO;
    [self.tableView reloadData];
    self.countReps = 0;
}

- (IBAction)send{
    NSMutableString *string = [NSMutableString new];
    for (Movement *movement in self.data) {
        [string appendString:movement.description];
    }
    [string appendString:@"\nRotationData:\n"];
    
    for (Movement *movement in self.data) {
        [string appendString:[movement rotationData]];
    }
    [string appendString:@"\nAccelerationData:\n"];
    for (Movement *movement in self.data) {
        [string appendString:[movement accelerationData]];
    }
    
    NSArray* shareData = @[string];
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:shareData
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
    
}

- (IBAction)deleteLast{
    [self.data removeLastObject];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:17.0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Movement %d",(int)indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Samples: %d",(int)[[(Movement *)self.data[indexPath.row] data] count]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedMovement = self.data[indexPath.row];
}

- (IBAction)sliderChange:(UISlider *)slider{
    self.numberOfSamplesLabel.text = [NSString stringWithFormat:@"%.0f",slider.value];
    self.samplingTimeInterval = 1.0/slider.value;
}

- (IBAction)learn{
    BOOL rotation = NO;
    if (self.segmented.selectedSegmentIndex == 0) {
        rotation = YES;
    }
    
    [self normalizeData];
    
    int columnasEntrada = (int)[[(Movement *)self.data[0] data] count];
    int filas = (int)self.data.count;
    SNTrainingRecord *netData = (SNTrainingRecord*)malloc(sizeof(double*)*2*filas);
    
    
    for (Movement *movimiento in self.data) {
        SNTrainingRecord *movement = (netData+[self.data indexOfObject:movimiento]);
        
        movement->input = rotation?[movimiento rotationScalars]:[movimiento accelerationScalars];
        double output = ([self.data indexOfObject:movimiento])<(self.data.count/2)?1.0:0.0;
        
        movement->output = &output;
        
    }
    self.net = [[SNNeuralNet alloc] initWithInputs:columnasEntrada hiddenLayers:@[@(columnasEntrada)] outputs:1];
    [self.net train:netData numRecords:filas];
    //        self.net.maxIterations = 20000;  // maximum training iterations
    self.net.minError = 0.01;       // error threshold to reach
    if (self.net.isTrained) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lerned Baby ;)" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [self.tableView reloadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I can't learn :(" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)recognice{
    BOOL rotation = NO;
    
    if (self.selectedMovement && self.net) {
        if (self.segmented.selectedSegmentIndex == 0) {
            rotation = YES;
        }
        
        [self normalizeNewData];
        double *input = rotation?[self.selectedMovement rotationScalars]:[self.selectedMovement accelerationScalars];
        double *output = [self.net runInput:input];
        NSMutableString *message = [[NSMutableString alloc]initWithString:@"Inputs: \n"];
        for (NSInteger i = 0; i < self.selectedMovement.data.count; i++) {
            [message appendFormat:@"%.5f\n",input[i]];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Result: %.5f",output[0]] message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't start recognition" message:@"Please select a movement first, and be sure that the net has already learned" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}


- (void)normalizeData{
    NSInteger min = NSIntegerMax;
    for (Movement *movement in self.data) {
        if (movement.data.count < min) {
            min = movement.data.count;
        }
    }
    self.currentMin = min;
    for (Movement *movement in self.data) {
        NSInteger vectorsToDelete = movement.data.count - min;
        if (vectorsToDelete) {
            for (NSInteger i = movement.data.count/(vectorsToDelete+1); i < movement.data.count; i+=movement.data.count/(vectorsToDelete+1)) {
                [movement.data removeObjectAtIndex:i];
            }
        }
    }
}

- (void)normalizeNewData{
    for (Movement *movement in self.data) {
        NSInteger vectorsToDelete = movement.data.count - self.currentMin;
        if (vectorsToDelete) {
            for (NSInteger i = movement.data.count/(vectorsToDelete+1); i < movement.data.count; i+=movement.data.count/(vectorsToDelete+1)) {
                [movement.data removeObjectAtIndex:i];
            }
        }
    }
}

@end

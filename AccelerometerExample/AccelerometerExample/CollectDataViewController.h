//
//  CollectDataViewController.h
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeSampleButton.h"

@interface CollectDataViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property(nonatomic,strong)IBOutlet TakeSampleButton *button;
@property(nonatomic,strong)IBOutlet UILabel *numberOfSamplesLabel;

- (IBAction)send;
- (IBAction)deleteLast;
- (IBAction)sliderChange:(UISlider *)slider;
- (IBAction)recognice;
- (IBAction)startStop;

@end

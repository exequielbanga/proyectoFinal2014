//
// LoadingNextPageView.h
// MercadoLibre
//
// Created by Fabian Celdeiro on 9/17/12.
// Copyright (c) 2012 Casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingNextPageView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *separatorLine;

- (void)deleteSeparatorLine;

@end

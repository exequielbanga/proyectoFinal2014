//
// LoadingNextPageView.m
// MercadoLibre
//
// Created by Fabian Celdeiro on 9/17/12.
// Copyright (c) 2012 Casa. All rights reserved.
//

#import "LoadingNextPageView.h"

@implementation LoadingNextPageView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.isAccessibilityElement = YES;
		[self setBackgroundColor:[UIColor whiteColor]];
		self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self.activityIndicator setHidesWhenStopped:NO];
		[self.activityIndicator setFrame:CGRectMake(frame.size.width / 2 - self.activityIndicator.frame.size.width / 2,
		                                            frame.size.height / 2 - self.activityIndicator.frame.size.height / 2,
		                                            self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
		[self.activityIndicator startAnimating];
        self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

		self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 15, 1)];
        self.separatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		[self.separatorLine setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:1]];
		[self addSubview:self.separatorLine];

		[self addSubview:self.activityIndicator];
	}
	return self;
}

- (void)deleteSeparatorLine
{
	[self.separatorLine removeFromSuperview];
}

@end

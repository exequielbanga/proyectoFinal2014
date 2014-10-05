//
//  HomeMenuHeaderTableView.m
//  Allianz
//
//  Created by Matías Ginart on 7/29/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "HomeMenuHeaderTableView.h"
#import "ALMenuButton.h"
#import "HomeMenuHeaderItem.h"

#define kPageHeight 30
#define kButtonWidth 128
#define kButtonHeight 143
#define kYOffset 1
#define kYSeparator 12

@interface HomeMenuHeaderTableView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIView* separatorView;
@property (nonatomic, strong) NSArray* items;
@end

@implementation HomeMenuHeaderTableView

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items {
    self = [super initWithFrame:frame];
    if (self) {

        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];

        self.separatorView = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height - 1, self.frame.size.width - 15, 1)];
        self.separatorView.backgroundColor = [UIColor colorWithRed:0 green:45.f/255.f blue:105.f/255.f alpha:1];
        [self addSubview:self.separatorView];

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kPageHeight + 4, self.frame.size.width, kPageHeight)];
        [self.pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];

        self.items = items;
        [self setup];
    }
    return self;
}

- (void)changePage {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * self.pageControl.currentPage, 0) animated:YES];
}

- (void)setup {
    NSInteger numberOfItemsWidth = floor(self.scrollView.frame.size.width / kButtonWidth);
    CGFloat separator = (self.scrollView.frame.size.width - (numberOfItemsWidth*kButtonWidth)) / (numberOfItemsWidth + 1);
    CGFloat xOrigin = separator;
    CGFloat yOrigin = kYOffset;
    NSInteger currentPage = 1;

    for (NSUInteger index = 0; index < self.items.count; index++) {
        if (yOrigin + kButtonHeight > self.scrollView.frame.size.height) {
            currentPage++;
            yOrigin = kYOffset;
            xOrigin += self.scrollView.frame.size.width;
        }

        HomeMenuHeaderItem* item = self.items[index];
        ALMenuButton* button = [[ALMenuButton alloc] initWithFrame:CGRectMake(xOrigin, yOrigin, kButtonWidth, kButtonHeight)];
        button.backgroundColor = [UIColor clearColor];
        [button setIconImage:[UIImage imageNamed:item.imageName]];
        button.firstLineLabel.text = item.firstText;
        button.secondLineLabel.text = item.secondText;
        [button addTarget:item.target action:item.selector forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        xOrigin += separator + kButtonWidth;
        if (xOrigin + kButtonWidth > self.scrollView.frame.size.width * currentPage) {
            xOrigin = separator + (currentPage - 1) * self.scrollView.frame.size.width;
            yOrigin += kButtonHeight + kYSeparator;
        }
    }

    self.scrollView.contentSize = CGSizeMake(currentPage* self.scrollView.frame.size.width, 0);
    self.pageControl.numberOfPages = currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = floor((scrollView.contentOffset.x + scrollView.frame.size.width/2) / scrollView.frame.size.width) ;
}

@end

//
//  MisDatosTableViewHeader.m
//  Allianz
//
//  Created by Jonathan Banga on 28/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "MisDatosTableViewHeader.h"
#import "UIColor+ALColor.h"
#import "UIFont+ALFonts.h"

@implementation MisDatosTableViewHeader

+ (MisDatosTableViewHeader *)header {
    MisDatosTableViewHeader* viewToReturn = [[NSBundle mainBundle] loadNibNamed:@"MisDatosTableViewHeader" owner:self options:nil][0];
    return viewToReturn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textLabel.textColor = [UIColor ALBlueColor];
    self.textLabel.font = [UIFont allianzSansBoldWithSize:16];
}

- (void)setText:(NSString *)text{
    [super setText:[@"   " stringByAppendingString:text]];
}

@end

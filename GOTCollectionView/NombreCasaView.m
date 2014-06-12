//
//  NombreCasaView.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "NombreCasaView.h"

@implementation NombreCasaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configura];
    }
    return self;
}

- (void) configura
{
    self.nombre = [[UILabel alloc] initWithFrame:self.bounds];
    self.nombre.font = [UIFont fontWithName:@"Helvetica" size:40.0];
    self.nombre.textAlignment = NSTextAlignmentCenter;
    self.nombre.textColor = [UIColor whiteColor];
    [self addSubview:self.nombre];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nombre.frame = self.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

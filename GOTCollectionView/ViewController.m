//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"
#import "GotModel.h"

@interface ViewController ()
@property (nonatomic, strong) GotModel* modelo;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

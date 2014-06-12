//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"
#import "GotModel.h"
#import "Celda.h"
#import "Casa.h"
#import "Personaje.h"

@interface ViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) GotModel* modelo;
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(200, 200);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[Celda class] forCellWithReuseIdentifier:@"celda"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.modelo.casas.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Casa* casa = [self.modelo.casas objectAtIndex:section];
    return casa.personajes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Celda* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"celda" forIndexPath:indexPath];
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", personaje.imagen]];
    
    return cell;
}
@end

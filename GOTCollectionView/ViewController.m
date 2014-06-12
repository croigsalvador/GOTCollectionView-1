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
#import "NombreCasaView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) GotModel* modelo;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout* layoutVertical;
@property (nonatomic, strong) UICollectionViewFlowLayout* layoutHorizontal;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
    
    //Vertical
    self.layoutVertical = [[UICollectionViewFlowLayout alloc] init];
    self.layoutVertical.itemSize = CGSizeMake(200, 200);
    self.layoutVertical.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.layoutVertical.headerReferenceSize = CGSizeMake(100, 100);
    
    //Horizontal
    self.layoutHorizontal = [[UICollectionViewFlowLayout alloc] init];
    self.layoutHorizontal.itemSize = CGSizeMake(200, 200);
    self.layoutHorizontal.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.layoutHorizontal.headerReferenceSize = CGSizeMake(200, 100);
    self.layoutHorizontal.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layoutVertical];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[Celda class] forCellWithReuseIdentifier:@"celda"];
    [self.collectionView registerClass:[NombreCasaView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"nombreCasa"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

- (IBAction)cambioLayout:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.collectionView setCollectionViewLayout:self.layoutVertical animated:YES];
            break;
        case 1:
            [self.collectionView setCollectionViewLayout:self.layoutHorizontal animated:YES];
            break;
        default:
            break;
    }
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NombreCasaView* nombreCasaView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"nombreCasa" forIndexPath:indexPath];
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    nombreCasaView.nombre.text = casa.nombre;
    
    return nombreCasaView;
}



@end

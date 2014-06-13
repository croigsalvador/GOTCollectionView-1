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
#import "CoverFlowLayout.h"
#import "ZoomInLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) GotModel* modelo;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableSet* selectedCells;

@property (nonatomic, strong) UICollectionViewFlowLayout* layoutVertical;
@property (nonatomic, strong) UICollectionViewFlowLayout* layoutHorizontal;
@property (nonatomic, strong) ZoomInLayout* zoomInLayout;
@property (nonatomic, strong) CoverFlowLayout* coverFlow;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnTrash;
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
    self.layoutHorizontal.itemSize = CGSizeMake(100, 300);
    self.layoutHorizontal.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.layoutHorizontal.headerReferenceSize = CGSizeMake(200, 100);
    self.layoutHorizontal.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //Line
    self.zoomInLayout = [[ZoomInLayout alloc] init];

    //Coverflow
    self.coverFlow = [[CoverFlowLayout alloc] init];
    
    self.selectedCells = [[NSMutableSet alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layoutVertical];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.allowsMultipleSelection = YES;
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
        case 2:
            [self.collectionView setCollectionViewLayout:self.zoomInLayout animated:YES];
            break;
        case 3:
            [self.collectionView setCollectionViewLayout:self.coverFlow animated:YES];
            break;
        default:
            break;
    }
}

- (IBAction)btnTrahsPressed:(id)sender {
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:self.selectedCells.allObjects];

        for (int c = 0; c<self.modelo.casas.count; c++) {
            NSMutableIndexSet* indexSet = [[NSMutableIndexSet alloc] init];
            for (NSIndexPath* indexPath in self.selectedCells) {
                if(indexPath.section==c)
                    [indexSet addIndex:indexPath.row];
            }
            
            Casa* casa = [self.modelo.casas objectAtIndex:c];
            NSMutableArray *auxPersonajes = casa.personajes.mutableCopy;
            [auxPersonajes removeObjectsAtIndexes:indexSet];
            casa.personajes = auxPersonajes.copy;

        }
        
        self.selectedCells = [[NSMutableSet alloc] init];

    } completion:nil];
}

#pragma mark WaterFallLayout Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionViewLayout==self.waterFall) {
        Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
        Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row];
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", personaje.imagen]];
        return image.size;
    }
    
    return CGSizeMake(200, 200);
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedCells addObject:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedCells removeObject:indexPath];
}


@end

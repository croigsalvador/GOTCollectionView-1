//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"
#import "GotModel.h"

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
    layout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"celda"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"celda" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
@end

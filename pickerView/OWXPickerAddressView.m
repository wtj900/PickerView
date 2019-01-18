//
//  OWXPickerAddressView.m
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXPickerAddressView.h"
#import "OWXPickerAddressItemView.h"

#define RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

@interface OWXPickerAddressView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation OWXPickerAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([OWXPickerAddressItemView class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([OWXPickerAddressItemView class])];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
        layer.backgroundColor = RGB_HEX(0xEEEEEE, 1).CGColor;
        [self.layer addSublayer:layer];
        
    }
    return self;
}

- (void)setAddressPath:(NSArray<NSString *> * _Nullable)addressPath {
    
    _addressPath = [addressPath copy];
    if (!addressPath) {
        _addressPath = @[@"请选择"];
    }
    
    self.selectIndex = _addressPath.count - 1;
    [self reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_addressPath.count - 1 inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.addressPath.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OWXPickerAddressItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OWXPickerAddressItemView class]) forIndexPath:indexPath];
    [cell setTitle:self.addressPath[indexPath.row] select:indexPath.row == self.selectIndex];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake([OWXPickerAddressItemView titleWidth:self.addressPath[indexPath.row]], CGRectGetHeight(self.frame));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = indexPath.row;
    [collectionView reloadData];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    if (self.selectCallBackBlock) {
        self.selectCallBackBlock(indexPath.row);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

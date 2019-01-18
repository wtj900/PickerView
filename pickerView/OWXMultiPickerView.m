//
//  OWXMultiPickerView.m
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXMultiPickerView.h"
#import "OWXPickerModel.h"
#import "OWXPickerAddressView.h"
#import "OWXMultiUnitView.h"

@interface OWXMultiPickerView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<OWXPickerModel *> *dataSource;
@property (nonatomic, assign) BOOL isAutoSelect;
@property (nonatomic, copy) OWXMultipleResultBlock resultBlock;
@property (nonatomic, strong) OWXPickerAddressView *addressView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *path;
@property (nonatomic, strong) NSMutableArray<OWXPickerModel *> *pathValue;

@end

@implementation OWXMultiPickerView

+ (void)showMultiPickerWithTitle:(NSString *)title
                              dataSource:(NSArray<OWXPickerModel *> *)dataSource
                         defaultSelValue:(NSArray<NSNumber *> * _Nullable)defaultSelValue
                            isAutoSelect:(BOOL)isAutoSelect
                             resultBlock:(OWXMultipleResultBlock)resultBlock {
    
    OWXMultiPickerView *multiPickerView = [[OWXMultiPickerView alloc] initWithTitle:title dataSource:dataSource defaultSelValue:defaultSelValue isAutoSelect:NO resultBlock:resultBlock];
    [multiPickerView showWithAnimation:YES];
}

#pragma mark - 初始化自定义字符串选择器
- (instancetype)initWithTitle:(NSString *)title
                   dataSource:(NSArray<OWXPickerModel *> * _Nonnull)dataSource
              defaultSelValue:(NSArray<NSNumber *> * _Nullable)defaultSelValue
                 isAutoSelect:(BOOL)isAutoSelect
                  resultBlock:(OWXMultipleResultBlock)resultBlock {
    
    if (self = [super init]) {
        self.title = title;
        self.dataSource = dataSource;
        self.isAutoSelect = isAutoSelect;
        self.resultBlock = resultBlock;
        self.path = defaultSelValue ? [defaultSelValue mutableCopy] : [NSMutableArray new];
        self.pathValue = [self getPathValue];
        [self initUI];
        [self update];
    }
    return self;
}

- (NSMutableArray *)getPathValue {
    
    NSMutableArray *tempPathValue = [[NSMutableArray alloc] initWithCapacity:self.path.count];
    if (self.path.count <= 0) {
        return tempPathValue;
    }
    
    __block NSArray<OWXPickerModel *> *dataSource = self.dataSource;
    [self.path enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OWXPickerModel *model = [self objectOrNilInArray:dataSource atIndex:obj.integerValue];
        if (model) {
            [tempPathValue addObject:model];
            dataSource = model.sub;
        }
        else {
            *stop = YES;
        }
    }];
    
    return tempPathValue;
}

#pragma mark - 初始化子视图
- (void)initUI {
    [super initUI];
    self.titleLabel.text = self.title;
    [self.alertView addSubview:self.addressView];
    [self.alertView addSubview:self.collectionView];
}

- (void)update {
    
    if (self.pathValue.count <= 0) {
        self.addressView.addressPath = nil;
    }
    else {
        OWXPickerModel *model = self.pathValue.lastObject;
        NSMutableArray *addressPath = [self addressPaths];
        if (model.sub.count > 0) {
            [addressPath addObject:@"请选择"];
        }
        self.addressView.addressPath = addressPath;
    }
    
    [self.collectionView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.path.count - 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}

- (NSMutableArray *)addressPaths {
    
    NSMutableArray *paths = [[NSMutableArray alloc] initWithCapacity:self.pathValue.count];
    [self.pathValue enumerateObjectsUsingBlock:^(OWXPickerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paths addObject:obj.name];
    }];
    
    return paths;
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kPickerHeight + kTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
    
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kPickerHeight + kTopViewHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MAX(self.path.count + 1, 2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak __typeof(self) weakSelf = self;
    
    OWXMultiUnitView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OWXMultiUnitView class]) forIndexPath:indexPath];
    
    cell.selectCallBackBlock = ^(OWXPickerModel *model, NSInteger index) {
        [weakSelf pickerSelectAction:model selectRow:indexPath.row selectIndex:index];
    };
    
    if (0 == indexPath.row) {
        [cell setDataSource:self.dataSource selectIndex:[self valueInArray:self.path atIndex:indexPath.row]];
    }
    else {
        if (self.path.count <= 0) {
            [cell setDataSource:nil selectIndex:NSNotFound];
        }
        else {
            __block NSArray<OWXPickerModel *> *dataSource = self.dataSource;
            [self.path enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dataSource = dataSource[obj.integerValue].sub;
                if (idx == indexPath.row - 1) {
                    *stop = YES;
                }
            }];
            
            [cell setDataSource:dataSource selectIndex:[self valueInArray:self.path atIndex:indexPath.row]];
        }
    }
    
    cell.backgroundColor = indexPath.row % 2 ? [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1.0] : [UIColor whiteColor];
    return cell;
    
}

- (void)pickerSelectAction:(OWXPickerModel *)model selectRow:(NSInteger)selectRow selectIndex:(NSInteger)selectIndex {
    
    NSInteger pathPosition = [self valueInArray:self.path atIndex:selectRow];
    if (NSNotFound == pathPosition) {
        [self.path addObject:@(selectIndex)];
        [self.pathValue addObject:model];
    }
    else if (pathPosition != selectIndex) {
        NSRange removeRange = NSMakeRange(selectRow, self.path.count - selectRow);
        [self.path removeObjectsInRange:removeRange];
        [self.path addObject:@(selectIndex)];
        [self.pathValue removeObjectsInRange:removeRange];
        [self.pathValue addObject:model];
    }
    else {
        return;
    }
    
    NSMutableArray *addressPath = [self addressPaths];
    
    if (model.sub.count > 0) {
        
        [addressPath addObject:@"请选择"];
        
        [self.collectionView setContentOffset:CGPointMake(selectRow * SCREEN_WIDTH * 0.5, 0) animated:YES];
        [self.collectionView reloadData];
    }
    else {
        if (self.resultBlock) {
            self.resultBlock(self.path, self.pathValue);
        }
        
        [self dismissWithAnimation:YES];
    }
    
    self.addressView.addressPath = addressPath;
}

- (NSInteger)valueInArray:(NSArray *)array atIndex:(NSUInteger)index {
    id object = [self objectOrNilInArray:array atIndex:index];
    return object ? [object integerValue] : NSNotFound;
}

- (id)objectOrNilInArray:(NSArray *)array atIndex:(NSUInteger)index {
    return index < array.count ? array[index] : nil;
}

- (OWXPickerAddressView *)addressView {
    if (!_addressView) {
        __weak __typeof(self) weakSelf = self;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, kTopViewHeight);
        _addressView = [[OWXPickerAddressView alloc] initWithFrame:frame];
        _addressView.selectCallBackBlock = ^(NSInteger index) {
            [weakSelf.collectionView setContentOffset:CGPointMake(MAX(index - 1, 0) * SCREEN_WIDTH * 0.5, 0) animated:YES];
        };
    }
    return _addressView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kTopViewHeight * 2, SCREEN_WIDTH, self.alertView.frame.size.height - kTopViewHeight * 2);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(frame.size.width * 0.5, frame.size.height);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OWXMultiUnitView class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([OWXMultiUnitView class])];
    }
    return _collectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
